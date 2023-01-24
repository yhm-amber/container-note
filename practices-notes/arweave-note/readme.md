
[tech]: https://arweave.org/technology
[site]: https://arweave.org
[repo]: https://github.com/ArweaveTeam/arweave.git
[docs]: https://docs.arweave.org



Application: 

[docs.mining]: https://docs.arweave.org/info/mining
[tool.firefox]: https://addons.mozilla.org/firefox/addon/arweave

[js-client-repo]: https://github.com/ArweaveTeam/arweave-js.git
[smart-repo]: https://github.com/ArweaveTeam/SmartWeave.git
[weavemail-repo]: https://github.com/ArweaveTeam/weavemail.git

[arwiki-beta-repo]: https://github.com/luckyr13/arwiki.git
[arwiki-beta]: https://arwiki.wiki

[community-perma]: https://community.xyz

[ardrive]: https://ardrive.io
[ardrive-app]: https://app.ardrive.io
[ardrive-intro]: https://ardrive.io/what-is-ardrive

[verto]: https://verto.exchange/app
[verto-repo-alpha]: https://github.com/useverto/verto.git
[verto-repo]: https://github.com/useverto/interface.git


| item | links |
| -- | -- |
| Arweave | [site], [tech], [repo], [docs], [mine][docs.mining], [archiver][tool.firefox], ... |
| weve.mail | .. |
| Arwiki | .. |
| Ardrive | .. |




Account: 

[app]: https://arweave.app
[app.chrome]: https://chrome.google.com/webstore/detail/arweaveapp/hloekinecmafifaghekdjepphlabepkl
[app.firefox]: https://addons.mozilla.org/firefox/addon/arweave-app
[app.repo]: https://github.com/jfbeats/ArweaveWebWallet.git

[arconnect]: https://arconnect.io
[arconnect.chrome]: https://chrome.google.com/webstore/detail/arconnect/einnioafmpimabjcddiinlhmijaionap
[arconnect.firefox]:https://addons.mozilla.org/firefox/addon/arconnect

[arconnector]: https://jfbeats.github.io/ArweaveWalletConnector
[arconnector.repo]: https://github.com/jfbeats/ArweaveWalletConnector.git

| item | links |
| -- | -- |
| WalletApp | [app], [repo][app.repo], [addon (chrome)][app.chrome], [addon (firefox)][app.firefox], ... |
| ArConnector | [api][arconnector], [repo][arconnector.repo], ... |
| ArConnect | [site][arconnect], [addon (chrome)][arconnect.chrome], [addon (firefox)][arconnect.firefox], ... |








----------

像这种竭尽全力去去中心化 (因而联邦式并不能够满足之) 的
软件，必然是不会跟某个或者某群机器产生绑定的。

在 [`ArweaveTeam/arweave.git`][repo] 中会给你一个
 [告诉你怎么挖矿的链接][docs-mining] 。
从 [技术设计页][tech] 可知，这款 *区块纺* 的挖矿，
其实就是提供你的存储资源。提供资源，获得代币，然后消耗
代币才能作为用户去使用存储资源。也就是说，挖矿的程序的
部署，实际上就是对一个会去使用存储资源的程序的部署。

那么，挖矿的程序同时也就是存储的引擎了，即软件的实体。
我是这么理解的。

那么，假设代币的设计足够公平 (意思是对此我尚未
细致研究因而无法定论而不是说它可能不公平) ，一个贡献
存储设备的程度和对存储资源使用的程度一致的用户，他的
体验应该是类似于使用自己的硬盘而已 —— 只是，数据要
走网络，而他的数据也是存在于网络上的，当然，他应该也
不可以随意拿掉自己的硬件停止服务才对，否则整个网络就
存在那种没人提供硬件而大家又都有代币因而有权使用资源
的情况 …… Arweave 的设计中应该存在那种妥当的
「使权利义务对等」的机制才对，这个我回头细致研究。
