
基于 `argoproj.io/v1alpha1` 的 `Application` 类型的话，可以不用在 `Node` 上用有特权 `helm` 命令部署应用实例，而是创建特定 CRD 来完成这件事。

该类型说明见 [Argo 的笔记](../../../practices-notes/argo-note#Application) 。

该 CRD 的安装，见应用 [`argo/argo-cd` 的安装笔记](../../../practices-notes/argo-note#argo-cd) 。

简单说，就是在 `Application.spec` 下面的 `source` 和 `destination` 分别指定实例的 *来源* 和 *去往* ，而且在 *来源* 里面，不仅可以指定 Helm Chart 为来源，还可以是 Kustomize 类型的来源。

要用这个 CRD 创建特定的 Helm Chart 实例的话，比如：

~~~ yaml

~~~



