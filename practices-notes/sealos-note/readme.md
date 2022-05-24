项目地址： [`labring/sealos`](https://github.com/labring/sealos.git) 

使用它能快速部署一个 Kubernetes 。

## 准备

### 机器

|地址|节点名|操作系统|
|----|------|---|
|`10.101.100.71`|`e1`|`openEuler-22.03-LTS - 5.10.0-60.28.0.58.oe2203.x86_64`|
|`10.101.100.72`|`e2`|`openEuler-22.03-LTS - 5.10.0-60.27.0.57.oe2203.x86_64`|
|`10.101.100.73`|`e3`|`openEuler-22.03-LTS - 5.10.0-60.27.0.57.oe2203.x86_64`|

这仨我打算都用来做 Master 并同时允许往它们身上调度 Pod 。

像这样就可以了：

### 部署

有两层含义：

- 部署 `sealos` 这个单二进制
- 使用 `sealos` 部署 Kubernetes （这里选用版本 `v1.21.12` ）

### Sealos

下载单二进制文件 `sealos` 到 `PATH` 目录下，然后就没有然后了，接下来就可以用 `sealos` 命令了。

下载地址见[项目 Releases 页面](https://github.com/labring/sealos/releases)。

这个页面还给出了另外一种途径：拉取 `fanux/sealos` 镜像（ `docker.io/fanux/sealos:latest` ）。但我没找到这个镜像的使用说明。

### Kubernetes

你需要给 `sealos` 传的参数，只有必要的信息。

命令示例：

~~~ sh
: 把你的密码存入一个变量
read xx # 回车后输入你这多台机器的密码然后再回车结束输入

: 再执行这一条命令就能按照你的参数部署 Kubernetes 了
sealos init --passwd "$xx" --master 10.101.100.71 --master 10.101.100.72 --master 10.101.100.73 --pkg-url https://sealyun.oss-cn-xx.xxx.com/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-v1.21.12/kube1.21.12.tar.gz --version v1.21.12
~~~

关于规划：

- 如果节点不足三台，只保留一个 Master 即可，但需要时不时备份 ETCD 。
- 如果只有三台，建议三台都规划为 Master ，这是高可用最少要有的数量。
- 如果你有三台以上的节点，建议只用三或五台做 Master ，不需要太多，剩下的都是 Node 就好。

如果规划中没有 Node 或 Node 过少，则需要让一部分或所有 Master 承担 Node 的职能——要允许它们也能被调度 Pod 。具体怎么做，下文会提到。


## 示例

这里有两个版本。

已经验证：这两个版本都能顺利安装，但只有 `v1.19.16` 安装后可用。

### `v1.21.12`

该版本可顺利安装，但安装后不可用。详见 [issue-1044](https://github.com/labring/sealos/issues/1044) 。

#### 安装

~~~ sh
sealos init --passwd "$xx" --master 10.101.100.71 --master 10.101.100.72 --master 10.101.100.73 --pkg-url https://sealyun.oss-cn-xx.xxx.com/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-v1.21.12/kube1.21.12.tar.gz --version v1.21.12
~~~

**密码、地址、离线包、版本号——我只是提供这些，然后就可以了。**

离线包可以下下来填本地路径，也可以填一个网络路径（即网址）。

示例代码的网络路径不可用，可用的网址请通过[官网](https://sealyun.com)获取。

完整的过程记录见 [*此链接*](.rec/init/v1.21.12-eg.md) 。

其中，见到像这样的字样就算安装成了：


<pre>
<font color="#55FFFF"><b>      ___           ___           ___           ___       ___           ___     </b></font>
<font color="#55FFFF"><b>     /\  \         /\  \         /\  \         /\__\     /\  \         /\  \    </b></font>
<font color="#55FFFF"><b>    /::\  \       /::\  \       /::\  \       /:/  /    /::\  \       /::\  \   </b></font>
<font color="#55FFFF"><b>   /:/\ \  \     /:/\:\  \     /:/\:\  \     /:/  /    /:/\:\  \     /:/\ \  \  </b></font>
<font color="#55FFFF"><b>  _\:\~\ \  \   /::\~\:\  \   /::\~\:\  \   /:/  /    /:/  \:\  \   _\:\~\ \  \ </b></font>
<font color="#55FFFF"><b> /\ \:\ \ \__\ /:/\:\ \:\__\ /:/\:\ \:\__\ /:/__/    /:/__/ \:\__\ /\ \:\ \ \__\</b></font>
<font color="#55FFFF"><b> \:\ \:\ \/__/ \:\~\:\ \/__/ \/__\:\/:/  / \:\  \    \:\  \ /:/  / \:\ \:\ \/__/</b></font>
<font color="#55FFFF"><b>  \:\ \:\__\    \:\ \:\__\        \::/  /   \:\  \    \:\  /:/  /   \:\ \:\__\  </b></font>
<font color="#55FFFF"><b>   \:\/:/  /     \:\ \/__/        /:/  /     \:\  \    \:\/:/  /     \:\/:/  /  </b></font>
<font color="#55FFFF"><b>    \::/  /       \:\__\         /:/  /       \:\__\    \::/  /       \::/  /   </b></font>
<font color="#55FFFF"><b>     \/__/         \/__/         \/__/         \/__/     \/__/         \/__/  </b></font>
</pre>


但是， `v1.21.12` 有问题，节点持续是 `NotReady` 。

问题已经提交了 Issue ，就是开头提到的 [issue-1044](https://github.com/labring/sealos/issues/1044) 。

我吧其中我编辑的比较重要的内容也记录在了 [*这里*](.issue/labring.sealos.1044.part-note.md) 。

#### 卸载

删除整个集群：

~~~ sh
sealos clean --all
~~~

完整的过程记录见 [*此链接*](.rec/clean-all/v1.21.12-eg.md) 。


### `v1.19.16`

#### 安装

~~~ sh
sealos init --passwd "$xx" --master 10.101.100.71 --master 10.101.100.72 --master 10.101.100.73 --pkg-url https://sealyun.oss-cn-xxxxxxx.xxxxxxxx.xxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-v1.19.16/kube1.19.16.tar.gz --version v1.19.16
~~~

完整的过程记录见 [*此链接*](.rec/init/v1.19.16-eg.md) 。

#### 卸载

同上，更多可参考帮助文档。



## 后续工作

你可能需要做的一些：

- 允许对 Master 节点调度。
- 安装存储类并设置一个默认。

### 允许 Master 调度

我这示例的集群里没有 node ，所以，需要 master 来顶 node 的活：允许 Pod 被往自己身上调度。

可以用 `kubectl describe no 节点名` 查看这个节点的污点：

<pre>[root@e1 ~]# kubectl describe no e1
Name:               e1
Roles:              master
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=e1
                    kubernetes.io/os=linux
                    node-role.kubernetes.io/master=
Annotations:        kubeadm.alpha.kubernetes.io/cri-socket: /var/run/dockershim.sock
                    node.alpha.kubernetes.io/ttl: 0
                    projectcalico.org/IPv4Address: 10.101.100.71/24
                    projectcalico.org/IPv4IPIPTunnelAddr: 100.99.106.192
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Tue, 24 May 2022 19:02:16 +0800
Taints:             node-role.kubernetes.io/master:NoSchedule
Unschedulable:      false
Lease:
  HolderIdentity:  e1
  AcquireTime:     &lt;unset&gt;
  RenewTime:       Tue, 24 May 2022 19:30:00 +0800
Conditions:
  Type                 Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----                 ------  -----------------                 ------------------                ------                       -------
  NetworkUnavailable   False   Tue, 24 May 2022 19:02:41 +0800   Tue, 24 May 2022 19:02:41 +0800   CalicoIsUp                   Calico is running on this node
  MemoryPressure       False   Tue, 24 May 2022 19:30:07 +0800   Tue, 24 May 2022 19:02:13 +0800   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure         False   Tue, 24 May 2022 19:30:07 +0800   Tue, 24 May 2022 19:02:13 +0800   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure          False   Tue, 24 May 2022 19:30:07 +0800   Tue, 24 May 2022 19:02:13 +0800   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready                True    Tue, 24 May 2022 19:30:07 +0800   Tue, 24 May 2022 19:02:46 +0800   KubeletReady                 kubelet is posting ready status
Addresses:
  InternalIP:  10.101.100.71
  Hostname:    e1
Capacity:
  cpu:                16
  ephemeral-storage:  71670904Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             40557616Ki
  pods:               110
Allocatable:
  cpu:                16
  ephemeral-storage:  66051905018
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             40455216Ki
  pods:               110
System Info:
  Machine ID:                 8e2da7273ebc49a9ac88df681212b513
  System UUID:                76c012f6-4b07-416d-baeb-38fff07ca1d7
  Boot ID:                    1c90ab9c-0bb0-4d69-b667-fdb8b64e7474
  Kernel Version:             5.10.0-60.28.0.58.oe2203.x86_64
  OS Image:                   openEuler 22.03 LTS
  Operating System:           linux
  Architecture:               amd64
  Container Runtime Version:  docker://19.3.12
  Kubelet Version:            v1.19.16
  Kube-Proxy Version:         v1.19.16
PodCIDR:                      100.64.0.0/24
PodCIDRs:                     100.64.0.0/24
Non-terminated Pods:          (9 in total)
  Namespace                   Name                                        CPU Requests  CPU Limits  Memory Requests  Memory Limits  AGE
  ---------                   ----                                        ------------  ----------  ---------------  -------------  ---
  kube-system                 calico-kube-controllers-7f4f5bf95d-rtqkc    0 (0%)        0 (0%)      0 (0%)           0 (0%)         27m
  kube-system                 calico-node-bvcpn                           250m (1%)     0 (0%)      0 (0%)           0 (0%)         27m
  kube-system                 coredns-f9fd979d6-fcw7l                     100m (0%)     0 (0%)      70Mi (0%)        170Mi (0%)     27m
  kube-system                 coredns-f9fd979d6-xd5h9                     100m (0%)     0 (0%)      70Mi (0%)        170Mi (0%)     27m
  kube-system                 etcd-e1                                     0 (0%)        0 (0%)      0 (0%)           0 (0%)         27m
  kube-system                 kube-apiserver-e1                           250m (1%)     0 (0%)      0 (0%)           0 (0%)         27m
  kube-system                 kube-controller-manager-e1                  200m (1%)     0 (0%)      0 (0%)           0 (0%)         27m
  kube-system                 kube-proxy-lv4wj                            0 (0%)        0 (0%)      0 (0%)           0 (0%)         27m
  kube-system                 kube-scheduler-e1                           100m (0%)     0 (0%)      0 (0%)           0 (0%)         27m
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests    Limits
  --------           --------    ------
  cpu                1 (6%)      0 (0%)
  memory             140Mi (0%)  340Mi (0%)
  ephemeral-storage  0 (0%)      0 (0%)
  hugepages-1Gi      0 (0%)      0 (0%)
  hugepages-2Mi      0 (0%)      0 (0%)
Events:
  Type    Reason                   Age                From        Message
  ----    ------                   ----               ----        -------
  Normal  NodeHasSufficientMemory  28m (x5 over 28m)  kubelet     Node e1 status is now: NodeHasSufficientMemory
  Normal  NodeHasNoDiskPressure    28m (x4 over 28m)  kubelet     Node e1 status is now: NodeHasNoDiskPressure
  Normal  NodeHasSufficientPID     28m (x4 over 28m)  kubelet     Node e1 status is now: NodeHasSufficientPID
  Normal  Starting                 27m                kubelet     Starting kubelet.
  Normal  NodeHasSufficientMemory  27m                kubelet     Node e1 status is now: NodeHasSufficientMemory
  Normal  NodeHasNoDiskPressure    27m                kubelet     Node e1 status is now: NodeHasNoDiskPressure
  Normal  NodeHasSufficientPID     27m                kubelet     Node e1 status is now: NodeHasSufficientPID
  Normal  NodeAllocatableEnforced  27m                kubelet     Updated Node Allocatable limit across pods
  Normal  Starting                 27m                kube-proxy  Starting kube-proxy.
  Normal  NodeReady                27m                kubelet     Node e1 status is now: NodeReady
[root@e1 ~]# </pre>

可以看到， `Taints` 一项的值是 `node-role.kubernetes.io/master:NoSchedule` ，这样的节点是不会被调度任务的。

用 `kubectl taint no e1 node-role.kubernetes.io/master:NoSchedule-` 可以去除这个 `taint` ，其中 `-` 表示减掉；如果没有这个 `-` 的话就是增加一个 `taint` ：

<pre>[root@e1 ~]# kubectl describe no e1|egrep &apos;Taints|master&apos;
Roles:              <font color="#FF5555"><b>master</b></font>
                    node-role.kubernetes.io/<font color="#FF5555"><b>master</b></font>=
<font color="#FF5555"><b>Taints</b></font>:             node-role.kubernetes.io/<font color="#FF5555"><b>master</b></font>:NoSchedule
[root@e1 ~]# kubectl taint no e1 node-role.kubernetes.io/master:NoSchedule-
node/e1 untainted
[root@e1 ~]# kubectl describe no e1|egrep &apos;Taints|master&apos;
Roles:              <font color="#FF5555"><b>master</b></font>
                    node-role.kubernetes.io/<font color="#FF5555"><b>master</b></font>=
<font color="#FF5555"><b>Taints</b></font>:             &lt;none&gt;
[root@e1 ~]# kubectl taint no e1 node-role.kubernetes.io/master:NoSchedule
node/e1 tainted
[root@e1 ~]# kubectl describe no e1|egrep &apos;Taints|master&apos;
Roles:              <font color="#FF5555"><b>master</b></font>
                    node-role.kubernetes.io/<font color="#FF5555"><b>master</b></font>=
<font color="#FF5555"><b>Taints</b></font>:             node-role.kubernetes.io/<font color="#FF5555"><b>master</b></font>:NoSchedule
[root@e1 ~]# kubectl taint no e1 node-role.kubernetes.io/master:NoSchedule-
node/e1 untainted
[root@e1 ~]# kubectl describe no e1|egrep &apos;Taints|master&apos;
Roles:              <font color="#FF5555"><b>master</b></font>
                    node-role.kubernetes.io/<font color="#FF5555"><b>master</b></font>=
<font color="#FF5555"><b>Taints</b></font>:             &lt;none&gt;
[root@e1 ~]# </pre>

另外两个节点也都执行一下 `kubectl taint no e1 node-role.kubernetes.io/master:NoSchedule-` 就好了。

注意，别漏了那个最后的 `-` ，它表示去掉这样的一项：

> 你可以使用命令 kubectl taint 给节点增加一个污点。比如，
> 
> ~~~ sh
> kubectl taint nodes node1 key1=value1:NoSchedule
> ~~~
> 
> 给节点 `node1` 增加一个污点，它的键名是 `key1` ，键值是 `value1` ，效果是 `NoSchedule` 。 这表示只有拥有和这个污点相匹配的容忍度的 Pod 才能够被分配到 `node1` 这个节点。
> 
> 若要移除上述命令所添加的污点，你可以执行：
> 
> ~~~ sh
> kubectl taint nodes node1 key1=value1:NoSchedule-
> ~~~
> 

ref: https://kubernetes.io/zh/docs/concepts/scheduling-eviction/taint-and-toleration/

另外：

> 从 v1.20 开始，此污点已弃用，并将在 v1.25 中将其删除，取而代之的是 `node-role.kubernetes.io/control-plane` 。
> 

ref: https://kubernetes.io/zh/docs/reference/labels-annotations-taints/
ref also: https://kubernetes.io/zh/docs/reference/setup-tools/kubeadm/implementation-details/

这个是 `v1.19.x` ，所以仍然是旧的污点名。

上面的几个 ref 是这样搜索到的： `site:kubernetes.io node-role.kubernetes.io/master:NoSchedule` 。

### 存储类

参考 [`openebs-note`](../openebs-note) 。

