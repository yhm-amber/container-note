
目前本笔记基于 [rancher/v2.6/en](https://rancher.com/docs/rancher/v2.6/en) 整理。

翻译基于 Bing.com ，会有改动。

## 架构

> 战斗之前要明白自己到底在为什么战斗……

### 软件架构

这里讲的是 Rancher 具体是什么。

ref: https://rancher.com/docs/rancher/v2.6/en/overview/architecture/

> 大多数 Rancher 2.x 软件都在 Rancher Server 上运行。 Rancher Server 包括用于管理整个 Rancher 部署的所有软件组件。
> 
> 下图说明了 Rancher 2.x 的高级架构。该图描述了一个 Rancher Server 的安装，该安装管理两个下游 Kubernetes 集群：一个由 RKE 创建，另一个由 Amazon EKS (Elastic Kubernetes Service) 创建。
> 
> 为了获得最佳性能和安全性，我们建议为 Rancher management server 使用专用的 Kubernetes 集群。不建议在此群集上运行用户工作负载。部署 Rancher 后，您可以创建或导入集群以运行您的工作负载。
> 
> 下图显示了用户如何通过 Rancher 的身份验证代理，操作 Rancher 启动的 Kubernetes 集群和托管的 Kubernetes 集群：
> 
> ![通过 Rancher 的身份验证代理管理 Kubernetes 集群](./rancher-architecture-rancher-api-server.svg)
> 

### 架构建议

这里讲的是 Rancher 最好应当怎样使用。

ref: https://rancher.com/docs/rancher/v2.6/en/overview/architecture-recommendations/

#### 与用户集群的关系

> 用户集群是运行您的应用程序和服务的下游 Kubernetes 集群。
> 
> 如果您在用 Rancher 的 Docker 安装，那么运行 Rancher 服务器的节点应与下游集群分开。
> 
> 如果（部署于 Kubernetes 中的） Rancher 旨在管理下游 Kubernetes 集群，那么这个运行 Rancher Server 的 Kubernetes 集群也应该与下游用户集群分别为两个集群。
> 
> ![Rancher Server 与用户集群的分离](./rancher-architecture-separation-of-rancher-server.svg)
> 

#### 负载均衡建议

> 我们建议对负载均衡器和入口控制器进行以下配置：
> 
> - 服务 Rancher 的 DNS 应解析为第 4 层负载均衡器（ TCP ）。
> - 负载均衡器应将端口 TCP/80 和 TCP/443 转发到 Kubernetes 集群中的所有 3 个节点。
> - 入口控制器会将 HTTP 重定向到 HTTPS，并在端口 TCP/443 上终止 SSL/TLS。
> - 入口控制器会将流量转发到 Rancher 部署中 pod 上的端口 TCP/80。
> 
> ![Rancher 安装在具有第 4 层负载均衡器的 Kubernetes 集群上，描述了入口控制器上的 SSL 终止](./rancher2ha.svg)
> 

#### 别的……

分别是对于 K3S 和 RKE 的推荐。

但是最新的 2.6 版本其实已经支持了 RKE2 ，但好像这个文档还没更新……

这是图：

> k3s:
> 
> 底层 Kubernetes 集群的一个选项是使用 K3s Kubernetes 。 K3s 是 Rancher 的 CNCF 认证的 Kubernetes 发行版。它易于安装，占用的内存只有 Kubernetes 的一半，全部以小于 100 MB 的二进制文件形式存在。 K3s 的另一个优点是，它允许外部数据存储保存群集数据，从而允许将 K3s 服务器节点视为临时节点。
> 
> ![运行牧场主管理服务器的 K3s Kubernetes 集群的架构](./k3s-server-storage.svg)
> 
> rke:
> 
> 在 RKE 安装中，群集数据在群集中的三个 etcd 节点中的每一个节点上复制，从而在其中一个节点发生故障时提供冗余和数据重复。
> 
> ![运行 Rancher 管理服务器的 RKE Kubernetes 集群的架构](./rke-server-storage.svg)
> 

更多请参考上面的 ref 链接。



## 快速开始

ref: https://rancher.com/docs/rancher/v2.6/en/quick-start-guide/deployment/quickstart-manual-setup/

示例是在 K3S 上部署的，在 RKE2 上也行。我有[关于 RKE2 的笔记](../rke2-note)。

他们还有一个简单示例，是用的 `docker run` ，但是这个命令开权限了，不好。而且容器里面也不止一个进程，容器被当节点用了，不好。

我试过在用 `sealos` 装的 Kubernetes 上执行下面步骤，所有都没问题，就只有 Rancher Server 节点的 `443` 端口没被聆听，从而只能集群内用。可见，如果不是在**被指定的 Kubernetes 发行版**上安装的话， Rancher 的使用可能还是会多多少少有一些依赖问题的，当然这个不影响主要功能，就是反向代理要自己解决一下比较麻烦。

*（相比起来套路野蛮的 [KubeSphare](../kubesphare-note) 适应能力就强很多了：管他娘的正不正式， `nodeport` 直接用，别的问题别地儿考虑……就挺省心的……😗）*

### 证书管理器

基于链接中所述，要先部署 `cert-manager` 。

上面 ref 里有相应步骤，但我不照那个来，因为我觉得它可能过时了。

我照着 `cert-manager` [它自己的手册](https://cert-manager.io/docs/installation)来，并基于此做了[整理](../cert-manager-note)。这部分步骤可以参考这个整理。

### 本体

首先在 `helm` 里添加注册（[详见](https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/#1-add-the-helm-chart-repository)）：

~~~ sh
helm repo add -- rancher-stable https://releases.rancher.com/server-charts/stable
~~~

基于 ref 链接，接下来步骤就是用 `helm` 安装 Rancher 。

整理命令：

~~~ sh
helm install \
  --namespace cattle-system \
  --create-namespace \
  --set hostname=<IP_OF_LINUX_NODE>.sslip.io \
  --set replicas=1 \
  --set bootstrapPassword=<PASSWORD_FOR_RANCHER_ADMIN> \
  -- rancher rancher-stable/rancher ;
~~~

上面的：

- `<PASSWORD_FOR_RANCHER_ADMIN>` 改成你登录 Rancher 的 `admin` 用户的密码。
- `<IP_OF_LINUX_NODE>.sslip.io` 里的 `<IP_OF_LINUX_NODE>` 改为你的一个 IP ：
  
  > 该命令需要一个将流量转发到 Linux 计算机的域名。为简单起见，在本教程中，您可以使用假域名来创建概念验证。假域名的一个例子是 `<IP_OF_LINUX_NODE>.sslip.io` 。
  > 
  > ...
  > 
  > 现在，如果您在 Web 浏览器中导航到 `<IP_OF_LINUX_NODE>.sslip.io` ，您应该会看到 Rancher UI 。
  > 
  > 为了简化这些说明，我们使用了伪造的域名和自签名证书来执行此安装。因此，您可能需要向 Web 浏览器添加安全例外才能看到 Rancher UI 。请注意，对于生产安装，您需要使用负载均衡器、真实域名和真实证书进行高可用性设置。
  > 

我执行的：

~~~ sh
helm install \
  --namespace cattle-system \
  --create-namespace \
  --set hostname=10.11.110.101.sslip.io \
  --set replicas=1 \
  --set bootstrapPassword='321-123-aA--' \
  -- rancher rancher-stable/rancher ;
~~~

out ：

~~~ text
NAME: rancher
LAST DEPLOYED: Tue May  3 12:02:55 2022
NAMESPACE: cattle-system
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Rancher Server has been installed.

NOTE: Rancher may take several minutes to fully initialize. Please standby while Certificates are being issued, Containers are started and the Ingress rule comes up.

Check out our docs at https://rancher.com/docs/

If you provided your own bootstrap password during installation, browse to https://10.11.110.101.sslip.io to get started.

If this is the first time you installed Rancher, get started by running this command and clicking the URL it generates:

```
echo https://10.11.110.101.sslip.io/dashboard/?setup=$(kubectl get secret --namespace cattle-system bootstrap-secret -o go-template='{{.data.bootstrapPassword|base64decode}}')
```

To get just the bootstrap password on its own, run:

```
kubectl get secret --namespace cattle-system bootstrap-secret -o go-template='{{.data.bootstrapPassword|base64decode}}{{ "\n" }}'
```


Happy Containering!
~~~

看 Pod 是 `Pending` 状态。需要等会儿，它可能要现拉镜像，具体原因看 Event 。

![image](https://user-images.githubusercontent.com/103625580/165270061-0f9f218b-355f-45b4-8421-a1575593a331.png)


卸载：

~~~ sh
helm -n cattle-system uninstall -- rancher
~~~


## 牧场主在领航员上

上面是快速开始，这部分整理完整文档里的一些信息：

ref: https://rancher.com/docs/rancher/v2.6/en/installation/install-rancher-on-k8s/

### xxx





----

(todo ...)
