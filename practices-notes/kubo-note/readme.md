
曾用名： `go-ipfs`

[kubo-repo]: https://github.com/ipfs/kubo.git
[goipfs-repo]: https://github.com/ipfs/go-ipfs.git
[companion-repo]: https://github.com/ipfs/ipfs-companion.git
[desktop-repo]: https://github.com/ipfs/ipfs-desktop.git

[site.tech-https]: https://ipfs.tech

## with brave

### plugin (optional)

repo: https://github.com/ipfs/ipfs-companion.git

这是个插件。中文名是 [IPFS 伴侣][companion-repo] ([查看功能](https://github.com/ipfs-shipyard/ipfs-companion#ipfs-companion-features)) 。

它会告诉你，同 Brave 一起使用时，不必再安装 [`ipfs/ipfs-desktop`][desktop-repo] 。

在 [Brave][brave-repo] 上使用 IPFS 时，该插件并非必要，但能方便你好多事情。

它的核心功能仍然是依托于在下文提到的弹出页面安装的 [`go-ipfs`][goipfs-repo] 即 [`kubo`][kubo-repo] 。

### kubo

repo: https://github.com/ipfs/kubo.git

如果你用 [Brave][brave-repo] 访问支持 IPFS/IPNS 的网站 (如 [ipfs.tech][site.tech-https] ) ，在地址栏会多出一个有 `IPFS` 字样的按钮，单击即可访问[该网站的 `ipfs://` 协议的页面](ipfs://bafybeifc4txki2gjnkfbsagx7ya2l2mqo2hptc6ewyy7bg37a3enxo6kim)。

[brave-repo]: https://github.com/brave/brave-browser.git

在 [Brave][brave-repo] 访问 `ipfs://` 协议的页面有两个途径，其中一个就是为该浏览器实例安装 [`go-ipfs`][goipfs-repo] (即 [`kubo`][kubo-repo]) 的后端。

若想进入这个安装的引导界面，只需在没对该浏览器实例安装 [`go-ipfs`][goipfs-repo] 的前提下用它访问一个 `ipfs://` 协议的地址即可。可以用前文提到的办法访问一个 `ipfs://` 协议的页面。

完成安装后，你的该 Brave 浏览器实例就同时成为了一个具有 [IPFS Desktop][desktop-repo] 所有功能的用户图形界面。这也是为什么前面提到的插件会在自己的页面告诉你，如用 [Brave Browser][brave-repo] 则不必再安装 [IPFS Desktop][desktop-repo] 。

如果你已有 [伴侣插件][companion-repo] ，则 `ipfs://` 协议的地址会被转换为可读的 `ipns://` 协议的地址。这里的域名一般同该网站使用 `https://` 协议时的域名相同——因而你会发现，你每次访问那些支持 IPFS 并且有这样的 IPNS 域名的网站的时候，该插件会自动帮你把 url 中的 `https` 协议改为 `ipns` ——一个简洁无比的转换。🙃

*(当然，看上去是个很简洁的变换，但 `https` 和 `ipns` 很不一样。前者是基于 DNS 来完成域名解析工作的。)*

## kubo

[dtp]: https://docs.ipfs.tech/install/ipfs-desktop/
[cli]: https://docs.ipfs.tech/how-to/command-line-quick-start

不论是[图形界面][dtp]还是[命令行][cli]，都基于一个统一的程序 Kubo 来执行，区别只在于界面 (Interface) 。

[Kubo][kubo-repo] 是一个 IPFS 的 Go 语言实现，原名为 [`go-ipfs`][goipfs-repo] 。


## ipfs

工作原理

[how-local]: http://docs-ipfs-tech.ipns.localhost:48081/concepts/how-ipfs-works
[how-ipns]: ipns://docs.ipfs.tech/concepts/how-ipfs-works
[how-https]: https://docs.ipfs.tech/concepts/how-ipfs-works

- 本地文档：[`http-48081`][how-local]
- 线上文档：[`ipns`][how-ipns] [`https`][how-https]

see also: 

- [`ipfs note`](../ipfs-note)

## ipns

介绍：

- [http://docs-ipfs-tech.ipns.localhost:48081/concepts/ipns](http://docs-ipfs-tech.ipns.localhost:48081/concepts/ipns)
- [ipns://docs.ipfs.tech/concepts/ipns](ipns://docs.ipfs.tech/concepts/ipns)
- [https://docs.ipfs.tech/concepts/ipns](https://docs.ipfs.tech/concepts/ipns)

功能简而言之就是，在这个 (使用 `ipfs` 协议的) 点对点网络中担当域名解析的工作。

譬如把对下列第一个 URL 的访问解析为访问第二个 URL (即同时也是在浏览器地址栏中把下列第二项替换为第一项) ：

- `ipns://ipfs.tech` `ipfs://bafybeifc4txki2gjnkfbsagx7ya2l2mqo2hptc6ewyy7bg37a3enxo6kim`
- `ipns://docs.ipfs.tech` `ipfs://bafybeid5nts3o73veyddbaewlat32xlnlc4cclen6oljdunwibzycj76se`



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
