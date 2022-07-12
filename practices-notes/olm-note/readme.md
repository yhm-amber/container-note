
ref: https://olm.operatorframework.io/docs/getting-started/  

~~~ sh
operator-sdk olm install
~~~

需要先有 `operator-sdk` ……这东西应该是正在跟 `kubebuilder` 合并，但是看官网的话好像安装起来还是就安它自己： https://sdk.operatorframework.io/docs/installation/ 

取得 `operator-sdk` 命令，大体就是下了个二进制然后加执行权限后挪到 `PATH` 路径下。

用它安装 `olm` 的时候，因为是从 github 下载 release 所以可能会联网失败。我这里有个比较笨的解决办法：

~~~ sh
while ! operator-sdk olm install ; do echo :::: $((++x)) ; done
~~~

就是失败自动重试。看了眼[帮助文档](https://sdk.operatorframework.io/docs/cli/operator-sdk_olm_install/)，没找到 Airgap 安装的途径。

卸载命令 `uninstall` 也是同理，必须联网卸载。

--------------

卸载会造成一个严重的问题，详细见该 issue ： https://github.com/operator-framework/operator-lifecycle-manager/issues/1304

现象简单说就是，这个卸载会特地把 olm 命名空间变成“终止中”的状态并永远如此。

我执行了 `kubectl delete apiservices.apiregistration.k8s.io v1.packages.operators.coreos.com` 后成功删除。

用 `kubectl get ns olm -o yaml | less` 看状态：

~~~ yaml
...skipping...
  name: olm
  resourceVersion: "29395972"
  selfLink: /api/v1/namespaces/olm
  uid: 6fef1747-aede-4470-9a84-700b3845a79c
spec:
  finalizers:
  - kubernetes
status:
  conditions:
  - lastTransitionTime: "2022-07-12T07:49:54Z"
    message: 'Discovery failed for some groups, 1 failing: unable to retrieve the
      complete list of server APIs: packages.operators.coreos.com/v1: the server is
      currently unable to handle the request'
    reason: DiscoveryFailed
    status: "True"
    type: NamespaceDeletionDiscoveryFailure
  - lastTransitionTime: "2022-07-12T07:50:45Z"
    message: All legacy kube types successfully parsed
    reason: ParsedGroupVersions
    status: "False"
    type: NamespaceDeletionGroupVersionParsingFailure
...skipping...
  phase: Terminating
~~~

其中提到了关于 `packages.operators.coreos.com/v1` 类型资源的问题。

