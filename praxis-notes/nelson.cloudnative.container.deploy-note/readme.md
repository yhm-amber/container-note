[blog:nelson-integrates-kubernetes/timperrett]: https://timperrett.com/2017/12/07/nelson-integrates-kubernetes/ "Nelson integrates Kubernetes | This is my blog. // Nelson 集成 Kubernetes | 这是我的博客。"
[blog:nomad-with-envoy-and-consul/timperrett]: https://timperrett.com/2017/05/13/nomad-with-envoy-and-consul/ "Envoy with Nomad and Consul | This is my blog. // 特使与游牧者和领事 | 这是我的博客。"

[🎫 site][site] | [🎟 get start][getting-started/docs] | [🎞 docs][documentation/docs] | [🧣 src][src/gh]

[site]: https://getnelson.io/ "Nelson – Cloud-native container deployment // Nelson – 云原生容器部署"
[introduction/docs]: https://getnelson.io/introduction/ "Nelson is a system for continuously deploying containers, and automatically managing their lifecycle. An application lifecycle refers to starting an application and then later wanting to replace that same application with say, a newer version. Nelson provides the plumbing to make that happen automatically: you simply focus on shipping changes to your repository, and Nelson orchestrates the launching, running, and eventual sunset of a given application revision. // Nelson 是一个用于持续部署容器并自动管理其生命周期的系统。应用程序生命周期是指启动应用程序，然后想要用更新版本替换同一应用程序。 Nelson 提供了管道来自动实现这一点：您只需专注于将更改发送到存储库，Nelson 就会协调给定应用程序修订的启动、运行和最终日落。 /// Nelson is not a monolithic solution that solves all problems. Nelson follows the classic Unix philosphy: it is highly composable with other tools, which allows the system to be non-prescriptive, whilst still itself delivering value. // Nelson 并不是解决所有问题的单一解决方案。 Nelson 遵循经典的 Unix 哲学：它与其他工具高度可组合，这使得系统可以是非规范性的，同时仍然可以提供价值。"
[getting-started/docs]: https://getnelson.io/getting-started/ "This user guide covers the information that a user should make themselves familiar with to both get started with Nelson, and also get the most out of the system. Certain parts of Nelson have been covered in more detail than would be typical for an entry-level user guide, but this is to make sure users are fully aware of the choices they are making when building out their deployment specification. // 本用户指南涵盖了用户应该熟悉的信息，以便开始使用 Nelson 并充分利用系统。 Nelson 的某些部分比入门级用户指南的典型内容更详细，但这是为了确保用户充分了解他们在构建部署规范时所做的选择。"
[documentation/docs]: https://getnelson.io/documentation/ "The Nelson documentation serves as a reference guide for all available features and options of Nelson. If you’re just getting started, please consider reading the introduction and working through the Getting Started guides or tutorial sections. // Nelson 文档可作为 Nelson 所有可用功能和选项的参考指南。如果您刚刚开始，请考虑阅读简介并完成入门指南或教程部分。"

[src/gh]: https://github.com/getnelson/nelson.git "(Apache-2.0) (Languages: Scala 97.6%, Mustache 1.1%, Shell 0.6%, HTML 0.5%, HCL 0.1%, CSS 0.1%) Automated, multi-region container deployment // 自动化、多区域容器部署"

## Introduce

ref: [The introduction 🎏][introduction/docs]

### What is Nelson? | Nelson 是什么？

> Nelson is a system for continuously deploying containers, and automatically managing their lifecycle. An application lifecycle refers to starting an application and then later wanting to replace that same application with say, a newer version. Nelson provides the plumbing to make that happen automatically: you simply focus on shipping changes to your repository, and Nelson orchestrates the launching, running, and eventual sunset of a given application revision.
> 
> Nelson 是一个用于持续部署容器并自动管理其生命周期的系统。应用程序生命周期是指启动应用程序，然后想要用更新版本替换同一应用程序。 Nelson 提供了管道来自动实现这一点：您只需专注于将更改发送到存储库，Nelson 就会协调给定应用程序修订的启动、运行和最终日落。
> 

