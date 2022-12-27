
[site]: https://iroh.computer
[behinder-site]: https://n0.computer
[behinder-site-ipns]: ipns://n0.computer

[repo]: https://github.com/n0-computer/iroh.git
[docs]: https://iroh.computer/docs

> Iroh is a next-generation implementation of the Interplanetary File System ([IPFS](https://ipfs.io)) for Cloud, Mobile & Desktop platforms. IPFS is a networking protocol for exchanging content-addressed blocks of immutable data. content-addressed means referring to data by the hash of it’s content, which makes the reference both unique and verifiable. These two properties make it possible to get data from *any* node in the network that speaks the IPFS protocol, including IPFS content being served by other implementations of the protocol.
> 

- repo: [`n0-computer/iroh`][repo]
- site: [`iroh.computer`][site] [`docs`][docs]
- organization: [`n0.computer`][behinder-site]

# n0.computer

ref: [n0.computer][behinder-site]

00:

> **Reducing net work for networks** **减少网络的净工作**
> 
> We are an open R&D organization focused on efficient distributed systems
> 
> 我们是一个专注于高效分布式系统的开放式研发机构
> 

01:

> Rather than optimize for performance or decentralization, we're building networks that use fewer resources to perform the same task.
> 
> 我们不是为性能或分散而优化，而是要建立使用更少资源来执行相同任务的网络。
> 
> With five plus years of experience building open distributed systems *each*, our founding team understands the importance of collaboration and accessibility when it comes to developing innovative software and conducting research.
> 
> 我们的创始团队 *各自* 拥有五年多的构建开放式分布式系统的经验，他们了解在开发创新软件和进行研究时，协作和可及性的重要性。
> 
> We measure everything. We think technology is best when it's a bit creative. We build things that just work. If that sounds cool to you, let's [connect](https://twitter.com/n0computer).
> 
> 我们衡量一切。我们认为技术最好是有点创意的时候。我们建立的东西只是工作。如果这对你来说听起来很酷，让我们联系吧。
> 

# iroh

> The most efficient implementation of IPFS on any planet.
> 
> 任何星球上最有效的IPFS的实现。
> 

## compare Kubo

[diff-kubo]: https://iroh.computer/docs/iroh-and-kubo

ref: 

- 与 Kubo 的软件内容区别与详细命令对比： [docs][diff-kubo]
- 更快： [site][site]

从文档可以看到， `iroh` 的命令支持是对标于 `kubo` 的，并且功能上只实现了一部分——大部分的主要功能现在都实现了。
前者显然是还没做完的状态。安装方式里的部分支持，比如 Docker (OCI) 的支持，正处于 `more soon` 的状态。

兼容性和互支持性见上面的参考链接。

而在主页，有显示与 `kubo` 相比的性能对比：

> #### Faster
> 
> Iroh consistently outperforms Kubo, using fewer resources to serve more requests.  
> There is a ring of truth to the "rewrite it in Rust" cliché. Adding in lessons learned while working with IPFS over the years doesn't hurt either.  
> 
> - Throughput `req/second`
>   
>   - Iroh: `6,926`
>   - Kubo: `4,957`
>   
> - Adding Content `100mb Files`
>   
>   - Iroh: `199 Mb/s`
>   - Kubo: `294 Mb/s`
>   
> 

其它介绍：

> #### Practical
> 
> Iroh does fewer things than kubo, with more polish. Iroh targets a subset of the kubo API, aiming at the most commonly-used features of IPFS, while steering users away from pitfalls that have been trapped in kubo to maintain backward compatibility.  
> 
> If it's shipped in iroh, it will just work.  
> 
> #### Platform Specific
> 
> Running a single binary in the cloud doesn't make much sense. Neither does duplicating files locally when running IPFS on the desktop  
> 
> Iroh is a single codebase with multiple platform targets, allowing iroh to be microservices in the cloud, use more natural defaults on desktop.  
> 
> #### Mobile Support
> 
> Finally, IPFS on a phone.  
> 
> Iroh can be embedded into iOS & Android applications to speak the IPFS protocol natively. It's not a device-overheating afterthought, it's a ground-up rethink of what IPFS on a phone should look like.  
> 





