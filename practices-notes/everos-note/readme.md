
> Ever Operating System is an
>  intermediary between a user
>  and a blockchain — a distributed
>  verifiable computing engine.
> 
> Ever Operating System 是用户和
> 区块链之间的中介——一个分布式可验证计算引擎。
> 

—— [About Ever OS | Mitja's web page][paper-os]

> Build, deploy, decentralize
>  and scale with Ever OS
> 

links: 

- [Ever OS Developer Tools][site]
- [TON Labs][site-old]

[site]: https://everos.dev
[site-old]: https://tonlabs.io

[docs-start]: https://docs.everos.dev/everdev/guides/quick-start
[team-gh]: https://github.com/tonlabs


[paper-os]: https://mitja.gitbook.io/papers/v/everscale-white-paper/readme/chapter-three-ever-operating-system/about-ever-os

<details>

<summary>
OS 📜
</summary>

[About Ever OS | Mitja's web page][paper-os]

> Between a regular computer and a user
>  (which may be a developer who would
>  like to write programs for that
>  computer or a regular user who
>  would like to execute and interact
>  with these programs) there is something
>  called an operating system.
> 
> 在普通计算机和用户 (可能是想为该计算机编写程序
> 的开发人员或想执行这些程序并与之交互
> 的普通用户) 之间存在称为操作系统的东西。
> 
> That is how GNU defines an
>  operating system:
> 
> Linux is an operating system: a series
>  of programs that let you interact with
>  your computer and run other programs.
> 
> 这就是 GNU 定义操作系统的方式：
> 
> Linux 是一个操作系统：一系列可让您
> 与计算机交互并运行其他程序的程序。
> 
> An operating system consists of various
>  fundamental programs which are needed
>  by your computer so that it can
>  communicate and receive instructions
>  from users; read and write data
>  to hard disks, tapes, and printers;
>  control the use of memory;
>  and run other software.
> 
> 操作系统由您的计算机需要的
> 各种基本程序组成，以便
> 它可以与用户进行通信和接收指令；
> 读写数据到硬盘、磁带和打印机；
> 控制内存的使用；并运行其他软件。
> 
> It is quite obvious why computers
>  need an operating system.
>  Before operating systems existed,
>  interaction with computers looked
>  horribly unpleasant to the end user.
>  Something resembling today’s
>  interaction between a user
>  and a blockchain.
> 
> 很明显为什么计算机需要操作系统。
> 在操作系统出现之前，与计算机的交互对最终用户来说
> 看起来非常不愉快。类似于今天用户和区块链之间的交互。
> 
> Any way you look at it,
>  blockchain is quite a good candidate
>  to be called a decentralized computer.
>  At least some of the blockchains are.
>  Everscale most definitely is.
> 
> 无论你怎么看，区块链都非常适合称为去中心化计算机。
> 至少一些区块链是。 Everscale 绝对是。
> 
> And just as with any computer,
>  a blockchain needs an intermediate layer
>  (or layers) that manages its resources
>  and provides services to the programs
>  the user runs or interacts with.
>  Of course blockchain, in terms of
>  architecture, cannot perhaps be compared
>  directly 1:1 with a regular PC.
>  But in logical terms, whenever we
>  think about a software stack
>  needed to enable interaction
>  with a user — to call it an
>  operating system is quite compelling.
> 
> 就像任何计算机一样，区块链需要一个 (或多个) 中间层
> 来管理其资源并为用户运行或与之交互的程序提供服务。
> 当然，就架构而言，区块链或许不能
> 与普通 PC 直接 1:1 地比较。但从逻辑上讲，
> 每当我们考虑实现与用户交互所需的软件堆栈时
> ——将其称为操作系统是非常有说服力的。
> 
> Let's run some arguments.
>  For reasons of practicality we will not
>  talk only about the Everscale blockchain,
>  but most of the arguments could be applied
>  to some other modern blockchains as well.
> 
> 让我们进行一些论证。出于实用性的原因，
> 我们不会只谈论 Everscale 区块链，
> 但大多数论点也可以应用于其他一些现代区块链。
> 
> A classical operating system is
>  expected to provide:
>  Memory Management, Processor Managing,
>  Device Managing, File handling,
>  Security Handling and so on.
>  In this chapter we will discuss
>  how all that is implemented on the
>  blockchain for the first time.
> 
> 一个经典的操作系统应该提供：
> 内存管理、处理器管理、设备管理、
> 文件处理、安全处理等。
> 在本章中，我们将首次讨论
> 如何在区块链上实现所有这些。
> 

</details>

[paper-fs]: https://mitja.gitbook.io/papers/v/everscale-white-paper/readme/chapter-three-ever-operating-system/file-system

<details>

<summary>
FS 📜
</summary>

[File System | Mitja's web page][paper-fs] : 

> In Ever Kernel the address of
>  a smart contract is calculated by
>  hashing its code and initial data.
>  The full address, consisting of
>  a 32-bit WorkChain_id, and the
>  256-bit internal address or account
>  identifier account_id inside the
>  chosen WorkChain.
>  In operating system terms it provides
>  address space management functionality.
> 
> 在 Ever Kernel 中，智能合约的地址是通过
> 散列其代码和初始数据来计算的。完整地址，
> 由 32 位 WorkChain_id 和
> 所选 WorkChain 内的 256 位内部地址
> 或帐户标识符 account_id 组成。
> 在操作系统术语中，它提供地址空间管理功能。
> 
> In the context of the Ever Operating System
>  though, The Merkle tree of Ever Kernel 1.0 provides
>  just part of the necessary functionality
>  to build a fully distributed file system.
>  Therefore we are adding two additional
>  search trees in which nodes would
>  represent contract code hash and
>  contract data and leafs would be
>  contract addresses. We are optimising
>  for fast lookup for contracts with
>  similar data or code hash from within
>  the Node and adding subsequent
>  instructions to ESVM to allow this
>  lookup from within smart contracts.
>  Additionally, we add code versioning
>  within these trees thus allowing
>  following the evolution of a smart
>  contract code after setCode operations.
> 
> 不过，在 Ever Operating System 的背景下，
>  Ever Kernel 1.0 的 Merkle 树
> 仅提供了构建完全分布式文件系统所需功能的一部分。
> 因此，我们添加了两个额外的搜索树，其中节点
> 代表合约代码哈希和合约数据，叶子代表合约地址。
> 我们正在优化以从节点内快速查找具有相似数据
> 或代码哈希的合约，并将后续指令添加到 ESVM 以
> 允许从智能合约内进行此查找。此外，我们在这些树中
> 添加了代码版本控制，从而允许在 setCode 操作之后
> 跟踪智能合约代码的演变。
> 
> This functionality will be particularly
>  useful in the Distributed Programming
>  Paradigm (see below).
> 
> 此功能在分布式编程范例中特别有用 (见后文) 。
> 

</details>

[paper-ns]: https://mitja.gitbook.io/papers/v/everscale-white-paper/readme/chapter-three-ever-operating-system/file-names-and-directories

<details>

<summary>
NS 📜
</summary>

[File names and directories | Mitja's web page][paper-ns]

> The Ever OS user should be able
>  not only to call a program
>  by internal processor address,
>  but to use human readable names,
>  store data not only in the
>  contract internal memory
>  but have access to some peripheral
>  devices such as hard drives,
>  long term storage and so on that
>  would represent a natural functionality
>  of an operating system kernel.
> 
> Ever OS 用户不仅可以通过内部处理器地址调用程序，
> 还可以使用人类可读的名称，不仅可以将数据
> 存储在合约内部存储器中，还可以访问一些外围设备，
> 例如硬盘驱动器、长期存储、等等依此类推，
> 这将代表操作系统内核的自然功能。
> 
> File names and directories have been
>  implemented by a protocol we call
>  DeCert (Decentralized Certificates)
>  in general and in particular DeNS
>  (Decentralized Name Service).
> 
> 文件名和目录已通过我们通常称为 DeCert (分散证书)
>  的协议实现，特别是 DeNS（分散名称服务）。
> 
> The implementation of DeNS is an example
>  of the Distributed Programming Paradigm
>  of Everscale (see a special chapter
>  below for more information) which provides
>  an instant name resolution.
> 
> DeNS 的实现是 Everscale 分布式编程范例
> 的一个示例 (更多见后文专门章节) ，它提供了
> 即时名称解析。 
> 

</details>

[paper-tonix]: https://mitja.gitbook.io/papers/v/everscale-white-paper/readme/chapter-three-ever-operating-system/tonix

<details>

<summary>
Tonix 📜
</summary>

[Tonix | Mitja's web page][paper-tonix]

> Following the above a practical
>  simulation of a UNIX filesystem
>  has been implemented.
>  Tonix provides basic file system
>  functionality, as well as an interactive
>  shell with a Unix-style command line
>  interface.
>  The following categories of operations
>  are supported: query file system status,
>  manage user session, manipulate files,
>  change file attributes, process text,
>  access reference manuals etc.
> 
> 按照上面的内容，已经实现了 UNIX 文件系统的
> 实际模拟。 Tonix 提供基本的文件系统功能，
> 以及带有 Unix 风格命令行界面的交互式 shell 。
> 支持以下类别的操作：查询文件系统状态、管理用户会话、
> 操作文件、更改文件属性、处理文本、访问参考手册等。
> 

</details>




## Cloud

> Rich and high availability APIs
>  for TVM blockchains
> 

links: 

[site-cloud]: https://evercloud.dev
[docs-cloud]: https://docs.evercloud.dev/products/evercloud

- [Evercloud - Rich and high availability APIs for TVM blockchains][site-cloud]
- [Evercloud | Ever Platform][docs-cloud]





----------

old icons: 

[pic-t-online]: https://ton-labs.firebaseapp.com/assets/t.8028325a58689604.png
[pic-devon-online]: https://ton-labs.firebaseapp.com/assets/dev-on.508017636f4ec45a.png
[pic-n-online]: https://ton-labs.firebaseapp.com/assets/n.285aae4729b28752.png
[pic-surfon-online]: https://ton-labs.firebaseapp.com/assets/surf-on.0befdc441ffb6440.png
[pic-s-online]: https://ton-labs.firebaseapp.com/assets/s.cf69ba7a72663c90.png

> ![T][pic-t] ![dev On][pic-devon] ![N][pic-n]  
>  ![surf On][pic-surfon] ![S][pic-s]
> 

[pic-t]: ./.assets/t.8028325a58689604.png
[pic-devon]: ./.assets/dev-on.508017636f4ec45a.png
[pic-n]: ./.assets/n.285aae4729b28752.png
[pic-surfon]: ./.assets/surf-on.0befdc441ffb6440.png
[pic-s]: ./.assets/s.cf69ba7a72663c90.png




