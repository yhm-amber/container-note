
> A fast static site generator in a single binary with everything built-in.
> 
> 一个很快的静态站点生成器，它的一切内置于一个二进制文件。
> 

[site]: https://getzola.org
[docs]: https://getzola.org/documentation
[repo]: https://github.com/getzola/zola.git
[ghcr]: https://github.com/getzola/zola/pkgs/container/zola

- [Zola][site]
- [Documentation Overview | Zola][docs]
- [getzola/zola | GitHub][repo]
- [getzola/zola | ghcr.io][ghcr]


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
