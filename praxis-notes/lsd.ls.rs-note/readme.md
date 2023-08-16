[src/gh]: https://github.com/lsd-rs/lsd.git "(Apache-2.0) (Languages: Rust 99.0%, Shell 1.0%) The next gen ls command // 下一代 ls 命令"
[pkg/crates.io]: https://crates.io/crates/lsd ":: cargo install lsd"
[stat/repology]: https://repology.org/project/lsd/versions "lsd package versions - Repology"

[🦪 src][src/gh] | [🐚 crates][pkg/crates.io]

[![Packaging status](https://repology.org/badge/vertical-allrepos/lsd.svg?columns=4)][stat/repology]

| OS/Distro                       | Command                                                                                                                                          |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| Archlinux                       | `pacman -S lsd`                                                                                                                                  |
| Fedora                          | `dnf install lsd`                                                                                                                                |
| Gentoo                          | `sudo emerge sys-apps/lsd`                                                                                                                       |
| macOS                           | `brew install lsd` or `sudo port install lsd`                                                                                                    |
| NixOS                           | `nix-env -iA nixos.lsd`                                                                                                                          |
| FreeBSD                         | `pkg install lsd`                                                                                                                                |
| NetBSD or any `pkgsrc` platform | `pkgin install lsd` or `cd /usr/pkgsrc/sysutils/lsd && make install`                                                                             |
| Windows                         | `scoop install lsd`                                                                                                                              |
| Android (via Termux)            | `pkg install lsd`                                                                                                                                |
| Debian sid and bookworm         | `apt install lsd`                                                                                                                                |
| Ubuntu 23.04 (Lunar Lobster)    | `apt install lsd`                                                                                                                                |
| Earlier Ubuntu/Debian versions  | **snap discontinued**, use `sudo dpkg -i lsd_0.23.1_amd64.deb` and get `.deb` file from [release page](https://github.com/Peltoche/lsd/releases) |
| Solus                           | `eopkg it lsd`                                                                                                                                   |
| Void Linux                      | `sudo xbps-install lsd`                                                                                                                          |
| openSUSE                        | `sudo zypper install lsd`                                                                                                                        |

Also install the [Nerd Font](https://github.com/ryanoasis/nerd-fonts.git "(MIT, Apache-2.0, CC BY-SA 4.0, CC 4, SIL OFL 1.1, ...) (Languages: CSS 42.5%, Shell 38.1%, Python 15.7%, PowerShell 3.6%, Dockerfile 0.1%) Iconic font aggregator, collection, & patcher. 3,600+ icons, 50+ patched fonts: Hack, Source Code Pro, more. Glyph collections: Font Awesome, Material Design Icons, Octicons, & more // 标志性字体聚合器、集合和修补程序。 3,600 多个图标，50 多种修补字体：Hack、Source Code Pro 等等。字形集合：Font Awesome、Material Design Icons、Octicons 等") will be better.

From source: 

~~~ sh
: install :
cargo install lsd

: or install the latest master branch commit :
cargo install --git https://github.com/Peltoche/lsd.git --branch master
~~~
