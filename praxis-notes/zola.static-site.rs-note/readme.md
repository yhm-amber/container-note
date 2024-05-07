
> A fast static site generator in a single binary with everything built-in.
> 
> 一个很快的静态站点生成器，它的一切内置于一个二进制文件。
> 

[site]: https://getzola.org
[docs]: https://getzola.org/documentation
[src/gh]: https://github.com/getzola/zola.git "(MIT) (Languages: Rust 97.4%, HTML 1.8%, Python 0.7%, Dockerfile 0.1%, SCSS 0.0%, CSS 0.0%) A fast static site generator in a single binary with everything built-in."
[oci/ghcr]: https://github.com/getzola/zola/pkgs/container/zola "(: pull ghcr.io/getzola/zola:latest)"

- [Zola][site]
- [Documentation Overview | Zola][docs]
- [getzola/zola | GitHub][src/gh]
- [getzola/zola | ghcr.io][oci/ghcr]


~~~ sh
: build
docker run \
  -u "$(id -u):$(id -g)" \
  -v $PWD:/app --workdir /app \
  -- ghcr.io/getzola/zola:v0.16.0 build

: serve
docker run \
  -u "$(id -u):$(id -g)" \
  -v $PWD:/app --workdir /app \
  -p 8080:8080 \
  -- \
  ghcr.io/getzola/zola:v0.16.0 serve \
    --interface 0.0.0.0 --port 8080 \
    --base-url localhost
~~~

or

~~~ sh
: flatpak
alias zola='flatpak run org.getzola.zola'

: alpine
apk add zola

: arch
pacman -S zola

: fedora
sudo dnf install zola
~~~
