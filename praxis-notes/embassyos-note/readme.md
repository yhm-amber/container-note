



----

[src.old/gh]: https://github.com/Start9Labs/embassy-os.git

[docs]: https://docs.start9.com/latest
[docs.src/gh]: https://github.com/Start9Labs/documentation.git "(Languages: Python 54.2%, Makefile 22.8%, Shell 14.7%, HTML 5.0%, JavaScript 3.3%) User manual, developer documentation, and support for StartOS // StartOS 用户手册、开发人员文档和支持"
[site]: https://start9.com
[release/gh]: https://github.com/Start9Labs/embassy-os/releases

[src/gh]: https://github.com/Start9Labs/start-os.git "(START9 NON-COMMERCIAL LICENSE v1) (Languages: Rust 52.9%, TypeScript 33.5%, HTML 8.0%, SCSS 1.9%, JavaScript 1.9%, Shell 1.3%, Other 0.5%) Browser-based, graphical operating system for a personal server. // 用于个人服务器的基于浏览器的图形操作系统。"


[blog]: https://blog.start9.com
[t.me]: https://t.me/start9_labs
[matrix]: https://matrix.to/#/#community:matrix.start9labs.com
[twitter]: https://twitter.com/start9labs
[mastodon]: http://mastodon.start9labs.com/
[matrix-dev]: https://matrix.to/#/#community-dev:matrix.start9labs.com

[🐌 src][src/gh] | [🪀 docs][docs] [`🐣`][docs.src/gh] | [👽 site][site] | [🦎 blog][blog]  
[🦥 t.me][t.me] | [🦑 matrix][matrix] | [🪁 twitter][twitter] | [🦪 mastodon][mastodon] | [🐙 matrix dev][matrix-dev]


> Browser-based, graphical operating system for a personal server.
> 

是一个分发平台、个人 (家庭) 服务器 OS 。

> 您可以在闭源、中介、托管、 **昂贵** 的云计算模型中做的任何事情，您也可以在开源、自托管、私有和 **年费** 的主权计算模型中做。
> 

其网站 ([`start9.com`][site]) 通过对比 *Cloud computing* 与 *Sovereign computing* 介绍其自身：

- **Cloud** computing **云**计算
  
  > The "cloud" is just someone else's computer. Your cell phone and laptop are just remote controls. You are not in control.
  > 
  > “云”只是别人的电脑。您的手机和笔记本电脑只是遥控器。你无法控制。
  > 
  > In the cloud computing paradigm, there is no privacy, censorship is commonplace, hacks are inevitable, and costs will forever rise.
  > 
  > 在云计算范式中，没有隐私，审查司空见惯，黑客攻击不可避免，成本将永远上升。
  > 
  > ![pyramid down][pic-pyramid-down]
  > 
  
- **Sovereign** computing **主权**计算
  
  > When you run a private server, you are in control. You don't rely on others to process or store your data.
  > 
  > 当您运行私人服务器时，一切尽在您的掌控之中。您不依赖他人来处理或存储您的数据。
  > 
  > In the sovereign computing paradigm, concerns over privacy, censorship, hacks, and fees practically disappear.
  > 
  > 在主权计算范式中，对隐私、审查、黑客攻击和费用的担忧几乎消失了。
  > 
  > ![pyramid up][pic-pyramid-up]
  > 
  

[pic-pyramid-down-site]: https://start9.com/assets/pyramid-down.b1f56941.png
[pic-pyramid-up-site]: https://start9.com/assets/pyramid-up.1afc7d08.png

[pic-pyramid-down]: ./.assets/pyramid-down.b1f56941.png
[pic-pyramid-up]: ./.assets/pyramid-up.1afc7d08.png



从其[分发页面][release/gh]来看，它有 `iso` 格式的用于 `amd64` 指令集芯片的 OS 安装包，也有 `deb` 格式的用于在 Debian 上作为应用程序部署。

其应用的打包与 [Umbrel](../umbrel-note) 一样，也是 OCI 格式的，且 [示例][docs-pkg-buildx] 同样使用了 [`docker buildx`][buildx-repo] 作为打包工具：

~~~ sh
docker buildx build --tag start9/$(PKG_ID)/main:$(PKG_VERSION) --platform=linux/arm64 -o type=docker,dest=image.tar -- .
~~~

[docs-pkg-buildx]: https://docs.start9.com/latest/developer-docs/packaging#build-a-dockerfile
[buildx-repo]: https://github.com/docker/buildx.git

----

- knows by: [FuzzrNet/Forage][forage-repo]

[forage-repo]: https://github.com/FuzzrNet/Forage.git
