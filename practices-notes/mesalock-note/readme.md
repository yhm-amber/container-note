
[repo]: https://github.com/mesalock-linux/mesalock-distro.git
[docker]: https://hub.docker.com/r/mesalocklinux/mesalock-linux/

> MesaLock Linux: a memory-safe Linux distribution.


> MesaLock Linux is a general purpose Linux distribution which aims to provide a
>  *safe* and *secure* user space environment. To eliminate high-severe
>  vulnerabilities caused by memory corruption, the whole user space applications
>  are rewritten in *memory-safe* programming languages like Rust and Go. This
>  extremely reduces attack surfaces of an operating system exposed in the wild,
>  leaving the remaining attack surfaces auditable and restricted. Therefore,
>  MesaLock Linux can substantially improve the security of the Linux ecosystem.
>  Additionally, thanks to the Linux kernel, MesaLock Linux supports a broad
>  hardware environment, making it deployable in many places. Two main usage
>  scenarios of MesaLock Linux are for containers and security-sensitive embedded
>  devices. With the growth of the ecosystem, MesaLock Linux would also be adopted
>  in the server environment in the future.
> 
> MesaLock Linux 是一个通用的 Linux 发行版，
> 旨在提供一个 *安全* *可靠* 的用户空间环境。
> 为消除高重 内存损坏引起的漏洞，整个用户空间
> 应用程序用 Rust 和 Go 等 *内存安全* 编程
> 语言重写。这极大减少了暴露在野外的操作系统
> 的攻击面，让剩余的攻击面可审计和受限。
> 所以， MesaLock Linux 可以大幅提升 Linux 生态
> 系统的安全性。此外，得益于 Linux 内核，
>  MesaLock Linux 支持广泛的硬件环境，使其可部署
> 在许多地方。两个主要的使用 MesaLock Linux 的
> 场景是针对容器和安全敏感的嵌入式设备。随着
> 生态系统的壮大，未来 MesaLock Linux 也将
> 被用于服务器环境。
> 
> To get better functionality along with strong security guarantees, MesaLock
>  Linux follows the following rules-of-thumb for hybrid memory-safe architecture
>  design proposed by the [Rust SGX SDK][rust-sgx-sdk-repo] project.
> 
> 为了获得更好的功能以及强大的安全保证，
>  MesaLock Linux 遵循以下由 [Rust SGX SDK][rust-sgx-sdk-repo] 项目
> 提出设计的混合内存安全架构的经验法则：
> 
> 1. Unsafe components must not taint safe components,
>     especially for public APIs and data structures.
>    
>    不安全组件不得污染安全组件，尤其是对于公共 API 和数据结构。
>    
> 2. Unsafe components should be as small as possible
>     and decoupled from safe components.
>    
>    不安全的组件应该尽可能小，并与安全组件解耦。
>    
> 3. Unsafe components should be explicitly marked
>     during deployment and ready to upgrade.
>    
>    不安全的组件应在部署期间明确标记并准备好升级。
>    
> 

[rust-sgx-sdk-repo]: https://github.com/baidu/rust-sgx-sdk.git
