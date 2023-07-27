
[src/gh]: https://github.com/getumbrel/umbrel.git "(PolyForm Noncommercial License 1.0.0) (Languages: Vue 60.2%, JavaScript 19.0%, Shell 12.0%, SCSS 4.9%, HTML 2.4%, Python 1.1%, Other 0.4%) A beautiful personal/home server OS for self-hosting with an app store. Buy a pre-built Umbrel Home with umbrelOS, or install on a Raspberry Pi 4, any Ubuntu/Debian system, or a VPS. // 一个漂亮的个人/家庭服务器操作系统，用于通过应用程序商店进行自托管。购买带有 umbrelOS 的预构建 Umbrel Home，或安装在 Raspberry Pi 4、任何 Ubuntu/Debian 系统或 VPS 上。"

> A beautiful personal/home server OS for self-hosting with an app store. Install on a Raspberry Pi 4, any Ubuntu/Debian system, or a VPS.
> 

[pic-why-personal-server-site]: https://uploads-ssl.webflow.com/62966b49981ba146f4842f45/62966b49981ba161eb842fc9_why-personal-server-p-1080.png
[pic-why-personal-server]: ./62966b49981ba161eb842fc9_why-personal-server-p-1080.png

> ![without or with][pic-why-personal-server]

[site]: https://umbrel.com

- repo: [`getumbrel/umbrel`][src/gh]
- site: [`umbrel.com`][site]

[repo-app]: https://github.com/getumbrel/umbrel-apps.git
[buildx-repo]: https://github.com/docker/buildx.git

根据 [`getumbrel/umbrel-apps`][repo-app] 可知，在该平台 (OS) 上的打包是 OCI 格式的。

其 [示例][pkg-buildx] 使用了 [`docker buildx`][buildx-repo] 工具：

~~~ sh
docker buildx build --platform linux/arm64,linux/amd64 --tag getumbrel/btc-rpc-explorer:v2.0.2 --output "type=registry" -- .
~~~

[pkg-buildx]: https://github.com/getumbrel/umbrel-apps.git#1-containerizing-the-app-using-docker

----

- knows by: [FuzzrNet/Forage][forage-repo]

[forage-repo]: https://github.com/FuzzrNet/Forage.git
