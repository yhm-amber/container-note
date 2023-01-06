
# Byte Stream

## File

页面，本质上也只是一 (或多) 个文件。

文件就是字节流。而文件系统就是管理字节流的系统 (规范) 。

任何数据结构也都可以依据一个特定规则而暴露一个字节流格式的接口。

## Site

页面的访问必然包括对访问结果的展示，而这个展示必然伴随对文件的下载。这里的文件就是有关于 Web 页面的所有文件。

# The InterPlanetary File System

## IPFS

你可以用它分享你的网站——这本质上仍然只是分享[文件](#File)而已。

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

## application

### Instances

#### `kubo`

[kubo-repo]: https://github.com/ipfs/kubo.git
[goipfs-repo]: https://github.com/ipfs/go-ipfs.git

[Kubo][kubo-repo] 是一个 IPFS 的 Go 语言实现，原名为 [`go-ipfs`][goipfs-repo] 。

more see: 

- [`kubo note`](../kubo-note)

#### `iroh`

more see: 

- [`iroh note`](../iroh-note)

#### `fuzzy`

more see: 

- [`fuzzy note`](../fuzzy-note)

### Interfaces

#### `brave browser`

一个专为 Web3 设计的浏览器。

[brave-repo]: https://github.com/brave/brave-browser.git

IPFS 支持项：

- 如果在地址栏里存在 `/ipfs/` 字样，地址栏右端就会出现一个大意为 `用 IPFS 协议打开` 的按钮。这只是一个来自浏览器的猜测。
- 在对一个浏览器实例安装 IPFS 的后端支持补充后， [Brave Browser][brave-repo] 会成为 [IPFS Desktop][ipfs-desktop-repo] 的完整替代。
- 在 [settings](brave://settings) 页面中的 [ipfs](brave://settings/ipfs) 栏 (较旧版界面) 或 [web3](brave://settings/web3) 栏中的 IPFS 项 (较新版界面) 中，有 IPFS 相关的针对此浏览器实例的诸项配置。



#### `ipfs desktop`

默认执行程序为 Kubo 的用 Web 技术构建的图形界面。

[ipfs-desktop-repo]: https://github.com/ipfs/ipfs-desktop.git

功能与增加了 IPFS 后端支持补充后的 [Brave Browser][brave-repo] 相同，会把图形界面的操作转化为 Kubo 的命令行界面的指令来执行。

在 settings 中的 `CLI 引导模式` 选项设置为打开，就可以看到一个图形界面的操作的命令界面操作的等价。命令界面操作自然就是命令行的代码了！🙃

## cluster


docs: 

- kubo: 
  
  - ipns://ipfscluster.io/documentation/guides/k8s
  - https://ipfscluster.io/documentation/guides/k8s
  - https://ipfs-operator.readthedocs.io
  
- iroh: ...
- fuzzy: ...

repos: 

- kubo: 
  
  - https://github.com/ipfs-cluster/ipfs-cluster.git
  - https://github.com/ipfs-cluster/ipfs-operator.git
  - https://github.com/monaparty/helm-ipfs-cluster.git
  - https://github.com/redhat-et/ipfs-operator.git
  
- iroh: ...
- fuzzy: ...

sites: 

- kubo: 
  
  - ipns://ipfscluster.io/
  - https://ipfscluster.io/
  
- iroh: ...
- fuzzy: ...

instances: 

- [kubo][kubo-repo] backended instance: 
  
  - [`cluster | kubo note`](../kubo-note#cluster)
  
- iroh: ...
- fuzzy: ...

## pinning

[pinning-svc-compliance]: https://ipfs-shipyard.github.io/pinning-service-compliance
[pinging-svc-spec]: https://ipfs.github.io/pinning-services-api-spec
[pinging-svc-spec-repo]: https://github.com/ipfs/pinning-services-api-spec.git



[Pin files | IPFS Docs][docs-pin]


> Pinning is a very important concept in IPFS.
>  IPFS semantics try to make it feel like every single object is local
>  — there is no "retrieve this file for me from a remote server",
>  just `ipfs cat` or `ipfs get`, which act the same way no matter where the actual object is located.
> 
> Pinning 是 IPFS 中一个非常重要的概念。
>  IPFS 语义试图让它感觉每个对象都是本地的——没有“从远程服务器为我检索这个文件”，
> 只有 `ipfs cat` 或 `ipfs get` ，无论实际对象位于何处，它们的行为都是一样的。
> 
> While this is nice, sometimes you want to be able to control what you keep around.
>  **Pinning** is the mechanism that allows you to tell IPFS to always keep a given object somewhere
>  — the default being your local node, though this can be different if you use a [third-party remote pinning service][docs-pin-workwith].
>  IPFS has a fairly aggressive caching mechanism that will keep an object local for a short time
>  after you perform any IPFS operation on it, but these objects may get garbage-collected regularly.
>  To prevent that garbage collection, simply pin the CID you care about, or add it to [MFS][docs-mfs].
>  Objects added through `ipfs add` are pinned recursively by default. Things in MFS are not pinned by default,
>  but are protected from garbage-collection, so one can think about MFS as a mechanism for implicit pinning.
> 
> 虽然这很好，但有时您希望能够控制随身携带的物品。
>  **Pinning** 是一种机制，它允许您告诉 IPFS 始终将给定对象保存在某个地方
> ——默认情况下是您的本地节点，但如果您使用 [第三方远程固定服务][docs-pin-workwith] ，这可能会有所不同。
>  IPFS 有一个相当积极的缓存机制，在你对它执行任何 IPFS 操作后，
> 它会在短时间内将对象保留在本地，但这些对象可能会定期被垃圾收集。
> 要防止垃圾收集，只需固定您关心的 CID ，或将其添加到 [MFS][docs-mfs] 。
> 通过 `ipfs add` 添加的对象默认是递归固定的。默认情况下， MFS 中的内容不会固定，
> 但会受到垃圾收集保护，因此可以将 MFS 视为一种隐式固定机制。
> 

[docs-pin]: https://docs.ipfs.tech/how-to/pin-files
[docs-pin-workwith]: https://docs.ipfs.tech/how-to/work-with-pinning-services
[docs-mfs]: https://docs.ipfs.tech/concepts/file-systems/#mutable-file-system-mfs


> There are three types of pins in the IPFS world: 
> 
> - **Direct pins**, which pin just a single block and no others in relation to it.
>   
>   **直接固定**：它只固定一个块，没有其他相关的块。
>   
> - **Recursive pins**, which pin a given block and all of its children.
>   
>   **递归引脚**：用于固定给定块及其所有子块。
>   
> - **Indirect pins**, which are the result of a given block's parent being pinned recursively.
>   
>   **间接固定**：这是给定块的父级被递归固定的结果。
>   
> 



> All the information above assumes that you're pinning items locally
>  — that is, to your local IPFS node. That's the default behavior for IPFS,
>  but it's also possible to pin your files to a *remote pinning service*.
>  These third-party services give you the opportunity to pin files not to your own local node,
>  but to nodes that they operate. You don't need to worry about your own node's available disk space or uptime.
> 
> 上面的所有信息都假定您在本地固定项目
> ——也就是说，固定到您的本地 IPFS 节点。这是 IPFS 的默认行为，
> 但也可以将文件固定到 *远程固定服务* 。这些第三方服务让您有机会不将文件固定到您自己的本地节点，
> 而是固定到它们运行的节点。您无需担心自己节点的可用磁盘空间或正常运行时间。
> 
> While you can use a remote pinning service's own GUI, CLI, or other dev tools
>  to manage IPFS files pinned to their service, you can also work directly with
>  pinning services using your local IPFS installation — meaning that you don't need
>  to learn a pinning service's unique API or other tooling.
> 
> 虽然您可以使用远程固定服务自己的 GUI 、 CLI 或其他开发工具
> 来管理固定到其服务的 IPFS 文件，但您也可以使用本地 IPFS 安装直接使用固定服务
> ——这意味着您不需要学习固定服务的独特 API 或其他工具。
> 
> - The IPFS [Pinning Service API][pinging-svc-spec] offers a specification
>    that enables developers to integrate any pinning service that supports
>    the spec, or create their own. Thanks to the OpenAPI spec format,
>    both clients and servers can be [generated][pinging-svc-spec-repo-generation] from the YAML spec file.
>   
>   IPFS [固定服务 API][pinging-svc-spec] 提供一个规范，使开发人员能够集成任何支持该规范的固定服务，
>   或创建他们自己的服务。得益于 OpenAPI 规范格式，可以 [生成][pinging-svc-spec-repo-generation] 客户端和服务器自 YAML 规范文件。
>   
> - If you use Kubo 0.8+ from the command line, you have access to `ipfs pin remote` commands
>    acting as a client for interacting with pinning service APIs.
>    Add your favorite pinning service(s), pin CIDs under human-readable names,
>    get pin statuses, and more, straight from the CLI. [Learn how →][docs-pin-workwith]
>   
>   如果您从命令行使用 Kubo 0.8+ ，您可以访问 `ipfs pin remote` 命令，
>   作为与固定服务 API 交互的客户端。直接从 CLI 添加您最喜欢的固定服务、
>   以人类可读的名称固定 CID、获取固定状态等。[了解如何 →][docs-pin-workwith]
>   
> - [IPFS Desktop][repo-shipyard-ipfs-desktop] and its equivalent in-browser IPFS web interface,
>    the [IPFS Web UI][repo-shipyard-ipfs-webui] , both support remote pinning services,
>    so you can pin to your favorite pinning service(s) straight from the UI. [Learn how →][docs-pin-workwith]
>   
>   [IPFS 桌面][repo-shipyard-ipfs-desktop] 及其等效的浏览器内 IPFS Web 界面：
>    [IPFS Web UI][repo-shipyard-ipfs-webui] ，两者都支持远程固定服务，
>   因此您可以直接从 UI 固定到您最喜欢的固定服务。[了解如何 →][docs-pin-workwith]
>   
> 

[repo-shipyard-ipfs-webui]: https://github.com/ipfs-shipyard/ipfs-webui.git
[repo-shipyard-ipfs-desktop]: https://github.com/ipfs-shipyard/ipfs-desktop.git
[pinging-svc-spec-repo-generation]: https://github.com/ipfs/pinning-services-api-spec#code-generation


一些 Pin 服务：

[pinsvc-web3.storage]: https://web3.storage/docs/how-tos/pinning-services-api
[pinsvc-pinata]: https://docs.pinata.cloud/#PinningServicesAPI
[pinsvc-filebase]: https://docs.filebase.com/api-documentation/ipfs-pinning-service-api
[pinsvc-estuary]: https://docs.estuary.tech/tutorial-get-an-api-key

- [Docs | Web3 Storage - The simple file storage service for IPFS & Filecoin.][pinsvc-web3.storage]
- [Welcome to Pinata Docs | Pinata Docs][pinsvc-pinata]
- [IPFS Pinning Service API | Filebase][pinsvc-filebase]
- [Estuary Documentation: Tutorial: Get an API Key | Estuary][pinsvc-estuary]

