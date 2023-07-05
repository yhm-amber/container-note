
[pic::oops.ol]: https://social.dev-wiki.de/oops.gif
[pic::oops]: ./.assets/oops.gif

![oops!][pic::oops]

[pic-cfd-docs]: https://docs.joinmastodon.org/assets/network-models.jpg
[pic-cfd]: ./.assets/network-models.jpg

> ## What is Mastodon? 什么是乳齿象？
> 
> Welcome to the Mastodon documentation!
> 
> 欢迎使用 Mastodon 文档！ 
> 
> ### What is a microblog? 什么是微博？
> 
> Similar to how blogging is the act of publishing updates to a website,
>  **microblogging** is the act of publishing small updates to a stream of updates on your profile.
>  You can publish text posts and optionally attach media such as pictures, audio, video, or polls.
>  Mastodon lets you follow friends and discover new ones.
> 
> 类似于博客是将更新发布到网站的行为，
>  **微博** 是将小更新发布到您个人资料的更新流中的行为。
> 您可以发布文本帖子并可选择附加媒体，例如图片、音频、视频或投票。
>  Mastodon 可让您关注朋友并发现新朋友。 
> 
> ### What is federation? 什么是联邦？
> 
> **Federation** is a form of decentralization.
>  Instead of a single central service that all people use,
>  there are multiple services, that any number of people can use.
> 
> **联邦** 是权力下放的一种形式。
> 不是所有人都使用单一的中央服务，而是有多种服务，
> 任何数量的人都可以使用。
> 
> | Grade of centralization 集中程度 | Examples 举例 |
> | ----------------------- | -------- |
> | Centralized 集中式 | Twitter, Facebook, Instagram |
> | Federated 联邦式 | Email, XMPP, phone networks, physical mail |
> | Distributed 分散式 | BitTorrent, IPFS, Scuttlebutt |
> 
> A Mastodon website can operate alone.
>  Just like a traditional website, people sign up on it,
>  post messages, upload pictures and talk to each other.
>  *Unlike* a traditional website, Mastodon websites can interoperate,
>  letting their users communicate with each other;
>  just like you can send an email from your Gmail account to someone
>  from Outlook, Fastmail, Protonmail, or any other email provider,
>  as long as you know their email address,
>  **you can mention or message anyone on any website using their address**.
> 
> Mastodon 网站可以单独运营。
> 就像传统网站一样，人们可以在上面注册、发布消息、上传图片并相互交谈。
> 与传统网站 *不同* ， Mastodon 网站可以互操作，让用户相互交流；
> 就像您可以从 Gmail 帐户向 Outlook 、 Fastmail 、 Protonmail 或
> 任何其他电子邮件提供商发送电子邮件一样，只要您知道他们的电子邮件地址，
> **您就可以在任意网站上使用相应地址向任意人发送消息或者提及他们**。 
> 
> ![From left to right: Centralized, Federated, Distributed][pic-cfd]
> 
> *From left to right: Centralized, Federated, Distributed*
> 
> *从左到右：集中式、联合式、分布式*
> 
> ### What is ActivityPub? 什么是 ActivityPub ？
> 
> Mastodon uses a standardized, open protocol to implement federation.
>  It is called **ActivityPub**. Any software that likewise implements federation
>  via ActivityPub can seamlessly communicate with Mastodon,
>  just like Mastodon websites communicate with one another.
> 
> Mastodon 使用标准化、开放的协议来实现联邦。
> 它被称为 **ActivityPub** 。任何同样通过 ActivityPub 实现联合的软件
> 都可以与 Mastodon 无缝通信，就像 Mastodon 网站相互通信一样。
> 
> The fediverse (“federated universe”) is the name for all websites
>  that can communicate with each other over ActivityPub and the World Wide Web.
>  That includes all Mastodon servers, but also other implementations: 
> 
> 所谓 fediverse (“联合宇宙”) 是所有
> 可以通过 ActivityPub 和万维网相互通信的网站的名称。
> 这包括所有 Mastodon 服务器，但也包括其他实现： 
> 
> - Pleroma, a modular microblogging engine,
>   
>   Pleroma: 一个模块化的微博引擎
>   
> - Pixelfed, federated image sharing platform, which lets you share and consume media posts,
>   
>   Pixelfed: 联合图像共享平台，可让您共享和使用媒体帖子
>   
> - Misskey, which includes microblogging alongside a customizable dashboard,
>   
>   Misskey: 其中包括微博和可定制的仪表板
>   
> - PeerTube, which lets you upload videos to channels,
>   
>   PeerTube: 可让您将视频上传到频道
>   
> - Plume, which lets you publish longer-form articles,
>   
>   Plume: 它可以让你发表长篇文章
>   
> - and many more, including individual and personal websites!
>   
>   还有更多，包括一些独立或私人网站！
>   
> 
> The fediverse does not have its own brand,
>  so you might more often hear “follow me on Mastodon”
>  than “follow me on the fediverse”,
>  but technically the latter is more correct.
> 
> 
> Fediverse 并没有自己的品牌，
> 所以你可能更常听到“在 Mastodon 上关注我”
> 而不是“在 fediverse 上关注我”，
> 但从技术上讲，后者更正确。
> 

—— ref: [Mastodon documentation][docs]

see more: 

- [ActivityPub Rocks!][activitypub-site]
- [fediverse | GitHub Topics][fediverse-githubtopic]
- [Join a Server | Lemmy][lemmy-server]

[activitypub-site]: https://activitypub.rocks
[fediverse-githubtopic]: https://github.com/topics/fediverse
[lemmy-server]: https://join-lemmy.org/instances

-----

[site]: https://joinmastodon.org
[site-zh]: https://joinmastodon.org/zh

[docs]: https://docs.joinmastodon.org
[docs-zh]: https://docs.joinmastodon.org/zh-cn

[repo]: https://github.com/mastodon/mastodon.git

## Helm way

[repo-helm]: https://github.com/mastodon/chart.git

ref: 

- [mastodon/chart | GitHub][repo-helm]


