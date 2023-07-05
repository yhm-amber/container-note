
## introduce

可用于操作 Kubernetes 的界面 (interface) 之一。是一个命令行界面。


## deploy

### local way

在本地使用 `kubectl` 二进制文件即可。

一些本地使用的界面如 Lens 也是基于该命令行界面制作的图形界面。

### kubesphere way

### ...

## use cases

### set context

e.g. set `ns` as current namespace: 

~~~ sh
kubectl config set-context --current -n <k8s_namespace>
~~~

[docs-streamnative-prepare-kube]: https://docs.streamnative.io/platform/latest/operator-guides/sn-prepare

ref: [Prepare Kubernetes cluster | StreamNative Documentation][docs-streamnative-prepare-kube]

