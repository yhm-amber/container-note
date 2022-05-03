
## 开始之前需要明确的提要

- [RKE2](https://docs.rke2.io/) 是一个 Kubernetes 发行版， K3S 是又一个，二者有类似的地方。
- [Rancher](../rancher-note) 是一个 Kubernetes 管理系统，需要用 `helm` 安在 Kubernetes 上（这还需要这个 Kubernetes 已经准备好足够的东西）或者采用 Docker 的方式（但这其实是把容器当节点并在里面做同样的事情），可以管理包括自身被部署集群在内的多个 Kubernetes 集群。
- 上述的 RKE2 、 K3S 、 Rancher 都是组织 RancherLab 的作品；上述的 Kubernetes 并不是值一样具体的容器编排系统产品，而是指一类这样的产品。

## 快速开始

### 0. 步骤简述

大体的安装过程是这样的：

1. 先完成一个单节点集群的启动
2. 然后再加入 `server` 或 `agent` 节点
3. 要让 `server` 保持奇数

下面由于有「漫长等待」的情况，所以为防止中断，我是在 `screen` 中做的这些工作。这并不是必要的手段，但建议用上。

这是我的笔记。我会对软件的安装方案有我自己的看法，并在我认为必要的位置记下我认为必要的理论上可用的改进手段。

### 1. 单节点启动

ref: https://docs.rancher.cn/docs/rke2/install/quickstart/_index

他们分发软件是靠脚本完成的。

脚本做的事情，[在这里](https://docs.rancher.cn/docs/rke2/install/methods/_index)是这么说的：

> 当安装脚本被执行时，它会判断它是什么类型的系统。如果它是一个使用 RPM 的操作系统（比如 CentOS 或 RHEL），它将执行基于 RPM 的安装，否则脚本会默认为 tarball。基于 RPM 的安装将在下面介绍。
> 
> 接下来，安装脚本下载 tarball，通过比较 SHA256 哈希值进行验证，最后将内容提取到/usr/local。如果需要，操作者可以在安装后自由移动文件。这个操作只是提取 tarball，并没有做其他系统的修改。
> 

除了选择安装方式和验证安装包以外，就是注册服务了。

下面做离线安装的演示。所有必要的离线文件都放在当前目录的 `rke2-artifacts` 目录下。

我的命令：

~~~ sh
: 通过能够连通外网的节点取得安装脚本
ssh 10.11.111.101 -- curl -sfL http://rancher-mirror.rancher.cn/rke2/install.sh | tee rke2-artifacts/install.sh
: 然后在 snapper 的对快照的监控下使用 cat rke2-artifacts/install.sh | RKE2_CNI=calico INSTALL_RKE2_ARTIFACT_PATH=rke2-artifacts sh - 这一安装命令
snapper create -d 'rke2 calico' --command 'cat rke2-artifacts/install.sh | RKE2_CNI=calico INSTALL_RKE2_ARTIFACT_PATH=rke2-artifacts sh -'
~~~

在经过如上的步骤实际用命令 `cat rke2-artifacts/install.sh | RKE2_CNI=calico INSTALL_RKE2_ARTIFACT_PATH=rke2-artifacts sh -` 开始并完成安装后，这是我得到的屏幕输出：

~~~ text
[WARN]  /usr/local is read-only or a mount point; installing to /opt/rke2
[INFO]  staging local checksums from rke2-artifacts/sha256sum-amd64.txt
[INFO]  staging zst airgap image tarball from rke2-artifacts/rke2-images.linux-amd64.tar.zst
[INFO]  staging tarball from rke2-artifacts/rke2.linux-amd64.tar.gz
[INFO]  verifying airgap tarball
grep: /tmp/rke2-install.1u6e2nK7JX/rke2-images.checksums: No such file or directory
[INFO]  installing airgap tarball to /var/lib/rancher/rke2/agent/images
[INFO]  verifying tarball
[INFO]  unpacking tarball file to /opt/rke2
[INFO]  updating tarball contents to reflect install path
[INFO]  moving systemd units to /etc/systemd/system
[INFO]  install complete; you may want to run:  export PATH=$PATH:/opt/rke2/bin
~~~

对于脚本，这几个选项（变量）可能对你比较重要：

- 选择安装源： `INSTALL_RKE2_MIRROR=cn` （这个是 [`cn`](http://rancher-mirror.rancher.cn/rke2/install.sh) 来源脚本特有的功能）
- 选择离线包目录： `INSTALL_RKE2_ARTIFACT_PATH=/root/rke2-artifacts` （离线包下载[见这里](https://github.com/rancher/rke2/releases)）
- 决定节点类型： `INSTALL_RKE2_TYPE=agent` （这个变量空着的话值就默认是 `server` 了）
- 选择网络插件： `RKE2_CNI=calico` （它等于脚本的 `--cni` 选项）

基于 `snapper` 的监控结果（详细见后文）来看，新增的配置性文件就是在 `/etc/systemd/system` 目录下的 `rke2-agent.service` 和 `rke2-server.service` 。

这个和 ref 里提到的脚本会做的事基本相符。也就是说，脚本的工作是可以用容器方案代替的。

他们对于特定系统当然也有使用包管理器的方案。不过不论哪种，其实都不如直接拉取镜像创建容器来得好的。

*——如果分发部署能容器化的话，什么注册服务、部署二进制，就只是镜像拉取而已了。单次执行就是 `run --rm` ，常驻就是 `run -d` ，下载就是 `pull` ，想离线就 `save` 然后 `load` 。验证和系统兼容的方面自然都是无需考虑。对用户提供的也只需要是如何使用镜像的命令而已，而不是一个复杂到没边儿的「脚本」。想要注册成可被 `systemctl` 控制的服务也不是不可以，甚至 `.service` 文件的内容也可以通过运行容器里的某个二进制给生成出来；并且服务停止命令也不需要是粗暴地杀死特定名称的进程了，而只要把那几个特定名称的常驻后台容器停止就好。而且整个过程中也不需要改变容器的数据目录以外的目录，不会对系统产生难以追踪的影响。可见，**如何正确发放软件**， Docker 公司的人们给出的方案是专业的。他们是做得好啊。*

接下来，必要的端口开放：

~~~ sh
snapper create -d 'pub rke2 9345 6443' --command '
    firewall-cmd --zone=public --add-port=9345/tcp --add-port=9345/udp --add-port=6443/tcp --permanent '
: 刷新配置
sudo systemctl reload firewalld
: 检查
sudo firewall-cmd --zone=public --list-ports --permanent
~~~

然后就可以启动 `rke2-server.service` 服务了。对于目前的 RKE2 ，首次启动该服务就是对集群的安装，所以这个启动我也会用 `snapper` 的对快照监控起来。

首次启动会受 `/etc/rancher/rke2/config.yaml` 影响。如果要增加新的节点就要有这个文件，而且要编辑好，创建集群的第一个节点则不需要有它。

~~~ sh
snapper create -d 'rke2 first server start' --command 'systemctl start rke2-server.service'
~~~

如果不是离线安装（离线安装就是赋值了 `INSTALL_RKE2_ARTIFACT_PATH=rke2-artifacts` 这个选项），你会等很久。

等待时，可以在同一个节点的另一个 SHell 上用 `journalctl -u rke2-server -f` 查看日志。

基于 `snapper` 监控的结果可知，对于系统配置方面，这个过程会新增以下文件和目录：

~~~ text
+..... /etc/cni
+..... /etc/cni/net.d
+..... /etc/rancher
+..... /etc/rancher/node
+..... /etc/rancher/node/password
+..... /etc/rancher/rke2
+..... /etc/rancher/rke2/rke2.yaml
~~~

除此以外，还会增加一些二进制（在默认的系统快照配置方案下这些不会被追踪到）。

然后你就可以像这样验证，这第一个节点，是否 `Ready` 了：

~~~ sh
/var/lib/rancher/rke2/bin/kubectl --kubeconfig /etc/rancher/rke2/rke2.yaml get no
~~~

或者，使用别的等价的方式，比如做好必要的 `PATH` 变更或软链接增加，并把 `/etc/rancher/rke2/rke2.yaml` 这个 `kubeconfig` 文件写入到 `~/.kube/config` 里（记得把它的权限变成 `chmod 400` 哦）。

更多信息（来自 ref 链接）：

> 运行此安装程序后：
> 
> - `rke2-server` 服务将被安装。 `rke2-server` 服务将被配置为在节点重启后或进程崩溃或被杀时自动重启。
> - 其他的实用程序将被安装在 `/var/lib/rancher/rke2/bin/` 。它们包括 `kubectl` , `crictl` , 和 `ctr` 。注意，这些东西默认不在你的路径上。
> - 还有两个清理脚本会安装到 `/usr/local/bin/rke2` 的路径上。它们是 `rke2-killall.sh` 和 `rke2-uninstall.sh` 。
> - 一个 `kubeconfig` 文件将被写入 `/etc/rancher/rke2/rke2.yaml` 。
> - 一个可用于注册其他 `server` 或 `agent` 节点的令牌将在 `/var/lib/rancher/rke2/server/node-token` 文件中创建。
> 

### 2. 增加 `server` 节点

其实就是高可用。

注意要奇数。

ref: https://docs.rancher.cn/docs/rke2/install/ha/_index

和前一步区别是，在启动 `rke2-server.service` 服务之前，请先创建 `/etc/rancher/rke2/config.yaml` （和它的所在目录），并在其中加入以下内容：

~~~ yaml
server: https://<server>:9345
token: <token from server node>
tls-san:
  - <ip>
  - <domain>
  - ...
~~~

其中：

- 在 `<server>` 处要写能够访问到第一个 `server` 的 IP 或者域名。
- 在 `<token from server node>` 处的内容就是它要加入的节点的 `/var/lib/rancher/rke2/server/node-token` 文件的内容。
- 而 `<ip>` 和 `<domain>` 处就写能够访问到被加入集群的 `server` 的 IP 或者域名（不需要端口号）。

最好给第一个 `server` 也创建这样一个配置，并重启它。

### 3. 增加 `agent` 节点

这个在[快速开始的下面部分](https://docs.rancher.cn/docs/rke2/install/quickstart/_index#linux-agent%EF%BC%88worker%EF%BC%89%E8%8A%82%E7%82%B9%E7%9A%84%E5%AE%89%E8%A3%85)。

和 `server` 的不同就是：

- 脚本的执行器 `sh` 前面多加一个 `INSTALL_RKE2_TYPE=agent` ；
- 需要操作的服务名这次是 `rke2-agent.service` ；
- 在初次启动这个服务前务必要先创建 `/etc/rancher/rke2/config.yaml` （包括它的所在目录）然后根据你的情况填入以下内容：
  
  ~~~ yaml
  server: https://<server>:9345
  token: <token from server node>
  ~~~
  
  其中：
  
  - 在 `<token from server node>` 处的内容就是它要加入的节点的 `/var/lib/rancher/rke2/server/node-token` 文件的内容。
  - 在 `<server>` 处要写能够访问到被加入集群的 `server` 的 IP 或者域名。
  
*跟增加 `server` 比，除了要用到的服务二进制（或启动模式）不同外也没有别的不同。需要事先准备的配置文件也几乎一样。*

Windows 节点上的 `agent` 安装见原文。

### 用 `snapper` 监视得到的

这个 `snapper` 是一个来自 SUSE 组织的工具，它可以让你很方便地使用文件系统的快照功能。

在 `openSUSE Leap 15.2` 发行版中，默认配置（ `root` ）下的系统快照，只会去监视所有配置性的目录，不会管二进制甚至是数据的目录。

这里详细描述一下我是怎么用它的。

下文基于前面创建第一个节点的步骤。整个过程中使用了三次对快照的创建，被监控的动作分别是：

- 脚本执行： `cat rke2-artifacts/install.sh | RKE2_CNI=calico INSTALL_RKE2_ARTIFACT_PATH=rke2-artifacts sh -`
- 端口开放： `firewall-cmd --zone=public --add-port=9345/tcp --add-port=9345/udp --add-port=6443/tcp --permanent`
- 服务首启： `systemctl start rke2-server.service`

这是三者完成以后，我的 `snapper list` 的输出内容：

~~~ text
 # | Type   | Pre # | Date                            | User | Used Space | Cleanup | Description             | Userdata
---+--------+-------+---------------------------------+------+------------+---------+-------------------------+--------------
0  | single |       |                                 | root |            |         | current                 |
1* | single |       | Thu 07 Apr 2022 04:26:00 PM CST | root | 436.00 KiB |         | first root filesystem   |
2  | single |       | Thu 07 Apr 2022 04:39:31 PM CST | root |  28.27 MiB | number  | after installation      | important=yes
3  | pre    |       | Tue 03 May 2022 11:06:07 PM CST | root |   1.77 MiB |         | rke2 calico             |
4  | post   |     3 | Tue 03 May 2022 11:06:18 PM CST | root |  16.00 KiB |         | rke2 calico             |
5  | pre    |       | Tue 03 May 2022 11:14:25 PM CST | root |  16.00 KiB |         | pub rke2 9345 6443      |
6  | post   |     5 | Tue 03 May 2022 11:14:26 PM CST | root | 160.00 KiB |         | pub rke2 9345 6443      |
7  | pre    |       | Tue 03 May 2022 11:41:03 PM CST | root | 320.00 KiB |         | rke2 first server start |
8  | post   |     7 | Tue 03 May 2022 11:44:33 PM CST | root | 176.00 KiB |         | rke2 first server start |
~~~

下文基于它来检查发生的变化。

#### 脚本执行

根据之前给 `-d` 的备注信息 `rke2 calico` 可以看到，这个阶段的对快照的序号分别是 `3` 和 `4` 。

那么用 `snapper status 3..4` 就能看到这期间的系统配置变化：

~~~ text
+..... /etc/systemd/system/rke2-agent.service
+..... /etc/systemd/system/rke2-server.service
~~~

就是说，对于系统配置而言，变化只有这些。

在这个位置增加 `.service` 文件就是注册服务。

分别看看它们的内容吧：

##### `rke2-agent.service`

~~~ service
[Unit]
Description=Rancher Kubernetes Engine v2 (agent)
Documentation=https://github.com/rancher/rke2#readme
Wants=network-online.target
After=network-online.target
Conflicts=rke2-server.service

[Install]
WantedBy=multi-user.target

[Service]
Type=notify
EnvironmentFile=-/etc/default/%N
EnvironmentFile=-/etc/sysconfig/%N
EnvironmentFile=-/opt/rke2/lib/systemd/system/%N.env
KillMode=process
Delegate=yes
LimitNOFILE=1048576
LimitNPROC=infinity
LimitCORE=infinity
TasksMax=infinity
TimeoutStartSec=0
Restart=always
RestartSec=5s
ExecStartPre=/bin/sh -xc '! /usr/bin/systemctl is-enabled --quiet nm-cloud-setup.service'
ExecStartPre=-/sbin/modprobe br_netfilter
ExecStartPre=-/sbin/modprobe overlay
ExecStart=/opt/rke2/bin/rke2 agent
ExecStopPost=-/bin/sh -c "systemd-cgls /system.slice/%n | grep -Eo '[0-9]+ (containerd|kubelet)' | awk '{print $1}' | xargs -r kill"
~~~

##### `rke2-server.service`

~~~ service
[Unit]
Description=Rancher Kubernetes Engine v2 (server)
Documentation=https://github.com/rancher/rke2#readme
Wants=network-online.target
After=network-online.target
Conflicts=rke2-agent.service

[Install]
WantedBy=multi-user.target

[Service]
Type=notify
EnvironmentFile=-/etc/default/%N
EnvironmentFile=-/etc/sysconfig/%N
EnvironmentFile=-/opt/rke2/lib/systemd/system/%N.env
KillMode=process
Delegate=yes
LimitNOFILE=1048576
LimitNPROC=infinity
LimitCORE=infinity
TasksMax=infinity
TimeoutStartSec=0
Restart=always
RestartSec=5s
ExecStartPre=/bin/sh -xc '! /usr/bin/systemctl is-enabled --quiet nm-cloud-setup.service'
ExecStartPre=-/sbin/modprobe br_netfilter
ExecStartPre=-/sbin/modprobe overlay
ExecStart=/opt/rke2/bin/rke2 server
ExecStopPost=-/bin/sh -c "systemd-cgls /system.slice/%n | grep -Eo '[0-9]+ (containerd|kubelet)' | awk '{print $1}' | xargs -r kill"
~~~

#### 开放端口

根据之前给 `-d` 的备注信息 `pub rke2 9345 6443` 可以看到，这个阶段的对快照的序号分别是 `5` 和 `6` 。

那么用 `snapper status 5..6` 就能看到这期间的系统配置变化：

~~~ text
c..... /etc/firewalld/zones/public.xml
c..... /etc/firewalld/zones/public.xml.old
~~~

就是说，对于系统配置而言，变化只有这些。

这就是 `firewall-cmd` 命令的效果。

内容：

##### `public.xml`

~~~ xml
<?xml version="1.0" encoding="utf-8"?>
<zone>
  <short>Public</short>
  <description>For use in public areas. You do not trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.</description>
  <service name="ssh"/>
  <service name="dhcpv6-client"/>
  <port port="9345" protocol="tcp"/>
  <port port="9345" protocol="udp"/>
  <port port="6443" protocol="tcp"/>
</zone>
~~~

这里面我们可以看到我们加入的规则。

我们可以用 `snapper diff 5..6 /etc/firewalld/zones/public.xml` 看到具体的改变：

~~~ text
--- /.snapshots/5/snapshot/etc/firewalld/zones/public.xml       2022-04-07 16:36:26.836000000 +0800
+++ /.snapshots/6/snapshot/etc/firewalld/zones/public.xml       2022-05-03 23:14:26.302837842 +0800
@@ -4,4 +4,7 @@
   <description>For use in public areas. You do not trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.</description>
   <service name="ssh"/>
   <service name="dhcpv6-client"/>
+  <port port="9345" protocol="tcp"/>
+  <port port="9345" protocol="udp"/>
+  <port port="6443" protocol="tcp"/>
 </zone>
~~~

##### `public.xml.old`

~~~ xml
<?xml version="1.0" encoding="utf-8"?>
<zone>
  <short>Public</short>
  <description>For use in public areas. You do not trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.</description>
  <service name="ssh"/>
  <service name="dhcpv6-client"/>
  <port port="9345" protocol="tcp"/>
  <port port="9345" protocol="udp"/>
</zone>
~~~

似乎，一次 `firewall-cmd` 有多个 `--add-port` 出现的话，就会被细化成多次 `firewall-cmd` 命令的等效。

所以才导致 `.old` 文件只会记录上一次的一个小的变化。

当然这只是猜测。

我们可以用 `snapper diff 5..6 /etc/firewalld/zones/public.xml.old` 看到具体的改变：

~~~ text
--- /.snapshots/5/snapshot/etc/firewalld/zones/public.xml.old   2022-04-07 16:36:26.424000000 +0800
+++ /.snapshots/6/snapshot/etc/firewalld/zones/public.xml.old   2022-05-03 23:14:26.302837842 +0800
@@ -4,4 +4,6 @@
   <description>For use in public areas. You do not trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.</description>
   <service name="ssh"/>
   <service name="dhcpv6-client"/>
+  <port port="9345" protocol="tcp"/>
+  <port port="9345" protocol="udp"/>
 </zone>
~~~

可以确定的是，一个有仨 `--add-port` 的 `firewall-cmd` 命令，会让这个 `.old` 文件也多出两行来。

#### 服务启动

根据之前给 `-d` 的备注信息 `rke2 first server start` 可以看到，这个阶段的对快照的序号分别是 `7` 和 `8` 。

那么用 `snapper status 7..8` 就能看到这期间的系统配置变化：

~~~ text
+..... /etc/cni
+..... /etc/cni/net.d
+..... /etc/rancher
+..... /etc/rancher/node
+..... /etc/rancher/node/password
+..... /etc/rancher/rke2
+..... /etc/rancher/rke2/rke2.yaml
~~~

就是说，对于系统配置而言，变化只有这些。

这就是 `systemctl start rke2-server.service` 命令在阻塞期间新增的东西。

其实只有三样： `/etc/cni/net.d` `/etc/rancher/node/password` `/etc/rancher/rke2/rke2.yaml` 。

后两者，一个是非明文了的密码，另一个就是本集群的 `kubeconfig` 。

其中，在这个命令完成后，在 `/etc/cni/net.d` 内会出现 `10-canal.conflist` 和 `calico-kubeconfig` 两个文件。

内容：

##### `10-canal.conflist`

~~~ json
{
  "name": "k8s-pod-network",
  "cniVersion": "0.3.1",
  "plugins": [
    {
      "type": "calico",
      "log_level": "info",
      "datastore_type": "kubernetes",
      "nodename": "opensuse-1",
      "mtu": 1450,
      "ipam": {
          "type": "host-local",
          "ranges": [
              [
                  {
                      "subnet": "usePodCidr"
                  }
              ]
          ]
      },
      "policy": {
          "type": "k8s"
      },
      "kubernetes": {
          "kubeconfig": "/etc/cni/net.d/calico-kubeconfig"
      }
    },
    {
      "type": "portmap",
      "snat": true,
      "capabilities": {"portMappings": true}
    },
    {
      "type": "bandwidth",
      "capabilities": {"bandwidth": true}
    }
  ]
}
~~~

##### `calico-kubeconfig`

~~~ yaml
# Kubeconfig file for Calico CNI plugin.
apiVersion: v1
kind: Config
clusters:
- name: local
  cluster:
    server: https://[10.43.0.1]:443
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJlRENDQVIrZ0F3SUJBZ0lCQURBS0JnZ3Foa2pPUFFRREFqQWtNU0l3SUFZRFZRUUREQmx5YTJVeUxYTmwKY25abGNpMWpZVUF4TmpVeE5Ua3lORFl6TUI0WERUSXlNRFV3TXpFMU5ERXdNMW9YRFRNeU1EUXpNREUxTkRFdwpNMW93SkRFaU1DQUdBMVVFQXd3WmNtdGxNaTF6WlhKMlpYSXRZMkZBTVRZMU1UVTVNalEyTXpCWk1CTUdCeXFHClNNNDlBZ0VHQ0NxR1NNNDlBd0VIQTBJQUJLM0I1aUdQc3BITUJZS01oUnVGeUw1NTJKd1Q0SlFnL1RLc0piOUMKaUk3Z2FWNzR0SDBkN0gwUXJJLzN6N3VQQTNxSG5vSWpTcUNIL0FiczFhdVVXSWFqUWpCQU1BNEdBMVVkRHdFQgovd1FFQXdJQ3BEQVBCZ05WSFJNQkFmOEVCVEFEQVFIL01CMEdBMVVkRGdRV0JCU0dPUUpiRVNlVzBBZmQ5dkZzCkdNY0dQeThZQ3pBS0JnZ3Foa2pPUFFRREFnTkhBREJFQWlBemJUMThxZnc4UWZMUUxvdUl0NnpXaFQrbEp1ZzQKRmpYaC9qUHpRS3Q1TGdJZ0dEMGt3ZTBEYldIZFRJOE9zZThlL0Q4VzhwTjNMM2VEdjdGNm0xS1V6SDA9Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
users:
- name: calico
  user:
    token: eyJhbGciOiJSUzI1NiIsImtpZCI6Im9kRHl6MDNaZ2taMnAxYzBIM0VyWVlNcTBiSlNWakt4M0lRUnUxZU5NTzgifQ.eyJhdWQiOlsiaHR0cHM6Ly9rdWJlcm5ldGVzLmRlZmF1bHQuc3ZjLmNsdXN0ZXIubG9jYWwiLCJya2UyIl0sImV4cCI6MTY4MzEyODcwNiwiaWF0IjoxNjUxNTkyNzA2LCJpc3MiOiJodHRwczovL2t1YmVybmV0ZXMuZGVmYXVsdC5zdmMuY2x1c3Rlci5sb2NhbCIsImt1YmVybmV0ZXMuaW8iOnsibmFtZXNwYWNlIjoia3ViZS1zeXN0ZW0iLCJwb2QiOnsibmFtZSI6InJrZTItY2FuYWwtNHpwOWgiLCJ1aWQiOiIzN2NhNGI4OS05YWEzLTQ4NzgtYTBmNC03OTk0MDZhNTIxNzkifSwic2VydmljZWFjY291bnQiOnsibmFtZSI6ImNhbmFsIiwidWlkIjoiYTkyNjE3MzctMmNiZC00NmQxLTk2NWUtZGM5NWZjNzk0ZmQ1In0sIndhcm5hZnRlciI6MTY1MTU5NjMxM30sIm5iZiI6MTY1MTU5MjcwNiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50Omt1YmUtc3lzdGVtOmNhbmFsIn0.bejLr2Ryp6WFeTvfuu4cb3KhgK3srl3mi7PrKfvs7WoOLH_lP2gY1wF5sZGpB9Y6J1dhET_U1Gw-pBuICz6z-8gf15fxobM5RKou230lUkxMbahP2MLbkDIDyCn09-si7jG4JnMnQBcQS6rzc49ZMpDW1FESszFHP3QtUmtLCGtonVNLnLfh3zaBek64n9FB-Y4l3fDT-4kmN7qRQDkdAXljP_PQTpEMg7qmDD1P5bXUeHi3lZ_lM0oALprgwgoqf0MZ5_e9z5zLN4QJRTu6nu01H0IF8KZD3frzaad-bJa-pRX1-v1w19etFL3Ql3zR0urtQqUGveKLvOqfCDmW_g
contexts:
- name: calico-context
  context:
    cluster: local
    user: calico
current-context: calico-context
~~~



