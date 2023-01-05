
曾用名： `go-ipfs`

## with brave

repo: https://github.com/ipfs/ipfs-companion.git

这是个插件。中文名是 IPFS 伴侣（[查看功能](https://github.com/ipfs-shipyard/ipfs-companion#ipfs-companion-features)）。

它会告诉你，同 Brave 一起使用时，不必再安装 `ipfs/ipfs-desktop` 。

repo: https://github.com/ipfs/kubo.git

如果你用 [Brave][brave-repo] 访问

[brave-repo]: https://github.com/brave/brave-browser.git

## kubo

[dtp]: ipns://docs.ipfs.tech/install/ipfs-desktop/
[cli]: ipns://docs.ipfs.tech/how-to/command-line-quick-start

不论是[界面][dtp]还是[命令行][cli]，都有统一的底层执行程序 Kubo 。这是一个 IPFS 的 Go 语言实现。



## intro

工作原理

[how-local]: http://docs-ipfs-tech.ipns.localhost:48081/concepts/how-ipfs-works
[how-ipns]: ipns://docs.ipfs.tech/concepts/how-ipfs-works
[how-https]: https://docs.ipfs.tech/concepts/how-ipfs-works

- 本地文档：[`http-48081`][how-local]
- 线上文档：[`ipns`][how-ipns] [`https`][how-https]


## ipns

在这个点对点网络中担当域名解析的工作。

- [http://docs-ipfs-tech.ipns.localhost:48081/concepts/ipns](http://docs-ipfs-tech.ipns.localhost:48081/concepts/ipns)
- [ipns://docs.ipfs.tech/concepts/ipns](ipns://docs.ipfs.tech/concepts/ipns)

譬如：

- `ipfs://bafybeifc4txki2gjnkfbsagx7ya2l2mqo2hptc6ewyy7bg37a3enxo6kim`
- `ipns://ipfs.tech`

这俩就是一样的。这是 IPFS 的主站，其内容上也和 `https://ipfs.tech` 一样，不过 `https` 协议下的域名解析是由传统的中心化 DNS 服务提供。

## demo

ref: https://jobcher.com/ipfs/

- [orbit for chat][orbit]
- [akasha for world][akasha]


[dtube]: ipfs://bafybeigbpc5ubhik5khftu4vancanucyqml64s2bep2cswi4mq6hx2rg64
[orbit]: ipns://orbit.chat/
[akasha]: ipns://akasha.world/


## cluster

docs: 

- ipns://ipfscluster.io/documentation/guides/k8s
- https://ipfscluster.io/documentation/guides/k8s
- https://ipfs-operator.readthedocs.io

repo:

- https://github.com/ipfs-cluster/ipfs-cluster.git
- https://github.com/ipfs-cluster/ipfs-operator.git
- https://github.com/monaparty/helm-ipfs-cluster.git
- https://github.com/redhat-et/ipfs-operator.git

site:

- ipns://ipfscluster.io/
- https://ipfscluster.io/

### with operator

ref: 

- https://ipfs-operator.readthedocs.io
- https://github.com/redhat-et/ipfs-operator.git
- https://github.com/ipfs-cluster/ipfs-operator.git

*(repo `redhat-et/ipfs-operator` is `ipfs-cluster/ipfs-operator` now :P)*

~~~ sh
helm install ipfs-operator ./helm/ipfs-operator
~~~

~~~ yaml
apiVersion: cluster.ipfs.io/v1alpha1
kind: IpfsCluster
metadata:
  name: ipfs-sample-1
spec:
  url: apps.example.com
  ipfsStorage: 2Gi
  clusterStorage: 2Gi
  replicas: 5
  public: true
  follows: []
  networking:
    circuitRelays: 1
~~~

~~~ sh
kubectl create namespace my_cluster
kubectl -n my_cluster apply -f ipfs.yaml

# verify
kubectl -n my_cluster status ipfs-sample-1
~~~
