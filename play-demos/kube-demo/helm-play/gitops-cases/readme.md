
## Argo

基于 `argoproj.io/v1alpha1` 的 `Application` 类型的话，可以不用在 `Node` 上用有特权 `helm` 命令部署应用实例，而是创建特定 CRD 来完成这件事。

该类型说明见 [Argo 的笔记](../../../praxis-notes/argo-note#Application) 。

该 CRD 的安装，见应用 [`argo/argo-cd` 的安装笔记](../../../praxis-notes/argo-note#argo-cd) 。

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
  namespace: argocd
spec:
  project: adminer-taste
  syncPolicy:
    automated:
      selfHeal: true
  source:
    chart: adminer
    repoURL: https://cetic.github.io/helm-charts
    targetRevision: "*.*.*"
    helm:
      releaseName: adminer
  destination:
    server: "https://kubernetes.default.svc"
    namespace: db-tools
~~~

***名称空间注意**：在 `Application.metadata.namespace` 位置的值，上面示例里是 `argocd` ，但实际请务必是指与你安装的 `argo/argo-cd` 应用的名称空间一致！比如，如果你像[我这里](../../../praxis-notes/argo-note)这样，在安装 `argo/argo-cd` 时指定了 `-n argo` ，那么，在创建如上例所示的 `application.argoproj.io` 资源时，在 `.metadata.namespace` 的位置务必配置为 `argo` ，否则不能生效。*

其中的 `.spec.source.targetRevision` 必须要有值，否则会得到报错（我是从页面得到的）：

~~~ text
Unable to "Enable Auto-Sync:: application spec for adminer-demo is invalid: InvalidSpecError: spec.source.targetRevision is required if the manifest source is a helm chart
~~~

我基于[这里的讨论](https://github.com/renovatebot/renovate/issues/8212)把它写成 `"*.*.*"` 。这个时候，需要手动执行 `SYNC` ，除非[配置了自动同步](https://argo-cd.readthedocs.io/en/stable/user-guide/auto_sync/)，譬如中上面资源定义中的 `.spec.syncPolicy` 下的配置。

上述资源声明需要已经创建名为 `adminer-taste` 的 [ArgoCD 的 Project](https://argo-cd.readthedocs.io/en/stable/user-guide/projects/) 。这个地方不指定的话，默认就是 `default` 。下面是针对上面资源声明示例的 Project 定义：

~~~ yml
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: adminer-taste
  namespace: argocd
spec:
  clusterResourceWhitelist:
  - group: '*'
    kind: '*'
  destinations:
  - namespace: '*'
    server: '*'
  sourceRepos:
  - '*'
~~~

另外，在 `.spec.destination.server` 处的域名 `kubernetes.default.svc` ，是可以在容器内访问的：

<details>

<summary>域名访问验证记录</summary>

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

*这是一个在任意名称空间下启动的 `centos:7` 容器内的验证结果。*

</details>

创建资源后，进入 Argo-cd 的 WEB 页面（[方法](../../../praxis-notes/argo-note#web-gui)），也可以看到被创建的资源。




