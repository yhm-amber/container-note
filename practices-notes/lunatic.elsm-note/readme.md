[src/gh]: https://github.com/lunatic-solutions/lunatic "Lunatic is a universal runtime for fast, robust and scalable server-side applications. It's inspired by Erlang and can be used from any language that compiles to WebAssembly."
[rs.src/gh]: https://github.com/lunatic-solutions/lunatic-rs "This library contains higher level Rust wrappers for low level Lunatic syscalls. :: This library allows you to build Rust applications that run on top of Lunatic. :: old url: https://github.com/lunatic-solutions/rust-lib "
[ts.src/gh]: https://github.com/lunatic-solutions/as-lunatic "This library contains higher level AssemblyScript wrappers for low level Lunatic syscalls."

[crates]: https://crates.io/crates/lunatic "cargo install -- lunatic-runtime"
[rslib]: https://docs.rs/lunatic "use lunatic::... ;"
[npm]: https://www.npmjs.com/package/as-lunatic "npm install --save-dev assemblyscript -- as-lunatic"

[website]: https://lunatic.solutions "Lunatic is an Erlang-inspired runtime for WebAssembly -- By combining the fault-tolerance and massive concurrency of Erlang with the capability-based security of WebAssembly, it creates a powerful programming model."

[blog.writing-rust-the-elixir-way]: https://lunatic.solutions/blog/writing-rust-the-elixir-way
[blog.writing-rust-the-elixir-way-1.5-years-later]: https://lunatic.solutions/blog/writing-rust-the-elixir-way-1.5-years-later

[pic::logo.svg.src]: https://raw.githubusercontent.com/lunatic-solutions/lunatic/main/assets/logo.svg
[pic::logo.svg]: ./.assets/logo.svg

<img height=128 width=128 
src=./.assets/logo.svg />

[📔 docs][rslib] | [🦪 src][src/gh] | [📜 website][website] | [🧊 crates][crates] [`🍥 src`][rs.src/gh] | [🥫 npm][npm] [`🍥 src`][ts.src/gh]

Blogs: 

- [Writing Rust the Elixir way | Lunatic][blog.writing-rust-the-elixir-way]
- [Writing Rust the Elixir way - 18 months later | Lunatic][blog.writing-rust-the-elixir-way-1.5-years-later]


## Install

~~~ sh
: install : cargo
cargo install lunatic-runtime

: install : homebrew
brew tap lunatic-solutions/lunatic
brew install lunatic

: install : src
git clone https://github.com/lunatic-solutions/lunatic.git &&
cd lunatic && cargo install --path .

: install : releases
: curl https://github.com/lunatic-solutions/lunatic/releases ...

: ::: :
: After installation, you can use the `lunatic` binary to run WASM modules.

lunatic --help
lunatic some.wasm
~~~

## Build

需构建为 WASM 。如：

~~~ sh
: need
rustup target add wasm32-wasi

: build
cargo build --release --target=wasm32-wasi

: run e.g.
lunatic target/wasm32-wasi/release/<name>.wasm
~~~

更便捷的做法是在你项目的 `.cargo/config.toml` 中增加以下：

~~~ toml
[build]
target = "wasm32-wasi"

[target.wasm32-wasi]
runner = "lunatic"
~~~

然后你再执行比如 `cargo run` `cargo test` 的话， cargo 就会
用目标为 `wasm32-wasi` 的方式构建、并以 `lunatic` 作为其构建结果的执行器。

## Library

