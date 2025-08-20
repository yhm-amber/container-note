[src/gh]: https://github.com/evcxr/evcxr.git "(MIT, Apache-2.0) (Languages: Rust 94.7%, Jupyter Notebook 4.0%, Other 1.3%) An evaluation context for Rust. // 一个用于 Rust 的评估上下文。"

[evcxr_jupyter.pkg.cargo/crates]: https://crates.io/crates/evcxr_jupyter "(: :get bin: cargo install --locked -- evcxr_jupyter) (: :register kernel: JUPYTER_PATH=$VIRTUAL_ENV/share/jupyter/ evcxr_jupyter --install) (: :revoke registration: evcxr_jupyter --uninstall) (: :remove bin: cargo uninstall -- evcxr_jupyter)"
[evcxr_repl.pkg.cargo/crates]: https://crates.io/crates/evcxr_repl "(: :prepare src: rustup component add -- rust-src) (: :get bin: cargo install --locked -- evcxr_repl)"
[evcxr.pkg.cargo/crates]: https://crates.io/crates/evcxr "(: cargo install -- evcxr)"
[evcxr_runtime.pkg.cargo/crates]: https://crates.io/crates/evcxr_runtime "(: cargo add -- evcxr_runtime) Provides functionality that may be of use by code running inside Evcxr. In particular inside the Evcxr Jupyter kernel. // 提供了一些可能在 Evcxr 内运行的代码中使用的功能。特别是 Evcxr Jupyter 内核中。 /// At the moment, all that's provided is functions and traits for emitting mime-typed data to Evcxr. // 目前提供的内容仅是用于向 Evcxr 发送 MIME 类型数据的函数和特征。"
