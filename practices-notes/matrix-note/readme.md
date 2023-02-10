
[docs.spec]: https://matrix.org/docs/spec
[faq]: https://matrix.org/faq
[spec.src/gh]: https://github.com/matrix-org/matrix-spec.git
[repo-rich-text-editor]: https://github.com/matrix-org/matrix-rich-text-editor.git

> Matrix is an open specification for an online communication protocol.
>  It includes all the features you'd expect from a modern chat platform
>  including instant messaging, group chats, audio and video calls,
>  searchable message history, synchronization across all your devices,
>  and end-to-end encryption.
>  Matrix is federated, so no single company controls the system or your data.
>  You can use an existing server you trust or run your own, and the servers synchronize messages seamlessly.
>  Learn more in the [Introduction to Matrix][ruma-intro-matrix].
> 
> Matrix 是一个在线通信协议的开放规范。
> 它包括你期望从一个现代聊天平台获得的所有功能，包括即时通讯、群聊、音频和视频通话、可搜索的消息历史、在你所有设备上的同步以及端到端的加密。
>  Matrix 是联盟式的，所以没有一个公司控制着系统或你的数据。
> 你可以使用你信任的现有服务器或运行你自己的服务器，而且这些服务器可以无缝地同步信息。
> 在 [Matrix 简介][ruma-intro-matrix] 中了解更多。
> 

[ruma-repo]: https://github.com/ruma/ruma.git
[ruma-intro-matrix]: https://ruma.io/docs/matrix

[📑 规范][docs.spec] | [🦪 spec.src/gh][spec.src/gh] | [📔 问答][faq]

简单说，这个的架构和 Fediverse 类似，但是有端到端加密、被设计用于私聊和群聊，
聊天的时候要验证设备 (包括对方设备) (也可以不验证但这就不够安全) ，新设备也必须被旧设备协助
验证并通过 (或者直接输入密钥) 才可以浏览之前的信息 (否则信息就是加密的不可浏览所以即便登录了也看不到) 。

需要邮箱，一个账号可以绑定多个用于找回密码的邮箱 (但信息解密密钥不能被找回只能自己记好在一个什么地方) ，
需要通过支持 matrix 协议的应用来连接 matrix 的实例 (服务) ，一般大家都是用 `matrix.org` 这个实例的，
但由于支持子托管服务因此可以用的实例不止这个。

为了避免被大公司监视，很多民间和政府的组织会自建内部使用的服务，从而用这个端到端加密的协议来沟通。

有很多应用支持该协议，甚至有那么些应用是专门为这个协议而实现的。具体有下：

[fluffychat/site]: https://fluffychat.im
[fluffychat/app.web]: https://fluffychat.im/web
[fluffychat/app.f-droid]: https://f-droid.org/de/packages/chat.fluffy.fluffychat
[fluffychat/app.flathub]: https://flathub.org/apps/details/im.fluffychat.Fluffychat
[fluffychat/app.ios]: https://apps.apple.com/app/fluffychat/id1551469600

[element/site]: https://element.io
[element/site.dl]: https://element.io/download
[element/app.web]: https://app.element.io
[element/app.f-droid]: https://f-droid.org/packages/im.vector.app
[element/app.ios]: https://apps.apple.com/app/vector/id1083446067
[element/app.flathub]: https://flathub.org/apps/details/im.riot.Riot
[element/app.alpine]: https://pkgs.alpinelinux.org/packages?name=element-desktop "apk add -- element-desktop"

[element/app.macdmg]: https://packages.riot.im/desktop/install/macos/Element.dmg

[app.desktop/win64.exe]: https://packages.riot.im/desktop/install/win32/x64/Element%20Setup.exe
[app.desktop/win32.exe]: https://packages.riot.im/desktop/install/win32/ia32/Element%20Setup.exe


| name | web | app | desc |
| :--: | --: | :-- | :--- |
| [FluffyChat](../fluffychat.im-note) | [📜 site][fluffychat/site] | [🪁 web][fluffychat/app.web], [🥫 f-droid][fluffychat/app.f-droid], [🍰 flathub][fluffychat/app.flathub], [🧇 ios][fluffychat/app.ios] | 这个应用图标很可爱，应该是具备所有的 Matrix 基本功能 (包括视频通话等) 。 |
| [Element](../element.im-note) | [📜 site][element/site], [🎃 DL][element/site.dl] | [🪁 web][element/app.web], [🥫 f-droid][element/app.f-droid], [🧊 alpine][element/app.alpine] [🍰 flathub][element/app.flathub], [🧇 ios][element/app.ios], [🍕 Mac.dmg][element/app.macdmg] | 功能很全。现在它在 F-Droid 有了一个 [NonFreeNet](https://f-droid.org//docs/Anti-Features/#NonFreeNet) 的负特征标记，可能是由于它支持了为账号绑定电话。 |

注册后，你会得到一个唯一标识，格式大概是 `你的名字:你所在的服务器` 这样。

[matrix.to]: https://matrix.to

你可以把你的唯一标识在 [matrix.to] 输入，然后分享给别人。
这功能类似于 *MailTo* ，用于直接打开相应客户端并且添加联系人。

构建应用的 SDKs ：

[sdk/web.js/src.gh]: https://github.com/matrix-org/matrix-js-sdk.git
[sdk/web.react/src.gh]: https://github.com/matrix-org/matrix-react-sdk.git

- Web: [js][sdk/web.js/src.gh], [react][sdk/web.react/src.gh]

[sdk/android/src.gh]: https://github.com/matrix-org/matrix-android-sdk2.git
[sdk/ios/src.gh]: https://github.com/matrix-org/matrix-ios-sdk.git

- MobileApp: [android][sdk/android/src.gh], [ios][sdk/ios/src.gh]


