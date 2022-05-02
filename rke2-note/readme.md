
## 开始之前需要明确的提要

- RKE2 是一个 Kubernetes 发行版， K3S 是又一个，二者有类似的地方。
- Rancher 是一个 Kubernetes 管理系统，需要用 `helm` 安在 Kubernetes 上（这还需要这个 Kubernetes 已经准备好足够的东西）或者采用 Docker 的方式（但还是在容器内做同样的事情），可以管理包括自身被部署集群在内的多个 Kubernetes 集群。
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

命令：

~~~ sh
curl -sfL http://rancher-mirror.rancher.cn/rke2/install.sh | INSTALL_RKE2_MIRROR=cn sh -
~~~

没错，这个步骤完全是脚本完成的。

脚本做的事情，他们[在这里](https://docs.rancher.cn/docs/rke2/install/methods/_index)是这么说的：

> 当安装脚本被执行时，它会判断它是什么类型的系统。如果它是一个使用 RPM 的操作系统（比如 CentOS 或 RHEL），它将执行基于 RPM 的安装，否则脚本会默认为 tarball。基于 RPM 的安装将在下面介绍。
> 
> 接下来，安装脚本下载 tarball，通过比较 SHA256 哈希值进行验证，最后将内容提取到/usr/local。如果需要，操作者可以在安装后自由移动文件。这个操作只是提取 tarball，并没有做其他系统的修改。
> 

除了选择安装方式和验证安装包以外，就是注册服务了。

页面也提到了部分系统上使用包管理器的方案。不过，我个人认为，最好是能够容器化起来。容器技术已经成熟了，没必要再用包管理器甚至是脚本这样的笨拙的手法：

- 二进制单次启动并退出
- 服务性质的常驻进程

*——这些工作都是可以用容器的方案解决的！从而：安装包格式和系统发行版自然也无需选择，而且更不用再自己维护验证安装包的代码，最重要的，这个方案根本不需要改变系统目录，只是改变一下 `/var/lib` 下的 `docker` 或者 `containers` 目录而已。*

现在还没有那样的方案。姑且看看脚本吧。

我得到的屏幕输出：

~~~ text
[WARN]  /usr/local is read-only or a mount point; installing to /opt/rke2
[INFO]  finding release for channel stable
[INFO]  using v1.22.8-rke2r1 as release
[INFO]  downloading checksums at https://rancher-mirror.oss-cn-beijing.aliyuncs.com/rke2/releases/download/v1.22.8-rke2r1/sha256sum-amd64.txt
[INFO]  downloading tarball at https://rancher-mirror.oss-cn-beijing.aliyuncs.com/rke2/releases/download/v1.22.8-rke2r1/rke2.linux-amd64.tar.gz
[INFO]  verifying tarball
[INFO]  unpacking tarball file to /opt/rke2
[INFO]  updating tarball contents to reflect install path
[INFO]  moving systemd units to /etc/systemd/system
[INFO]  install complete; you may want to run:  export PATH=$PATH:/opt/rke2/bin
~~~

然后就可以对 `rke2-server` 服务使用各种 `systemctl` 指令了。

上面的脚本有好几个选项，这里对我比较重要的有：

- 选择安装源： `INSTALL_RKE2_MIRROR=cn` （这个是 [`cn`](http://rancher-mirror.rancher.cn/rke2/install.sh) 来源脚本特有的功能）
- 选择离线包目录： `INSTALL_RKE2_ARTIFACT_PATH=/root/rke2-artifacts` （离线包下载[见这里](https://github.com/rancher/rke2/releases)）
- 决定节点类型： `INSTALL_RKE2_TYPE=agent` （这个变量空着的话值就默认是 `server` 了）

这两方面放在最初由 Docker 公司提供出来的产品下的话就也都不是需要操心的方面了。

*——软件源就是镜像源，换镜像源就能换软件源（从而不必维护两套难搞的脚本）；离线目录可以转换为离线镜像，用 `load` 加载就好从而也没有指定目录什么事儿了；节点类型的话完全可以直接指定拉去不同的镜像就是，反正这里这个变量的值的变化也是类似的效果。*

如果你熟悉 `docker` 或者 `podman` 这样的 Docker 风格的容器工具的使用，下面的步骤中，你会发现，它们都很容易涉及为容器化的。

说回到服务。

当你初次启动它的时候，它会真正开始做初始化的工作，比如搞一些二进制文件（包括 `kubectl` 命令）到特定目录，比如真正开始安装 RKE2 集群。

**要想加入已有集群，就在第一次启动前创建特定的配置文件并填入内容**。后面会提到它就是 `/etc/rancher/rke2/config.yaml` （[见](https://docs.rancher.cn/docs/rke2/install/ha/_index)），不过由于这里是首次创建集群的第一个节点，所以不需要手动创建这个文件。

*——这个如果要做成容器化，就只需要搞一个 `-v` 挂载就是，譬如 `-v ./cluster-a/etc:/etc/rancher/rke2` ，然后别的步骤都是一模一样只需要改变一下被作用的目录就好。不就是自定义配置嘛！*

如果没有指定离线的方式，这个 `systemctl start rke2-server.service` 会需要十分漫长的等待。这个过程中，它会对系统的软件和配置目录动很多手脚，最终把集群所需要的命令和配置都部署到系统里。

从脚本到初次启动服务的整个过程，对配置的改变是这些：

~~~ text
+..... /etc/cni
+..... /etc/cni/net.d
+..... /etc/cni/net.d/10-canal.conflist
+..... /etc/cni/net.d/calico-kubeconfig
+..... /etc/rancher
+..... /etc/rancher/node
+..... /etc/rancher/node/password
+..... /etc/rancher/rke2
+..... /etc/rancher/rke2/rke2.yaml
+..... /etc/systemd/system/multi-user.target.wants/rke2-server.service
+..... /etc/systemd/system/rke2-agent.service
+..... /etc/systemd/system/rke2-server.service
~~~

这在我这里是 `snapper status 15..16` 这个命令的输出结果。前面的 `+.....` 表示增加了文件。

我事先是在 `snapper create -d rke2 --command bash` 里完成的整个安装操作，这会在整个操作开始前和结束后分别生成一对快照；

然后我用 `snapper list` 确定了这对快照的编号：

~~~ text
  # | Type   | Pre # | Date                     | User | Used Space | Cleanup | Description                | Userdata
----+--------+-------+--------------------------+------+------------+---------+----------------------------+--------------
 0  | single |       |                          | root |            |         | current                    |
 1  | single |       | Thu Apr  7 13:09:17 2022 | root |   3.02 MiB | number  | first root filesystem      |
 2  | single |       | Thu Apr  7 14:05:50 2022 | root |  17.43 MiB | number  | after installation         | important=yes
 3  | pre    |       | Thu Apr  7 15:34:39 2022 | root | 640.00 KiB | number  | yast language              |
 4  | pre    |       | Thu Apr  7 15:35:28 2022 | root | 416.00 KiB | number  | zypp(ruby.ruby2.5)         | important=no
 5  | post   |     4 | Thu Apr  7 15:44:55 2022 | root |  13.77 MiB | number  |                            | important=no
 6  | post   |     3 | Thu Apr  7 15:44:57 2022 | root | 160.00 KiB | number  |                            |
...
...
15  | pre    |       | Mon May  2 15:04:42 2022 | root |   1.84 MiB |         | rke2                       |
16  | post   |    15 | Mon May  2 23:07:29 2022 | root |  16.00 KiB |         | rke2                       |
~~~

上面这就是 `list` 子命令的输出（中间有省略）。根据 `Description` 可见，我要比对的快照分别是 `15` 和 `16` ，因为前面创建这两个快照的命令有被用上了 `-d rke2` 选项。

新增的文件里，在 `/etc/systemd/system` 下的两个文件就是脚本所创，这里的 `multi-user.target.wants` 里的文件是因为我对这个服务使用了 `system enable` 。除此以外就是 `/etc/cni` 和 `/etc/rancher` 这两个目录以及里面的全部子内容了。

其余的改变， `snapper` 并未对其追踪，便不予列出。（反正……元数据没了的话，数据就算在也等于不在了——类似于这么个道理。）

在 `systemctl start rke2-server.service` 经过漫长等待结束后，集群就安装完成了。但相应的配置文件还没到位，还需要执行以下：

~~~ sh
mkdir ~/.kube
cat /etc/rancher/rke2/rke2.yaml | tee ~/.kube/config
~~~

以对 `kubectl` 命令做出配置。

然后就可以用 `kubectl get no` 验证，这第一个节点是否 `Ready` 了。

更多信息：

> 运行此安装程序后：
> 
> - rke2-server 服务将被安装。rke2-server 服务将被配置为在节点重启后或进程崩溃或被杀时自动重启。
> - 其他的实用程序将被安装在/var/lib/rancher/rke2/bin/。它们包括 kubectl, crictl, 和 ctr. 注意，这些东西默认不在你的路径上。
> - 还有两个清理脚本会安装到 /usr/local/bin/rke2 的路径上。它们是 rke2-killall.sh和rke2-uninstall.sh。
> - 一个 kubeconfig 文件将被写入/etc/rancher/rke2/rke2.yaml。
> - 一个可用于注册其他 server 或 agent 节点的令牌将在 /var/lib/rancher/rke2/server/node-token 文件中创建。
> 

### 2. 增加 `server` 节点

其实就是高可用。

注意要奇数。

ref: https://docs.rancher.cn/docs/rke2/install/ha/_index

和前一步区别是，在启动 `rke2-server.service` 服务之前，请先创建 `/etc/rancher/rke2/config.yaml` （和它的所在目录），并在其中加入以下内容：

~~~ yaml
token: <token from server node>
tls-san:
  - <ip>
  - <domain>
  - ...
~~~

其中：

- 在 `<token from server node>` 处的内容就是它要加入的节点的 `/var/lib/rancher/rke2/server/node-token` 文件的内容。
- 而 `<ip>` 和 `<domain>` 处就写能够访问到被加入集群的 `server` 的 IP 或者域名（不需要端口号）。

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
  

Windows 节点上的 `agent` 安装见原文。



