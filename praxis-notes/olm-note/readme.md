
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

卸载会造成一个严重的问题，即 `olm` 命名空间永远处在删除中的状态。详细见该 issue ： https://github.com/operator-framework/operator-lifecycle-manager/issues/1304

参考 issue 中的一些提示，我执行了 `kubectl delete apiservices.apiregistration.k8s.io v1.packages.operators.coreos.com` 后成功删除。

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

但是，除了命名空间的问题外，它仍然有不能卸载干净的问题，这在你再次执行 `operator-sdk olm install --version latest` 时遇到的报错可以看出：

~~~ log
FATA[0111] Failed to install OLM version "latest": detected existing OLM resources: OLM must be completely uninstalled before installation
~~~

我见到过的报错内容如此的错误代号有： `FATA[0043]` `FATA[0046]` `FATA[0052]` `FATA[0053]` `FATA[0056]` `FATA[0060]` `FATA[0061]` `FATA[0066]` `FATA[0070]` `FATA[0078]` `FATA[0079]` `FATA[0080]` `FATA[0082]` `FATA[0085]` `FATA[0088]` `FATA[0089]` `FATA[0093]` `FATA[0096]` `FATA[0098]` `FATA[0105]` `FATA[0107]` `FATA[0109]` `FATA[0111]` `FATA[0117]` `FATA[0118]` `FATA[0119]` `FATA[0131]` `FATA[0133]` ...

还有各种网络原因的报错： `FATA[0035]` `FATA[0123]` `FATA[0033]` `FATA[0045]` `FATA[0023]` `FATA[0014]` ...

卸载的时候会有这样的输出，最后一行有个报错：

~~~
I0714 16:33:04.124610   31788 request.go:601] Waited for 1.031806169s due to client-side throttling, not priority and fairness, request: GET:https://apiserver.cluster.local:6443/apis/batch/v1?timeout=32s
INFO[0008] Fetching CRDs for version "latest"
INFO[0008] Fetching resources for resolved version "latest"
I0714 16:34:10.056834   31788 request.go:601] Waited for 1.0469403s due to client-side throttling, not priority and fairness, request: GET:https://apiserver.cluster.local:6443/apis/gitjob.cattle.io/v1?timeout=32s
I0714 16:34:20.107117   31788 request.go:601] Waited for 2.296507411s due to client-side throttling, not priority and fairness, request: GET:https://apiserver.cluster.local:6443/apis/policy/v1beta1?timeout=32s
I0714 16:34:30.156374   31788 request.go:601] Waited for 2.146908897s due to client-side throttling, not priority and fairness, request: GET:https://apiserver.cluster.local:6443/apis/network.kubesphere.io/v1alpha1?timeout=32s
INFO[0090] Uninstalling resources for version "latest"
INFO[0090]   Deleting CustomResourceDefinition "catalogsources.operators.coreos.com"
INFO[0090]     CustomResourceDefinition "catalogsources.operators.coreos.com" does not exist
INFO[0090]   Deleting CustomResourceDefinition "clusterserviceversions.operators.coreos.com"
INFO[0090]     CustomResourceDefinition "clusterserviceversions.operators.coreos.com" does not exist
INFO[0090]   Deleting CustomResourceDefinition "installplans.operators.coreos.com"
INFO[0090]     CustomResourceDefinition "installplans.operators.coreos.com" does not exist
INFO[0090]   Deleting CustomResourceDefinition "olmconfigs.operators.coreos.com"
INFO[0090]     CustomResourceDefinition "olmconfigs.operators.coreos.com" does not exist
INFO[0090]   Deleting CustomResourceDefinition "operatorconditions.operators.coreos.com"
INFO[0090]     CustomResourceDefinition "operatorconditions.operators.coreos.com" does not exist
INFO[0090]   Deleting CustomResourceDefinition "operatorgroups.operators.coreos.com"
INFO[0090]     CustomResourceDefinition "operatorgroups.operators.coreos.com" does not exist
INFO[0090]   Deleting CustomResourceDefinition "operators.operators.coreos.com"
INFO[0090]     CustomResourceDefinition "operators.operators.coreos.com" does not exist
INFO[0090]   Deleting CustomResourceDefinition "subscriptions.operators.coreos.com"
INFO[0090]     CustomResourceDefinition "subscriptions.operators.coreos.com" does not exist
INFO[0090]   Deleting Namespace "olm"
INFO[0090]     Namespace "olm" does not exist
INFO[0090]   Deleting Namespace "operators"
INFO[0090]     Namespace "operators" does not exist
INFO[0090]   Deleting ServiceAccount "olm/olm-operator-serviceaccount"
INFO[0090]     ServiceAccount "olm/olm-operator-serviceaccount" does not exist
INFO[0090]   Deleting ClusterRole "system:controller:operator-lifecycle-manager"
INFO[0090]     ClusterRole "system:controller:operator-lifecycle-manager" does not exist
INFO[0090]   Deleting ClusterRoleBinding "olm-operator-binding-olm"
INFO[0090]     ClusterRoleBinding "olm-operator-binding-olm" does not exist
INFO[0090]   Deleting OLMConfig "cluster"
FATA[0095] Failed to uninstall OLM: no matches for kind "OLMConfig" in version "operators.coreos.com/v1"
~~~

我找到了这个： https://operator-framework.github.io/olm-book/docs/uninstall-olm.html

根据里面的提示，可以用这样的方法删干净 `olm` ：

- 基于版本（比如 `v0.21.2` ）：
  
  ~~~ sh
  export OLM_RELEASE=v0.21.2
  kubectl delete apiservices.apiregistration.k8s.io v1.packages.operators.coreos.com
  kubectl delete -f https://github.com/operator-framework/operator-lifecycle-manager/releases/download/${OLM_RELEASE}/crds.yaml
  kubectl delete -f https://github.com/operator-framework/operator-lifecycle-manager/releases/download/${OLM_RELEASE}/olm.yaml
  ~~~
  
- 基于主分支：
  
  ~~~ sh
  kubectl delete apiservices.apiregistration.k8s.io v1.packages.operators.coreos.com
  kubectl delete -f https://raw.githubusercontent.com/operator-framework/operator-lifecycle-manager/master/deploy/upstream/quickstart/crds.yaml
  kubectl delete -f https://raw.githubusercontent.com/operator-framework/operator-lifecycle-manager/master/deploy/upstream/quickstart/olm.yaml
  ~~~
  

卸载后验证（就是找找相应资源是否存在都没有就是卸了）：

~~~ sh
kubectl get crd | fgrep operators.coreos.com
kubectl get deploy -n olm
kubectl get role -n olm
kubectl get rolebinding -n olm
kubectl get ns olm
~~~


