
## Install (Helm)

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

输出：

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

## Usage

### `applications.argoproj.io` CRD

这个是安装 `argo/argo-cd` 后就有了的一个 CRD 。

ref: https://argo-cd.readthedocs.io/en/stable/user-guide/application_sources/

这个类型可以定义多种 Kubernetes 清单（ Kubernetes manifests ），其中包括：

- [Kustomize applications](#Kustomize)
- [Helm charts](#Helm)
- [A directory of YAML/JSON/Jsonnet manifests](#Jsonnet)
- [config management plugin](#Argo-CMP)

额外的开发：

> Argo CD also supports uploading local manifests directly. Since this is an anti-pattern of the GitOps paradigm, this should only be done for development purposes. A user with an `override` permission is required to upload manifests locally (typically an admin). All of the different Kubernetes deployment tools above are supported. To upload a local application:
> 
> ~~~ text
> $ argocd app sync APPNAME --local /path/to/dir/
> ~~~
> 

即：

> Argo CD 还支持直接上传本地清单。由于这是 GitOps 范例的反模式，因此只能出于开发目的执行此操作。具有 `override` 权限的用户（通常是管理员）需要本地上传清单。支持上述所有不同的 Kubernetes 部署工具。上传本地应用程序：
> 
> ~~~ sh
> argocd app sync APPNAME --local /path/to/dir/
> ~~~
> 


#### Kustomize

ref: https://argo-cd.readthedocs.io/en/stable/user-guide/kustomize/

核心 CRD ： `argoproj.io/v1alpha1` `Application`

相关配置：

位于：你安装的 ArgoCD 所在名称空间里的名为 `argocd-cm` 的配置字典（ `ConfigMap` ）里的 `cm.data` 坐标下。

在其中：

- 如果你想让它会调用的 `kustomize build` 子命令多一些选项，你可以增加值到 `kustomize.buildOptions` 这个键下。
  
  譬如，添加 `kustomize.buildOptions: --load-restrictor LoadRestrictionsNone` 这样一条 *键值对* 的话，  就能达到相当于给 `kustomize build` 子命令增加 `--load-restrictor LoadRestrictionsNone` 这一选项的效果。

- 对于版本：只要已经按照[这个指南](https://argo-cd.readthedocs.io/en/stable/operator-manual/custom_tools/)对其示例中的 `/custom-tools` 路径添加过了相应版本，就可以增加值譬如 `/custom-tools/kustomize_FOOBAR` 这样一个有效的 Kustomize 二进制路径到键 `kustomize.path.AAA` 下，如果要用它的话就把 `Application` 资源的 `spec.source.kustomize.version` 这个位置设置值 `AAA` ，就可以指定 Kustomize 版本来运行了。

#### Helm

ref: https://argo-cd.readthedocs.io/en/stable/user-guide/helm/

核心 CRD ： `argoproj.io/v1alpha1` `Application`

#### Jsonnet

ref: https://argo-cd.readthedocs.io/en/stable/user-guide/jsonnet/

#### Argo CMP

ref: https://argo-cd.readthedocs.io/en/stable/user-guide/config-management-plugins/

核心 CRD ： `argoproj.io/v1alpha1` `ConfigManagementPlugin`

