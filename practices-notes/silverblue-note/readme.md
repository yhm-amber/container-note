

一个不可变操作系统，
类似于 [Vanilla](../vanilla-note) 。

是 Fedora 项目的子项目，
以前称为 Atomic Workstation 。

links: 

[mgz-what]: https://fedoramagazine.org/what-is-silverblue
[ostree]: https://ostreedev.github.io/ostree
[site]: https://silverblue.fedoraproject.org
[docs]: https://docs.fedoraproject.org/en-US/fedora-silverblue

- [What is Silverblue | FedoraMagazine][mgz-what]
- [libostree | ostreedev/ostree][ostree]
- [Team Silverblue][site]
- [Docs | Team Silverblue][docs]

[docs-start]: https://docs.fedoraproject.org/en-US/fedora-silverblue/getting-started
[tbox]: https://containertoolbx.org
[tbox-repo]: https://github.com/containers/toolbox.git

从 [快速开始][docs-start] 来看，
它的图形界面应用安装和命令行应用安装，
分别属于 Flatpak 和 [Toolbox][tbox] 两个体系
 (然而这两个体系又都是在 OCI 标准之上建立的) 
，所以，至少我觉得这还蛮分裂和臃肿。

(因为 Toolbox 也支持图形化嘛！)

观望一下，看之后会怎么改吧。

(很可能是用户接口不变而让 Flatpak 依赖 Toolbox 运行。) 🤔

