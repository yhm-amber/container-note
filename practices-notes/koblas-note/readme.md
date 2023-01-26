
[repo]: https://github.com/ynuwenhof/koblas.git

[ynuwenhof/koblas | GitHub][repo] : 

> A lightweight [SOCKS5](https://datatracker.ietf.org/doc/html/rfc1928) proxy server, written in [Rust](https://rust-lang.org).
> 
> * Multi-User
> * Configurable
> * No Authentication
> * [Username/Password](https://datatracker.ietf.org/doc/html/rfc1929) Authentication
> 

in: 

~~~ sh
: cargo
cargo install koblas

: container
docker pull -- ynuwenhof/koblas
~~~

use: 

~~~ sh
: Hash passwords

: cli
koblas hash "你的密码"

: container
docker run --rm -- ynuwenhof/koblas hash "你的密码"

: this will return an Argon2id password hash.
: see: https://en.wikipedia.org/wiki/Argon2


: Run Server

: cli
koblas -a 0.0.0.0 --auth -u /path/to/users.toml

: container
docker run -d -p 1080:1080 \
  -v /path/to/users.toml:/etc/koblas/users.toml \
  -e RUST_LOG=debug \
  -e KOBLAS_AUTHENTICATE=true \
  -e KOBLAS_ANONYMIZE=false \
  --name koblas -- ynuwenhof/koblas

: this will bind the server to
: 0.0.0.0:1080
~~~
