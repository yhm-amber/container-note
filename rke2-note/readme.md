
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

### 基于 `snapper` 的监视结果

这是一个来自 SUSE 组织的工具，可以很方便地使用文件系统的快照功能。

在 `openSUSE Leap 15.2` 发行版中，默认配置（ `root` ）下的系统快照，只会去监视所有配置性的目录，不会管二进制甚至是数据的目录。

#### 脚本

我是在 `snapper create -d 'rke2 sh' --command bash` 中做了执行脚本的操作。

它会在操作开始前和结束（按 `Ctrl-D` 可以结束）后，这两个时机，打一对相关联的快照。

这是我的 `snapper list` ：

~~~ text
  # | Type   | Pre # | Date                            | User | Used Space | Cleanup | Description           | Userdata
----+--------+-------+---------------------------------+------+------------+---------+-----------------------+--------------
 0  | single |       |                                 | root |            |         | current               |
 1* | single |       | Mon 11 Apr 2022 11:35:07 AM CST | root |  16.00 KiB |         | first root filesystem |
 2  | single |       | Mon 11 Apr 2022 02:23:02 PM CST | root |  20.02 MiB | number  | after installation    | important=yes
 3  | pre    |       | Thu 14 Apr 2022 11:04:07 AM CST | root |   4.20 MiB | number  | zypp(zypper)          | important=yes
 4  | post   |     3 | Thu 14 Apr 2022 11:07:42 AM CST | root |  11.40 MiB | number  |                       | important=yes
 5  | pre    |       | Thu 14 Apr 2022 11:16:42 AM CST | root |  96.00 KiB | number  | zypp(zypper)          | important=no
 6  | post   |     5 | Thu 14 Apr 2022 11:17:49 AM CST | root | 968.00 KiB | number  |                       | important=no
 7  | pre    |       | Thu 14 Apr 2022 11:18:10 AM CST | root |  64.00 KiB | number  | zypp(zypper)          | important=no
 8  | post   |     7 | Thu 14 Apr 2022 11:18:16 AM CST | root |   1.26 MiB | number  |                       | important=no
 9  | pre    |       | Tue 03 May 2022 01:59:01 PM CST | root |   1.84 MiB |         | rke2 sh               |
10  | post   |     9 | Tue 03 May 2022 02:01:02 PM CST | root |  16.00 KiB |         | rke2 sh               |
~~~

可以看到，这对快照的序号分别是 `9` 和 `10` 。

那么用 `snapper status 9..10` 就能看到这期间的系统配置变化：

~~~ text
+..... /etc/systemd/system/rke2-agent.service
+..... /etc/systemd/system/rke2-server.service
~~~

看，增加了这两个文件。

这就是注册服务。

这分别是它们的内容：

- `rke2-agent.service` ：
  
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
  
- `rke2-server.service` ：
  
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
  

#### 服务启动

服务启动会受到 `/etc/rancher/rke2/config.yaml` 内容的影响，决定它是创建新的集群还是加入集群。

不过不论哪种，要对系统增加的配置是一样的，不同仅仅在于内容。

服务文件在 `/etc/systemd/system` 目录创建好后，才可进行后续步骤；如果对某个服务执行 `systemctl enable` 命令的话，就会在该目录的 `multi-user.target.wants` 子目录里新增对应服务的软链接文件。这个不再做记录。

我是在 `snapper create -d 'rke2 start' --command bash` 中做了执了启动的操作。

它会在操作开始前和结束（按 `Ctrl-D` 可以结束）后，这两个时机，打一对相关联的快照。

这个命令的执行会很久，所以很久后才能 `Ctrl-D` 。

完成后，这是我的 `snapper list` ：

