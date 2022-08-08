
ref: https://argo-cd.readthedocs.io/en/stable/user-guide/

## `Application`

ref: https://argo-cd.readthedocs.io/en/stable/user-guide/application_sources/

这个类型可以定义多种 Kubernetes 清单（ Kubernetes manifests ），其中包括：

- [Kustomize applications](#Kustomize)
- [Helm charts](#Helm)
- [A directory of YAML/JSON/Jsonnet manifests](#Jsonnet)
- [config management plugin]{#Argo-CMP}

关于自行开发：

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


### Kustomize

ref: https://argo-cd.readthedocs.io/en/stable/user-guide/kustomize/

### Helm

ref: https://argo-cd.readthedocs.io/en/stable/user-guide/helm/

### Jsonnet

ref: https://argo-cd.readthedocs.io/en/stable/user-guide/jsonnet/

### Argo CMP

ref: https://argo-cd.readthedocs.io/en/stable/user-guide/config-management-plugins/

核心 CRD ：

- `argoproj.io/v1alpha1` `ConfigManagementPlugin`
