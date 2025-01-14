[src/gh]: https://github.com/ynqa/jnv.git "(MIT) (Languages: Rust 97.9%, Dockerfile 2.1%) Interactive JSON filter using jq // 使用 jq 的交互式 JSON 过滤器 /// Interactive JSON viewer and jq filter editor // 交互式 JSON 查看器和 jq 过滤器编辑器 /// - Syntax highlighting for JSON // JSON 的语法突出显示 /// - Use jaq to apply jq filter // 使用 jaq 应用 jq 过滤器 /// -- This eliminates the need for users to prepare jq on their own. // 这样用户就无需自己准备 jq 。 /// Important // 重要的 /// Starting from v0.3.0, the transition from libjq Rust binding j9 to jq clone jaq was made. // 从 v0.3.0 开始，从 libjq Rust 绑定 j9 过渡到 jq 克隆 jaq 。 /// This change eliminated the need to manage C-related dependencies that include external tools like autoconf, thus simplifying the build process. However, please note that some filters are not yet supported by jaq. For more details, refer to GitHub issue #24. // 此更改消除了管理与 C 相关的依赖项（包括 autoconf 等外部工具）的需要，从而简化了构建过程。但请注意， jaq 尚不支持某些过滤器。有关更多详细信息，请参阅 GitHub 问题 #24 。 /// Please continue to provide feedback regarding this transition. // 请继续提供有关此转换的反馈。"

[bin/brew]: https://formulae.brew.sh/formula/jnv "(: brew install -- jnv) (: brew install -- ynqa/tap/jnv)"
[bin/macports]: https://ports.macports.org/port/jnv/ "(: sudo -- port install -- jnv)"
[bin/nixos]: https://search.nixos.org/packages?query=jnv "(: nix-shell -p jnv)"
[bin/crates]: https://crates.io/crates/jnv "(: cargo install -- jnv)"

[knowsby]: https://rustcc.cn/article?id=2d10b6f8-fe51-4a4b-8733-b94131b40c08 "jnv - 超好用的 json 交互查阅工具 /// 已收获近5k星。"
