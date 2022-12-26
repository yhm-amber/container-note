

[repo]: https://github.com/Start9Labs/embassy-os.git
[docs]: https://docs.start9.com/latest
[docs-repo]: https://github.com/Start9Labs/documentation.git
[site]: https://start9.com
[release]: https://github.com/Start9Labs/embassy-os/releases

- repo: [`gh Start9Labs/embassy-os`][repo]
- docs: [`docs.start9`][docs] [`repo`][docs-repo]

> Browser-based, graphical operating system for a personal server.
> 

是一个分发平台、个人 (家庭) 服务器 OS 。

> 您可以在闭源、中介、托管、 **昂贵** 的云计算模型中做的任何事情，您也可以在开源、自托管、私有和 **年费** 的主权计算模型中做。
> 

其网站 ([`start9.com`][site]) 通过对比 *Cloud computing* 与 *Sovereign computing* 介绍其自身。

从其[分发页面][release]来看，它有 `iso` 格式的用于 `amd64` 指令集芯片的 OS 安装包，也有 `deb` 格式的用于在 Debian 上作为应用程序部署。

其应用的打包与 [Umbrel](../umbrel-note) 一样，也是 OCI 格式的，并且[示例][docs-pkg-buildx]同样使用了 [`docker buildx`][buildx-repo] 作为打包工具：

~~~ sh
docker buildx build --tag start9/$(PKG_ID)/main:$(PKG_VERSION) --platform=linux/arm64 -o type=docker,dest=image.tar -- .
~~~

[docs-pkg-buildx]: https://docs.start9.com/latest/developer-docs/packaging#build-a-dockerfile
[buildx-repo]: https://github.com/docker/buildx.git

----

- knows by: [FuzzrNet/Forage][forage-repo]

[forage-repo]: https://github.com/FuzzrNet/Forage.git
