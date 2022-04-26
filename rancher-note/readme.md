
目前本笔记基于 [v2.6](https://rancher.com/docs/rancher/v2.6) 整理。

## 架构

### 软件架构

这里讲的是 Rancher 具体是什么。

ref: https://rancher.com/docs/rancher/v2.6/en/overview/architecture/

> ![image](https://user-images.githubusercontent.com/103625580/165257322-6c78df07-8d75-4794-b120-b7d00b061ed3.png)
> 

### 架构建议

这里讲的是 Rancher 最好应当怎样使用。

ref: https://rancher.com/docs/rancher/v2.6/en/overview/architecture-recommendations/

#### 与用户集群的关系

> 用户集群是运行您的应用程序和服务的下游 Kubernetes 集群。
> 
> 如果您有 Rancher 的 Docker 安装，则运行 Rancher 服务器的节点应与下游集群分开。
> 
> 如果 Rancher 旨在管理下游 Kubernetes 集群，那么 Rancher 服务器运行的 Kubernetes 集群也应该与下游用户集群分开。
> 
> Rancher Server 与用户集群的分离
> 
> ![image](https://user-images.githubusercontent.com/103625580/165258283-887c9c2c-9237-477d-a8ea-323781252a1b.png)
> 

#### 负载均衡建议

> 我们建议对负载均衡器和入口控制器进行以下配置：
> 
> - Rancher的DNS应解析为第4层负载均衡器（TCP）。
> - 负载均衡器应将端口 TCP/80 和 TCP/443 转发到 Kubernetes 集群中的所有 3 个节点。
> - 入口控制器会将 HTTP 重定向到 HTTPS，并在端口 TCP/443 上终止 SSL/TLS。
> - 入口控制器会将流量转发到 Rancher 部署中 pod 上的端口 TCP/80。
> 
> Rancher 安装在具有第 4 层负载均衡器的 Kubernetes 集群上，描述了入口控制器上的 SSL 终止
> 
> ![image](https://user-images.githubusercontent.com/103625580/165258895-1659d5f8-d1ba-45c8-917d-40cb137ee0df.png)
> 

#### 别的……

分别是对于 K3S 和 RKE 的推荐。

但是最新的 2.6 版本其实已经支持了 RKE2 ，但好像这个文档还没更新……

这是图：

> k3s:
> 
> 底层 Kubernetes 集群的一个选项是使用 K3s Kubernetes 。 K3s 是 Rancher 的 CNCF 认证的 Kubernetes 发行版。它易于安装，占用的内存只有 Kubernetes 的一半，全部以小于 100 MB 的二进制文件形式存在。 K3s 的另一个优点是，它允许外部数据存储保存群集数据，从而允许将 K3s 服务器节点视为临时节点。
> 
> 运行牧场主管理服务器的 K3s Kubernetes 集群的架构：
> 
> ![image](https://user-images.githubusercontent.com/103625580/165259318-6b09f919-938f-4aa9-8015-54a13ae98a65.png)
> 
> rke:
> 
> 在 RKE 安装中，群集数据在群集中的三个 etcd 节点中的每一个节点上复制，从而在其中一个节点发生故障时提供冗余和数据重复。
> 
> 运行 Rancher 管理服务器的 RKE Kubernetes 集群的架构：
> 
> ![image](https://user-images.githubusercontent.com/103625580/165259367-8177279a-c781-4950-b932-0db7b46a14ed.png)
> 

更多请参考上面的 ref 链接。



## 快速开始

ref: https://rancher.com/docs/rancher/v2.6/en/quick-start-guide/deployment/quickstart-manual-setup/

### 证书管理器

基于链接中所述，要先部署 `cert-manager` 。

我不依据该连接中的方案，而是它的[官方手册](https://cert-manager.io/docs/installation)。

我基于官方手册做了一个[简单的整理](../cert-manager-note)，可以参考里面的命令。

### 本体

基于 ref 链接，接下来步骤就是用 `helm` 安装 Rancher 。

整理命令：

~~~ sh
helm install \
  --namespace cattle-system \
  --set hostname=<IP_OF_LINUX_NODE>.sslip.io \
  --set replicas=1 \
  --set bootstrapPassword=<PASSWORD_FOR_RANCHER_ADMIN> \
  -- rancher rancher-latest/rancher ;
~~~

上面的 `<PASSWORD_FOR_RANCHER_ADMIN>` 改成你登录 Rancher 的 `admin` 用户的密码。






----

(todo ...)
