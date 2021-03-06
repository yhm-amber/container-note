
## install eck



### repo

~~~~
helm repo add -- elastic https://helm.elastic.co
~~~~

### `elasticsearch`

ref: https://artifacthub.io/packages/helm/elastic/elasticsearch

~~~ sh
helm install -n elasticsearch --create-namespace -- elasticsearch elastic/elasticsearch
~~~

out:

~~~~
NAME: elasticsearch
LAST DEPLOYED: Fri Jun 17 11:59:45 2022
NAMESPACE: elasticsearch
STATUS: deployed
REVISION: 1
NOTES:
1. Watch all cluster members come up.
  $ kubectl get pods --namespace=elasticsearch -l app=elasticsearch-master -w2. Test cluster health using Helm test.
  $ helm --namespace=elasticsearch test elasticsearch
~~~~

<details>

<summary>（它这个提示信息有点问题， `NOTES` 部分按说应该是这样。。。）</summary>

~~~~
NOTES:
1. Watch all cluster members come up.
  $ kubectl get pods --namespace=elasticsearch -l app=elasticsearch-master -w
2. Test cluster health using Helm test.
  $ helm --namespace=elasticsearch test elasticsearch
~~~~

</details>

### `kibana`

要配一个 es 的地址，别的没啥。

~~~ sh
helm install -n kibana --create-namespace \
    --set elasticsearchHosts=http://elasticsearch-master-headless.elasticsearch.svc.cluster.local:9200 \
    -- kibana elastic/kibana
~~~

out:

~~~
NAME: kibana
LAST DEPLOYED: Fri Jun 17 16:16:48 2022
NAMESPACE: kibana
STATUS: deployed
REVISION: 1
TEST SUITE: None
~~~

然后服务里面会有一个开放 `5901` 端口的服务。你也可以自己再创一个 `nodeport` 吧这个端口放出去。

### `operator`

用 operator 创建实例的方式部署，适用于需要灵活创建不同 ES 资源的场景。

目前，上面那俩的安装没有依赖这里创建的 CRD ，所以如果创几个就够了的话，这个 operator 的方式其实不必要。

refs :
- ref: https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-install-helm.html
- ref-src: https://github.com/elastic/cloud-on-k8s/tree/main/docs/operating-eck
- ref-a: https://artifacthub.io/packages/helm/elastic/eck-operator
- ref-o: https://operatorhub.io/operator/elastic-cloud-eck


`eck-operator` ：可以用选项控制是否一起安装 `eck-operator-crds` 。
`eck-operator-crds` ：用来单独安装 CRDs 。

全局安装：

~~~ sh
helm install -n elastic-system --create-namespace -- elastic-operator elastic/eck-operator
~~~

out:

~~~
NAME: elastic-operator
LAST DEPLOYED: Fri Jun 17 16:03:16 2022
NAMESPACE: elastic-system
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
1. Inspect the operator logs by running the following command:
   kubectl logs -n elastic-system sts/elastic-operator
~~~

局部安装，这样可以把 operator 限制在预定义命名空间里；其中 CRD 和 CRD 以外的部分分别安装：

~~~ sh
helm install -n elastic-system --create-namespace -- elastic-operator-crds elastic/eck-operator-crds
helm install -n elastic-system --create-namespace \
  --set installCRDs=false,managedNamespaces='{namespace-a, namespace-b}' \
  --set createClusterScopedResources=false,webhook.enabled=false,config.validateStorageClass=false \
  -- elastic-operator elastic/eck-operator
~~~

别的选项的使用见参考（ ref ）页面。

然后可以基于这个里面的【 Custom Resource Definitions 】的例子创建你需要的实例吧： https://operatorhub.io/operator/elastic-cloud-eck

