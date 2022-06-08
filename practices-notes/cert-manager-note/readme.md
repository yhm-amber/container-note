
ref: https://cert-manager.io/docs/

----

# cert-manager

安装可以用 `helm` 也可以下载 `cmctl` 来安装。

## 用 `cmctl`

ref: https://cert-manager.io/docs/usage/cmctl

> `cmctl` is a CLI tool that can help you to manage cert-manager resources inside your cluster.
> 

从这里获取这个工具： https://github.com/cert-manager/cert-manager/releases

用于验证：

~~~ sh
cmctl check api
~~~

别的使用见上面 ref 或者 `cmctl --help` 的标准输出内容。

## 用 `helm`

### 安装

ref: https://cert-manager.io/docs/installation/helm

~~~ sh
helm repo add -- jetstack https://charts.jetstack.io
# helm repo update
helm install \
  --namespace cert-manager \
  --create-namespace \
  --set installCRDs=true \
  -- cert-manager jetstack/cert-manager ;
~~~

out:

~~~ text
NAME: cert-manager
LAST DEPLOYED: Tue May  3 11:37:11 2022
NAMESPACE: cert-manager
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
cert-manager v1.8.0 has been deployed successfully!

In order to begin issuing certificates, you will need to set up a ClusterIssuer
or Issuer resource (for example, by creating a 'letsencrypt-staging' issuer).

More information on the different types of issuers and how to configure them
can be found in our documentation:

https://cert-manager.io/docs/configuration/

For information on how to configure cert-manager to automatically provision
Certificates for Ingress resources, take a look at the `ingress-shim`
documentation:

https://cert-manager.io/docs/usage/ingress/
~~~

想要看所有可以在 `set` Flag 设置的配置项的话：

> A full list of available Helm values is on [cert-manager's ArtifactHub page](https://artifacthub.io/packages/helm/cert-manager/cert-manager).
> 

想要看这意味着原子化执行了什么 YAML 的话：把 `install` 改为 `template` 然后你就能跟它在标准输出见面。

### 验证

ref: https://cert-manager.io/docs/installation/verify/#manual-verification

~~~ sh
kubectl get pods -n cert-manager
~~~

然后看里面的东西（参考上面的 ref 连接）。

或者只是这样：

~~~ sh
cmctl check api
~~~

需要本节点有 `cmctl` 命令（获取方式见前文）。

### 卸载

~~~ sh
helm --namespace cert-manager delete -- cert-manager
~~~

### 一些问题

即便是 `fetch` 下来，也可能由于网络原因不能成功安装。

离线的办法没有，重试的办法有一个：

~~~ sh
helm fetch jetstack/cert-manager --untar && cd cert-manager &&
while ! helm install --namespace cert-manager --create-namespace --set installCRDs=true -- cert-manager . ;
do helm uninstall cert-manager -n cert-manager ; done
~~~

<details>

<summary>
stdout/stderr :
</summary>

~~~~
Error: INSTALLATION FAILED: failed post-install: timed out waiting for the condition
release "cert-manager" uninstalled
Error: INSTALLATION FAILED: failed post-install: timed out waiting for the condition
release "cert-manager" uninstalled
Error: INSTALLATION FAILED: failed post-install: timed out waiting for the condition
release "cert-manager" uninstalled
Error: INSTALLATION FAILED: failed post-install: timed out waiting for the condition
release "cert-manager" uninstalled
Error: INSTALLATION FAILED: failed post-install: timed out waiting for the condition
release "cert-manager" uninstalled
Error: INSTALLATION FAILED: failed post-install: timed out waiting for the condition
release "cert-manager" uninstalled
Error: INSTALLATION FAILED: failed post-install: timed out waiting for the condition
release "cert-manager" uninstalled
Error: INSTALLATION FAILED: failed post-install: timed out waiting for the condition
release "cert-manager" uninstalled
Error: INSTALLATION FAILED: failed post-install: timed out waiting for the condition
release "cert-manager" uninstalled
Error: INSTALLATION FAILED: failed post-install: timed out waiting for the condition
release "cert-manager" uninstalled
Error: INSTALLATION FAILED: failed post-install: timed out waiting for the condition
release "cert-manager" uninstalled
Error: INSTALLATION FAILED: failed post-install: timed out waiting for the condition
release "cert-manager" uninstalled
Error: INSTALLATION FAILED: failed post-install: timed out waiting for the condition
release "cert-manager" uninstalled
Error: INSTALLATION FAILED: failed post-install: timed out waiting for the condition
release "cert-manager" uninstalled
Error: INSTALLATION FAILED: failed post-install: timed out waiting for the condition
release "cert-manager" uninstalled
Error: INSTALLATION FAILED: failed post-install: timed out waiting for the condition
release "cert-manager" uninstalled
Error: INSTALLATION FAILED: failed post-install: timed out waiting for the condition
release "cert-manager" uninstalled
Error: INSTALLATION FAILED: failed post-install: timed out waiting for the condition
release "cert-manager" uninstalled
Error: INSTALLATION FAILED: failed post-install: timed out waiting for the condition
release "cert-manager" uninstalled
NAME: cert-manager
LAST DEPLOYED: Wed Jun  8 01:28:05 2022
NAMESPACE: cert-manager
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
cert-manager v1.8.0 has been deployed successfully!

In order to begin issuing certificates, you will need to set up a ClusterIssuer
or Issuer resource (for example, by creating a 'letsencrypt-staging' issuer).

More information on the different types of issuers and how to configure them
can be found in our documentation:

https://cert-manager.io/docs/configuration/

For information on how to configure cert-manager to automatically provision
Certificates for Ingress resources, take a look at the `ingress-shim`
documentation:

https://cert-manager.io/docs/usage/ingress/
~~~~

</details>



