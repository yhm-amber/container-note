
> Making Rust the next language of cloud-native
> 

ref: https://github.com/shuttle-hq  

[site]: https://shuttle.rs

> Shuttle is a Rust-native cloud development platform that lets you deploy your app while also taking care of all of your infrastructure.
> 
> Shuttle 是一个 Rust 原生的云开发平台，让你在部署应用的同时也能照顾到你所有的基础设施。
> 

[docs-what-is]: https://docs.shuttle.rs/introduction/what-is-shuttle

--- [What is Shuttle? | docs.shuttle.rs][docs-what-is]

> Shuttle is built for Rust.
> 
> Shuttle 是为 Rust 而建的。
> 
> A simple cargo command packages up your application, ships it to the shuttle build cluster where it's incrementally compiled and automatically served on a unique subdomain.
> 
> 一个简单的 cargo 命令将你的应用程序打包，运送到 shuttle build 集群，在那里它被增量编译并自动服务于一个独特的子域。
> 
> Shuttle uses simple but powerful annotations to understand your dependencies. Infrastructure dependencies like databases or key-value stores are spun up for you and everything is automatically wired together from the get-go.
> 
> Shuttle 使用简单而强大的注释来理解你的依赖关系。像数据库或键值存储这样的基础设施依赖性是为你准备的，所有东西从一开始就被自动连接在一起。
> 
> It feels a little magical.
> 
> 蛮奇妙的。
> 

--- [shuttle.rs][site]

[docs]: https://docs.shuttle.rs
[repo]: https://github.com/shuttle-hq/shuttle.git
[rodemap-gh]: https://github.com/orgs/shuttle-hq/projects/4

[repo-eg]: https://github.com/shuttle-hq/examples.git

ref: [`shuttle-hq/shuttle`][repo]

~~~ sh
: Run the following command to install shuttle: 
cargo install -- cargo-shuttle

: And then login: 
cargo shuttle login

: To initialize your project, simply write: 
cargo shuttle init --axum hello-world

: And to deploy it, write: 
cargo shuttle project new
cargo shuttle project status ## until the project is "ready"
cargo shuttle deploy

: And that's... it.
cargo shuttle deploy
~~~

[docs-rs-shuttle-service]: https://docs.rs/shuttle-service/latest/shuttle_service