#### Git-centric | 以 Git 为中心

> Everything must be versioned. Nelson adopts a hardline position on configuration and changes made to systems at runtime: with two explicit exceptions, no application shall change its operable configuration. This means that your configuration is code and should be checked in along with your application. This includes the declarative manifest file that Nelson uses to receive its instructions. If you need configuration changes, modify it, check it in and redeploy.
> 
> 一切都必须有版本。 Nelson 对运行时系统的配置和更改采取强硬立场：除了两个明确的例外，任何应用程序都不得更改其可操作配置。这意味着您的配置是代码，应该与您的应用程序一起签入。这包括 Nelson 用于接收其指令的声明性清单文件。如果需要更改配置，请修改它、签入并重新部署。
> 
> Adopting this approach has several discrete advantages:
> 
> 采用这种方法有几个独立的优点：
> 
> - Reduced deployment risk: by deploying smaller sets of changes more frequently, you can know exactly what change set went into a particular version. There are several development workflows available with Nelson; you can choose your deployment cadence and the amount of code that goes into a specific release.
>   
>   降低部署风险：通过更频繁地部署较小的更改集，您可以准确地知道特定版本中包含哪些更改集。 Nelson 提供多种开发工作流程；您可以选择部署节奏以及进入特定版本的代码量。
>   
> - Container images used at runtime are essentially inert and the container registry / image store does not need to be tightly secured, because no private information or system secrets are in the container a-priori.
>   
>   运行时使用的容器镜像本质上是惰性的，容器注册表/镜像存储不需要严格保护，因为容器中不存在任何私有信息或系统秘密。
>   
> - Every single change to the system has an audit trail, thanks to Git.
>   
>   感谢 Git，对系统的每一次更改都有审计跟踪。
>   
> 

#### Safe and Secure | 安全又可靠

> Runtime containers does not hold any credentials or other secret material until the very moment they are launched by the scheduler. The credentials given to the container dictate the access permissions the container has, and Nelson automatically provisions access policies based on what information it was told about the deployment. This has some nice properties:
> 
> 运行时容器在调度程序启动之前不会保存任何凭证或其他秘密材料。提供给容器的凭据决定了容器拥有的访问权限，Nelson 根据所获悉的部署信息自动配置访问策略。这有一些很好的属性：
> 
> - You cannot interact with a system or resource that you did not tell Nelson about.
>   
>   您无法与您未告知 Nelson 的系统或资源进行交互。
>   
> - System auditing is a breeze: query the graph to see what applications use which secure resources.
>   
>   系统审核轻而易举：查询图表以查看哪些应用程序使用哪些安全资源。
>   
> - In the event of a compromised system, simply instruct Nelson to redeploy the affected system(s) and the new deployment will have an entirely new set of credentials and the old permissions and policies will all be revoked and deleted.
>   
>   如果系统遭到破坏，只需指示 Nelson 重新部署受影响的系统，新部署将拥有一组全新的凭据，并且旧的权限和策略将全部被撤销和删除。
>   
> 
> Practically speaking, credentials are sourced from Vault (or a KMS of your choosing), and then mounted to a `tempfs` attached to the container (an in-memory filesystem). You can only source credentials from Vault, for which you have a valid Vault Policy. These policies are dynamically generated by Nelson, and provisioned for you automatically at deployment time, and deleted automatically when the deployment is later torn down.
> 
> 实际上，凭证源自 Vault（或您选择的 KMS），然后安装到附加到容器的 `tempfs` （内存中文件系统）。您只能从拥有有效保管库策略的保管库获取凭据。这些策略由 Nelson 动态生成，并在部署时自动为您配置，并在稍后拆除部署时自动删除。
> 

#### Consistent | 持续性

