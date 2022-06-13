

# Helm install

ref: [`https://goharbor.io/docs/2.5.0/install-config/harbor-ha-helm`](https://goharbor.io/docs/2.5.0/install-config/harbor-ha-helm)  
ref: [`https://artifacthub.io/packages/helm/harbor/harbor`](https://artifacthub.io/packages/helm/harbor/harbor)  

上面两个 ref ，一个是官网的 helm 步骤，一个是 artifacthub.io 的该 chart 的页面。

它的步骤是离线安装 `helm chart` 的步骤：

~~~~ sh
: :: add repo :: :
helm repo add harbor https://helm.goharbor.io

: :: download chart :: :
helm fetch harbor/harbor --untar

: :: settings :: :
# change values.yaml
# or use --set during helm install

: :: then install by helm3 :: :
helm install my-release .
~~~~

不过，我是这样（在线）安的：

~~~ sh
helm repo add -- harbor https://helm.goharbor.io
helm install -- hub harbor/harbor
~~~

out:

~~~~ text
NAME: hub
LAST DEPLOYED: Mon Jun  6 18:14:12 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Please wait for several minutes for Harbor deployment to complete.
Then you should be able to visit the Harbor portal at https://core.harbor.domain
For more details, please visit https://github.com/goharbor/harbor
~~~~

看起来，之后访问那个地址就可以了。

但是我从集群外部真的能访问这个域名解析出来的 IP 地址吗？回头试试吧。

——很可惜，不能。

根据其 `values.yaml` 中的提示，我又加了这样两个设置来安装：

~~~
helm install --set expose.type=clusterIP,expose.tls.enabled=false -n hub --create-namespace -- hub harbor/harbor
~~~

这样的话，它会自行部署一个 Nginx 对所有服务来代理，而不是使用 Ingress 了，那么我只需要把这个负载对应的 SVC 给变成 NodePort 就好了。

增加上述 `--set` 并不会影响 `helm` 部署时在命令行上的输出。


# Operator install

Harbor 支持使用 Operator 创建实例。

Operator 支持 Helm 部署。

ref: 

- https://github.com/goharbor/harbor-operator/pkgs/container/harbor-operator
- https://github.com/goharbor/harbor-operator/blob/master/docs/installation/kustomization-all-in-one.md
- https://github.com/goharbor/harbor-operator/blob/master/docs/installation/by-helm-chart.md
- https://github.com/goharbor/harbor-operator/tree/master/charts/harbor-operator

需要：

- `Kubernetes` 。
- [`cert-manager`](../cert-manager-note) 。
- Ingress controller ，如默认的 [Nginx Ingress](../ingress-note#kubernetes-default-nginx-ingress) 。
- `kubectl` 。
- `helm` (v3) 。

安装：略，见上面参考的那些链接。

从版本号看来，用 operator 创建实例的这个途径，并不像用 helm 直接安装那样被积极维护。

