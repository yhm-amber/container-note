
## Helm

基于 Helm 的部署。

[文档](https://argo-cd.readthedocs.io/en/stable/operator-manual/installation/#helm)显示， [`argoproj/argo-helm`](https://github.com/argoproj/argo-helm.git) 项目中有。

增加 `chart` 库：

~~~ sh
helm repo add -- argo https://argoproj.github.io/argo-helm
~~~

即把库地址 `https://argoproj.github.io/argo-helm` 添加为名称 `argo` 。

可有等价操作。

里面有 [`argo-cd`](https://github.com/argoproj/argo-helm/tree/main/charts/argo-cd) [`argo-events`](https://github.com/argoproj/argo-helm/tree/main/charts/argo-events) [`argo-rollouts`](https://github.com/argoproj/argo-helm/tree/main/charts/argo-rollouts) [`argo-workflows`](https://github.com/argoproj/argo-helm/tree/main/charts/argo-workflows) 几个应用（可能还有更多）。


### `argo-cd`

命令示例：

~~~ sh
helm install -- argo-cd argo/argo-cd
~~~

也可以使用等价操作。

可以根据你的安排增加 `-n 名称空间` 来指定应用安在哪儿。

关于高可用，参[此](https://github.com/argoproj/argo-helm/tree/main/charts/argo-cd#high-availability)。其中自动伸缩的配置：

~~~ yml
redis-ha:
  enabled: true

controller:
  enableStatefulSet: true

server:
  autoscaling:
    enabled: true
    minReplicas: 2

repoServer:
  autoscaling:
    enabled: true
    minReplicas: 2
~~~

关于该应用的所有选项，参[此](https://github.com/argoproj/argo-helm/tree/main/charts/argo-cd#installing-the-chart)。



