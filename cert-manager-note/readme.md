
ref: https://cert-manager.io/docs/

----

# cert-manager

安装可以用 `helm` 也可以下载 `cmctl` 来安装。

## `cmctl`

ref: https://cert-manager.io/docs/usage/cmctl

> `cmctl` is a CLI tool that can help you to manage cert-manager resources inside your cluster.
> 

从这里获取这个工具： https://github.com/cert-manager/cert-manager/releases

用于验证：

~~~ sh
cmctl check api
~~~

别的使用见上面 ref 或者 `cmctl --help` 的标准输出内容。

## `helm`

### 安装

ref: https://cert-manager.io/docs/installation/helm

~~~ sh
helm repo add jetstack https://charts.jetstack.io
# helm repo update
helm install \
  --namespace cert-manager \
  --create-namespace \
  --set installCRDs=true \
  -- cert-manager jetstack/cert-manager
~~~

> A full list of available Helm values is on [cert-manager's ArtifactHub page](https://artifacthub.io/packages/helm/cert-manager/cert-manager).
> 

想要看这意味着原子化执行了什么 YAML ，把 `install` 改为 `template` 然后你就能跟它在标准输出见面。

### 验证

ref: https://cert-manager.io/docs/installation/verify/#manual-verification

~~~ sh
kubectl get pods -n cert-manager
~~~

### 卸载

~~~ sh
helm --namespace cert-manager delete -- cert-manager
~~~

