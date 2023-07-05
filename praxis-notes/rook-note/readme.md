
# rook

看起来这东西应该是一个系列。

它是想做一个创建存储资源实例的控制器，但是是基于已有技术去做。

目前，在支持中的被基于的，似乎只有 `ceph` 和 `NFS` 。

# ceph

基于 `ceph` 的 `rook-ceph` 让 `ceph` 能在 Kubernetes 上以 Kubernetes 的方式使用（这个应该也就是他们常说的云原生了）。

这里只记一下 `helm` 的开始示例。

ref-helm: https://rook.io/docs/rook/v1.9/Helm-Charts/helm-charts/
ref-helm-operator: https://rook.io/docs/rook/v1.9/Helm-Charts/operator-chart/
ref-helm-cluster: https://rook.io/docs/rook/v1.9/Helm-Charts/ceph-cluster-chart/

创建 `rook-ceph-cluster` 实例（这就是们这次安装的最终目的）的 `helm chart` 里用到了自定义资源类型（ `CRD` ）。

所以，需要先装 `rook-ceph-operator` 以让自定义资源类型先被安装，然后才能创建 `rook-ceph-cluster` 实例。

*——众所周知， `helm chart` 仍然只是一个对资源定义文件的（基于模板的）封装罢了。*

添加 repo ：

~~~ sh
helm repo add -- rook-release https://charts.rook.io/release
~~~

部署 operator ：

~~~ sh
helm install --create-namespace --namespace rook-ceph -- rook-ceph rook-release/rook-ceph
: you can run with -f values.yaml, more see the ref-helm-operator.
~~~

创建 cluster 实例：

~~~ sh
helm install --create-namespace --namespace rook-ceph --set operatorNamespace=rook-ceph -- rook-ceph-cluster rook-release/rook-ceph-cluster
: you can run with -f values-override.yaml, more see the ref-helm-cluster.
~~~

创建实例的时候， `operatorNamespace` 的值需要同你要用上的那个名为 `rook-ceph` 的 operator 的命名空间一致。

**（有件事很奇怪，命名 rook 的正篇里说是我要么提供没格式化的盘或分区、要么提供给它提供存储的 sc ，然而这儿咋没问我要咧？？）**


