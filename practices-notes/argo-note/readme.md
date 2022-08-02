
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

关于高可用，参[此](https://github.com/argoproj/argo-helm/tree/main/charts/argo-cd#high-availability)。其中自动伸缩的 `values.yml` 配置：

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

示例：

~~~~ sh
helm upgrade --install -n argo --set redis-ha.enabled=true,controller.enableStatefulSet=true,server.autoscaling.enabled=true,server.autoscaling.minReplicas=2,repoServer.autoscaling.enabled=tru
e,repoServer.autoscaling.minReplicas=2 -- argo-cd argo/argo-cd
~~~~

输出结果：

~~~~ text
NAME: argo-cd
LAST DEPLOYED: Tue Aug  2 17:04:07 2022
NAMESPACE: argo
STATUS: deployed
REVISION: 1
NOTES:
In order to access the server UI you have the following options:

1. kubectl port-forward service/argo-cd-argocd-server -n argo 8080:443

    and then open the browser on http://localhost:8080 and accept the certificate

2. enable ingress in the values file `server.ingress.enabled` and either
      - Add the annotation for ssl passthrough: https://github.com/argoproj/argo-cd/blob/master/docs/operator-manual/ingress.md#option-1-ssl-passthrough
      - Add the `--insecure` flag to `server.extraArgs` in the values file and terminate SSL at your ingress: https://github.com/argoproj/argo-cd/blob/master/docs/operator-manual/ingress.md#option-2-multiple-ingress-objects-and-hosts


After reaching the UI the first time you can login with username: admin and the random password generated during the installation. You can find the password by running:

kubectl -n argo get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

(You should delete the initial secret afterwards as suggested by the Getting Started Guide: https://github.com/argoproj/argo-cd/blob/master/docs/getting_started.md#4-login-using-the-cli)
~~~~

关于该应用的所有选项，参[此](https://github.com/argoproj/argo-helm/tree/main/charts/argo-cd#installing-the-chart)。

它有一些依赖，比如 `redis` ，可以用自带也可以配置外部的。（这个以后有机会详细整理。。。）