> By virtue of the fact that Nelson is orchestrating application deployments over potentially many target datacenters, it is important to realize that there is a subsequent lack of transactionality in the operations Nelson takes. This is most apparent when deploying a new revision of a particular system: application code can never assume it is a “singleton” or in some way special, as the minimum number of versions running - even if it’s for a very short time - will be greater than one. Nelson will eventually deliver on its promise and make one revision the primary revision of a system by cleaning up the others, depending on the particular circumstances, that process might not be immediate, and is most certainly not atomic.
> 
> 由于 Nelson 正在在可能的多个目标数据中心上编排应用程序部署，因此重要的是要认识到 Nelson 所执行的操作随后缺乏事务性。这在部署特定系统的新版本时最为明显：应用程序代码永远不能假设它是“单例”或在某种程度上是特殊的，因为运行的版本的最小数量 —— 即使是很短的时间 —— 将是大于一。尼尔森最终将兑现其承诺，通过清理其他系统，使一个修订成为系统的主要修订，根据具体情况，该过程可能不会立即发生，而且肯定不是原子的。
> 
> This means that application creators have the following constraints:
> 
> 这意味着应用程序创建者面临以下限制：
> 
> 1.  Applications which require singleton behavior can either choose to implement application-layer leader election, or use convergent data structures to make sure that all overlapping changes will always commute.
>     
>     需要单例行为的应用程序可以选择实现应用层领导者选举，或者使用收敛数据结构来确保所有重叠的更改始终可以交换。
>     
> 2.  Data corruption can - and will - eventually happen and applications need to be able to recover from this. Typically this means checkpointing data writes to limit the blast radius of any potential corruption (more appropriate for batch-style processes), engineering teams should properly evaluate the possibility for corruption and recovery in their particular use case.
>     
>     数据损坏最终可能并且将会发生，并且应用程序需要能够从中恢复。通常，这意味着对数据写入进行检查点以限制任何潜在损坏的影响范围（更适合批处理式流程），工程团队应正确评估其特定用例中损坏和恢复的可能性。
>     
> 
> The authors of Nelson fully appreciate that these constraints require more engineering work. However, by applying these constraints it means Nelson can provide a guarantee around several critical behaviors, and set the right expectation from the start about application lifecycle. Moreover, these constraints represent best practice from a distributed systems perspective, and acknowledge the reality of discrete, interactive systems.
> 
> Nelson 的作者充分认识到这些限制需要更多的工程工作。然而，通过应用这些约束，这意味着 Nelson 可以围绕几个关键行为提供保证，并从一开始就对应用程序生命周期设定正确的期望。此外，这些约束代表了从分布式系统角度来看的最佳实践，并承认离散、交互式系统的现实。
> 

### What Nelson Is Not | 尼尔森不是什么

> Nelson is not a monolithic solution that solves all problems. Nelson follows the classic Unix philosphy: it is highly composable with other tools, which allows the system to be non-prescriptive, whilst still itself delivering value. There are a few scenarios which were very deliberately ignored:
> 
> Nelson 并不是解决所有问题的单一解决方案。 Nelson 遵循经典的 Unix 哲学：它与其他工具高度可组合，这使得系统可以是非规范性的，同时仍然可以提供价值。有一些场景被故意忽略：
> 
> - Nelson does not support ad-hoc deployments: users cannot deploy random, unversioned containers from their desktop; this is a very deliberate design feature.
>   
>   Nelson 不支持临时部署：用户无法从桌面部署随机的、未版本控制的容器；这是一个非常刻意的设计特点。
>   
> - Nelson works best in a poly-repo environment, where builds focus on small, atomic units. Nelson can work with explicit tagging and releasing for those with a mono-repo style of source control, but it will almost certainly require some proprietary tooling - this will always be out of scope for Nelson and its ecosystem.
> 
>   Nelson 在多回购环境中工作得最好，在该环境中，构建重点关注小型原子单元。 Nelson 可以为那些具有单一存储库风格的源代码控制的人提供显式标记和发布，但几乎肯定需要一些专有工具 —— 这始终超出 Nelson 及其生态系统的范围。
>   
> 




