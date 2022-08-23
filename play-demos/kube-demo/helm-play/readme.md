
## Argo

基于 `argoproj.io/v1alpha1` 的 `Application` 类型的话，可以不用在 `Node` 上用有特权 `helm` 命令部署应用实例，而是创建特定 CRD 来完成这件事。

该类型说明见 [Argo 的笔记](../../../practices-notes/argo-note#Application) 。

该 CRD 的安装，见应用 [`argo/argo-cd` 的安装笔记](../../../practices-notes/argo-note#argo-cd) 。

简单说，就是在 `Application.spec` 下面的 `source` 和 `destination` 分别指定实例的 *来源* 和 *去往* ，而且在 *来源* 里面，不仅可以指定 Helm Chart 为来源，还可以是 Kustomize 类型的来源。

### 创

用这个 CRD 创建特定的 Helm Chart 的简单示例。

比如对于这个 `helm` 应用：

~~~ sh
helm repo add -- cetic https://cetic.github.io/helm-charts
helm install -n db-tools -- adminer cetic/adminer
~~~

对应的 `v1alpha1.argoproj.io Application` 资源定义（ [ref](https://argo-cd.readthedocs.io/en/stable/user-guide/helm/) ）：

~~~ yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: adminer-demo
  namespace: argocd-demos
spec:
  project: default
  source:
    chart: adminer
    repoURL: https://cetic.github.io/helm-charts
    helm:
      releaseName: adminer
  destination:
    server: "https://kubernetes.default.svc"
    namespace: db-tools
~~~

其中的域名 `kubernetes.default.svc` 是可以在容器内访问的：

<details>

<summary>域名访问验证记录</summary>

*这是一个在任意名称空间下启动的 `centos:7` 容器内的验证结果*

~~~ text
sh-4.2# ping kubernetes.default.svc
PING kubernetes.default.svc.cluster.local (10.96.0.1) 56(84) bytes of data.
64 bytes from kubernetes.default.svc.cluster.local (10.96.0.1): icmp_seq=1 ttl=64 time=0.454 ms
64 bytes from kubernetes.default.svc.cluster.local (10.96.0.1): icmp_seq=2 ttl=64 time=0.073 ms
64 bytes from kubernetes.default.svc.cluster.local (10.96.0.1): icmp_seq=3 ttl=64 time=0.081 ms
64 bytes from kubernetes.default.svc.cluster.local (10.96.0.1): icmp_seq=4 ttl=64 time=0.086 ms
64 bytes from kubernetes.default.svc.cluster.local (10.96.0.1): icmp_seq=5 ttl=64 time=0.064 ms
64 bytes from kubernetes.default.svc.cluster.local (10.96.0.1): icmp_seq=6 ttl=64 time=0.076 ms
^C
--- kubernetes.default.svc.cluster.local ping statistics ---
6 packets transmitted, 6 received, 0% packet loss, time 5005ms
rtt min/avg/max/mdev = 0.064/0.139/0.454/0.141 ms
sh-4.2# 
~~~

</details>



