
[src/gh]: https://github.com/jdx/mise.git "(MIT) (Languages: YAML 56.7%, Rust 35.0%, Shell 5.3%, TypeScript 2.2%, Lua 0.5%, PowerShell 0.2%, Other 0.1%) dev tools, env vars, task runner // 开发工具、环境变量、任务运行器 /// What is it?  它是什么？ /// - Like asdf (or nvm or pyenv but for any language) it manages dev tools like node, python, cmake, terraform, and hundreds more. // 就像 asdf（或者 nvm 或 pyenv 但适用于任何语言）一样，它管理开发工具，如 node、python、cmake、terraform 等数百种工具。 /// - Like direnv it manages environment variables for different project directories. // 就像 direnv 一样，它管理不同项目目录的环境变量。 /// - Like make it manages tasks used to build and test projects. // 像 make 一样管理用于构建和测试项目的任务。"
[site]: https://mise.jdx.dev/ "mise-en-place /// The front-end to your dev env // 你的开发环境前端 /// Pronounced \"MEEZ ahn plahs\" // 发音为“米斯安普拉”"

[usage-lang:erlang/.site]: https://mise.jdx.dev/lang/erlang.html "(: mise ls-remote -- erlang # See available versions) (: mise use -g -- erlang@27) (: mise use -g -- erlang elixir)"
[usage-lang:elixir/.site]: https://mise.jdx.dev/lang/elixir.html "(: mise ls-remote -- elixir # See available versions) (: mise use -g -- erlang elixir)"
[usage-lang:python/.site]: https://mise.jdx.dev/lang/python.html "(: mise ls-remote -- python # See available versions) (: mise use -g -- uv@latest) (: mise use -g -- python@3.14 python@anaconda)"

[pkg.cargo/crates]: https://crates.io/crates/mise "(MIT) (815 KiB) (: cargo install -- mise) (: cargo install -- cargo-binstall ;: cargo binstall -- mise)"
[pkg.x/x-cmd]: https://x-cmd.com/install/mise "(: x install -- mise)"
[pkg.dnf/copr]: https://copr.fedorainfracloud.org/coprs/jdxcode/mise/ "(: dnf copr enable -- jdxcode/mise) (: dnf install -- mise)"
[pkg.brew/homebrew]: https://formulae.brew.sh/formula/mise "(: brew install -- mise)"
[pkg.winget/winstall]: https://winstall.app/apps/jdx.mise "(: winget install -- jdx.mise)"

[rtx.src/gh]: https://github.com/astrazor/rtx.git "(MIT) (forked from: gh:jdx/mise) (Languages: Rust 61.9%, Shell 37.0%, Just 0.4%, Nix 0.3%, Dockerfile 0.2%, Ruby 0.2%) Runtime Executor (asdf rust clone) // 运行时执行器 (asdf rust 克隆) /// Features // 特性 /// - asdf-compatible - rtx is compatible with asdf plugins and .tool-versions files. It can be used as a drop-in replacement. // asdf 兼容 - rtx 与 asdf 插件和 .tool-versions 文件兼容。它可以用作即插即用的替代品。 /// - Polyglot - compatible with any language, so no more figuring out how nvm, nodenv, pyenv, etc work individually—just use 1 tool. // 多语言 - 兼容任何语言，因此无需单独弄清楚 nvm、nodenv、pyenv 等如何工作——只需使用一个工具。 /// - Fast - rtx is written in Rust and is very fast. 20x-200x faster than asdf. // 快速 - rtx 是用 Rust 编写的，速度非常快。比 asdf 快 20-200 倍。 /// - No shims - shims cause problems, they break which, and add overhead. By default, rtx does not use them—however you can if you want to. // 没有 shims - shims 会导致问题，它们会破坏 which ，并增加额外开销。默认情况下，rtx 不使用它们——但是如果你需要，也可以使用。 /// - Fuzzy matching and aliases - It's enough to just say you want \"v18\" of node, or the \"lts\" version. rtx will figure out the right version without you needing to specify an exact version. // 模糊匹配和别名 - 只需说你想使用 \"v18\" 的节点，或 \"lts\" 版本。rtx 会自动确定正确的版本，而无需你指定确切版本。 /// - Arbitrary env vars - Set custom env vars when in a project directory like NODE_ENV=production or AWS_PROFILE=staging. // 任意环境变量 - 在项目目录（如 NODE_ENV=production 或 AWS_PROFILE=staging ）中设置自定义环境变量。"
[rtx.pkg.cargo/crates]: https://crates.io/crates/rtx-cli "(: cargo install -- rtx-cli)"
[rtx.pkg.brew/libraries]: https://libraries.io/homebrew/rtx "(: brew install -- rtx) (: brew install -- jdxcode/tap/rtx # updated immediately after a release)"
[rtx.pkg.brew/macappstore]: https://macappstore.org/rtx/ "(: brew install --cask -- rtx)"
[rtx.guide/blog-jdxcode/dev.to]: https://dev.to/jdxcode/beginners-guide-to-rtx-ac4 "NOTE: rtx has been renamed to mise. This post is still relevant but anytime you see \"rtx\" just replace it with \"mise\" // 注意：rtx 已更名为 mise。本文仍然相关，但如果你看到 \"rtx\"，只需将其替换为 \"mise\""

