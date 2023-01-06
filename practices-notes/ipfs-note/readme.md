

## File

页面，本质上也只是一 (或多) 个文件。

文件就是字节流。而文件系统就是管理字节流的系统 (规范) 。

任何数据结构也都可以依据一个特定规则而暴露一个字节流格式的接口。

## Site

页面的访问必然包括对访问结果的展示，而这个展示必然伴随对文件的下载。这里的文件就是有关于 Web 页面的所有文件。

## IPFS

你可以用它制作你的网站——这本质上仍然只是分享[文件](#File)而已。

你也可以只是把它当作一个分布式的文件系统，分享并非是一个网站的任何文件。

你可以用 CID 访问任何一个在 IPFS 网络中被共享过的文件/目录， CID 会被转换为 `ipfs` 协议的地址，如下面的 CID 向地址的转换：

- [CID][ipfs-share-ipx-643] [Link][ipfs-link-ipx-643]
- [CID][ipfs-share-cyberedge-s01] [Link][ipfs-link-cyberedge-s01]

[ipfs-share-ipx-643]: https://ipfs.io/ipfs/QmYdBXT4NAJTPg33g3qc26PgkW3MqVaQpW9SmoyaqFhKA2
[ipfs-link-ipx-643]: ipfs://bafybeiey2eazwdwyvji3lrhyggtj6anleyqa6kuwxx54ldvddvragek56m
[ipfs-share-cyberedge-s01]: https://ipfs.io/ipfs/QmY78Z7vpLzVh5SZpyc2QjPCeDXT1xFSKKMoy6kyY2rdpb
[ipfs-link-cyberedge-s01]: ipfs://bafybeierdy4pe2r5ew67atzk3ntp7gnfymfckqi653sb7hte2c7eftp7oa/

工作原理

[how-local]: http://docs-ipfs-tech.ipns.localhost:48081/concepts/how-ipfs-works
[how-ipns]: ipns://docs.ipfs.tech/concepts/how-ipfs-works
[how-https]: https://docs.ipfs.tech/concepts/how-ipfs-works

- 本地文档：[`http-48081`][how-local]
- 线上文档：[`ipns`][how-ipns] [`https`][how-https]

## IPNS

介绍：

- [http://docs-ipfs-tech.ipns.localhost:48081/concepts/ipns](http://docs-ipfs-tech.ipns.localhost:48081/concepts/ipns)
- [ipns://docs.ipfs.tech/concepts/ipns](ipns://docs.ipfs.tech/concepts/ipns)
- [https://docs.ipfs.tech/concepts/ipns](https://docs.ipfs.tech/concepts/ipns)

功能简而言之就是，在这个 (使用 `ipfs` 协议的) 点对点网络中担当域名解析的工作。

譬如把对下列第一个 URL 的访问解析为访问第二个 URL (即同时也是在浏览器地址栏中把下列第二项替换为第一项) ：

- `ipns://ipfs.tech` `ipfs://bafybeifc4txki2gjnkfbsagx7ya2l2mqo2hptc6ewyy7bg37a3enxo6kim`
- `ipns://docs.ipfs.tech` `ipfs://bafybeid5nts3o73veyddbaewlat32xlnlc4cclen6oljdunwibzycj76se`

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

[kubo-repo]: https://github.com/ipfs/kubo.git

instance by [kubo][kubo-repo] see: 

- [`kubo note - cluster`](../kubo-note#cluster)

