
[weavemail.app]: https://weavemail.app
[faucet.arweave.net]: https://faucet.arweave.net
[ArweaveTeam/weavemail.git]: https://github.com/ArweaveTeam/weavemail.git
[ArweaveTeam/arweave-deploy.git]: https://github.com/ArweaveTeam/arweave-deploy.git

<!-- "..." | lines | each {$in | parse "{n}:{x}"} | flatten | each {$'- ($in.n)'} | str join "\n" -->

- site: [weavemail.app]
- account: [faucet.arweave.net]
- github: [ArweaveTeam/weavemail.git]
- deploy by: [ArweaveTeam/arweave-deploy.git]

身份认证 (token) 是一个 Json 文件，用于 [app][weavemail.app] 页的登录。

[文档]: https://docs.arweave.org/info/tools/weavemail

注册需要一个验证你是真人的步骤，其 [文档] 中记录了曾经的
真人验证方案：登录一下你的 [Google] 或 [Github] 账号，不过目前
的验证流程是要求你发布一条特定的 [Twitter] 然后它会去搜到它从而
验证你不是机器人。

[Twitter]: https://twitter.com
[Google]: https://google.com
[Github]: https://github.com

*(但我发的那条貌似被 [Twitter] 当作是机器人然后吃掉了 ...)*

没验证似乎也可以用，或者用 arweave wallet 账户也可以直接登入。
进去看了看，邮件地址并非设想中的很 cooooool 的 `@weve.mail` 的
结尾，而只是你的 arweave 钱包地址而已。

连注册验证都做不了。弃用。
