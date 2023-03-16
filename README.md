
~~~ postscript
note about practice . 🦎🤔
~~~

repo content: 

- [`containerisable instances`](./practices-notes)
- [`requests with instance plays`](./play-demos)
- [`builds`](./build-practices)

*任何目录下都有合乎某特定规则的命名形式，
任何目录下也都可增加不符合该形式的隐藏目录来增加必要的额外记录。*

----

note: 


陶器烧制技术是非常重要的。因为，它让人类几乎是第一次拥有了可以长期使用且性质稳定的容器。

而有了容器，人类文明就有了分水岭。（确切说是 *野蛮时代* 向 *蒙昧时代* 的过渡是从制陶术开始的，这是 *摩尔根* 的观点——记载自《家庭、私有制和国家的起源》。）

现代容器（ *Docker/OCI* ）的优势在于对软件分了层。在它们出现之前，如果你在本地调试成功的代码，放到别的环境（比如那些为你准备好了 `服务器 + 运行环境` 两者的 *PaaS* 服务）就不能用了。你便只有束手无策了。你当然可以找到原因，但这一次的只管这一次，下一次又要从头找，没有太多规律可循，几乎要全凭经验或者更加不可靠的「玄学」来作为解决问题的线索。

但，有了容器，分发的时候就好多了。

应用（的正常工作能力）的成立是有条件的，没有可以放之四海皆准的东西，这就像任何（不仅限于计算机领域的）事物一样。



> 共享的可变是万恶之源
> 

> 用共享内存通信不如用通信共享内存
> 

容器（确切说是它的镜像）有点像闭包：要运行的你的代码和它所依赖的东西被打包到了一起，要被转移到那里就被转移到哪里（只不过这里要分别把二者的其余必要部分都视为一个不必关注其细节的 `解释器` 整体）——这是正确的做法。

（当然了容器还要自己精简镜像，还不一定精简得好。 [distroless](https://github.com/GoogleContainerTools/distroless.git) 算是个已经做得不错的精简方案。闭包则优雅得多，它只会带上它需要的那些依赖，而且这是自动完成确定的——它清楚地知道它依赖了什么。）

而在这之前，没有这样的正确的做法，特别是当人们还没有干那么多 *PaaS* 之上的工作的时候。

这就是 [*New Jersey approach*](https://dreamsongs.com/RiseOfWorseIsBetter.html) 风格的特点。相对的另一种风格叫 [*MIT approach*](https://dreamsongs.com/RiseOfWorseIsBetter.html) ，闭包应该是后者一派的发明中的一部分，我没记错的话……

前者认为 `更坏就是更好` `软件（如系统）制作的简单远比它的正确合理要重要` ，后者认为 `正确合理要在第一位` `为了达到它简单可以放在第二位` 。

而也正如下面的引用所讲，前者必然能获得最广泛的传播。

——说白了，使用工具的人从来都首先希望工具能胜任特定的功能——这也是「机械」会令人感到不和谐的地方，即便它的本质一样也是自然力：它只是与草木肉身等等这样的「机械」并不**匹配**罢了，「不谐」的存在才令人发现了「机械的和自然的就是有什么不同」，即便对于心知肚明「机械也不过是自然力」的人而言。

但，所有参与过与他人共同劳动的人都知道，一般而言，整体的效率瓶颈其实是在「沟通」或「配合」这种人和人之间的事情的层面（更多的还有利益分配之类的）而不是目前的技术水平；或者我再举个例子，现在只允许你用文件夹作为数据库、用文件做表，那么接下来，你的行动就要受到各种限制——你不是什么都做不到，总会有很多不方便；你可能首先会限制用户「禁止在字符串内夹带空格或者某些特定字符」，但即便如此，如果现在需要在巨大的「表」中按照某个字段查询的话，性能就会成为令人头疼的问题，你可能要做各种复杂的「分表」设计并用蹩脚的 SHell 脚本予以「封装」、或者你可能需要选用合适的文件系统或者更加强力的硬件……但，事实上，不论你怎么在一个糟糕的基础上「凑合过」，都不如干脆干掉这种让你「不得不面临电车难题」的错误基础：打破我给你的限制，使用一个正常的（以及合乎你**不仅仅当下的**需要的）数据库。

或者，再举个例子：扔垃圾的人在包装垃圾袋的时候就提前做好分类，这比把可能会产生发酵或者化学反应的多种不同垃圾提前混合起来然后交给下游再重新分开，要好很多。把产生垃圾的人和下游垃圾处理厂视为一个联合起来共担成本的整体的话，显然不会出现「先混起来再用什么高科技分开」的设计。或者说如果能有这样高的科技水平的话，那么在混合起来之前就分清楚的工作仍然是更容易的（瓶颈仍然只会存在于 `人和人之间关系` 的层面而不是技术或者设计上）。

——这就是「做正确的事」的价值所在。

> [*sometimes it takes a tough man to make a tender chicken*](https://english.stackexchange.com/questions/24460/what-does-it-takes-a-tough-man-to-make-a-tender-chicken-mean)
> 
> *`没有一个够硬的厨子就可能做不出一道够嫩的鸡`*
> 

精益求精对于整体的避免不必要浪费而言，是必要的。一个各节点之间密切联系的流程，会省区绝大部分的不必要的浪费。比如，对上游而言保留数据的结构信息是轻而易举的事情的话，下游就没必要专门再耗费人工或机器的力气从一堆无结构的数据中重新整理出结构。设计恰当的数据结构，好过对万能解释器的依赖。

但，问题也就在于，在一个历史阶段下，不会产生超脱这个阶段的产物。

> Half the computers that exist at any point are worse than median (smaller or slower). Unix and C work fine on them. The worse-is-better philosophy means that implementation simplicity has highest priority, which means Unix and C are easy to port on such machines. Therefore, one expects that if the 50% functionality Unix and C support is satisfactory, they will start to appear everywhere. And they have, haven’t they?
> 
> `在任何时候都会存在一半计算机都比中位数更差（更小或更慢）。 Unix 和 C 语言在它们上面运行良好。更差就是更好的哲学意味着实现的简单性具有最高的优先权，这意味着 Unix 和 C 语言很容易植入在这些机器上。因此，人们期望，如果 Unix 和 C 支持的 50% 的功能令人满意，那它就要到处出现了。而且它们已经出现了，不是吗？`
> 
> Unix and C are the ultimate computer viruses.
> 
> `Unix 和 C 是最终的计算机病毒。`
> 
> further benefit of the worse-is-better philosophy is that the programmer is conditioned to sacrifice some safety, convenience, and hassle to get good performance and modest resource use. Programs written using the New Jersey approach will work well both in small machines and large ones, and the code will be portable because it is written on top of a virus.
> 
> `更差就是更好的哲学的另一个好处是，程序员有条件牺牲一些安全、方便和麻烦来获得良好的性能和适度的资源使用。使用新泽西方法编写的程序在小机器和大机器上都能很好地工作，而且代码将是可移植的，因为它是写在病毒之上的。`
> 

一个社会中的软件，其普遍能达到什么样的形态，这和产生出来它的这个社会本身的结构形态，是密不可分的。

软件只是一方面——或者，你也可以把「设计城市的垃圾处理流程」视为设计软件。（然后你会发现当下的话大家各自牟利所以并不存在一个联合的共担成本的利益整体🙃）

但是，这不代表精益求精不值得做。

> 人体解剖是猴体解剖的钥匙。
> 

只有到达下一个台阶，放才能看到先前所站处的全貌。

> 屈服暂时的困难、迁就眼前的利益、忘掉革命的根本任务，不仅要毁灭自己，而且会葬送革命。
> 

但只有前行，才能到达下个台阶。

- 妄图在行动之前就得到完整的答案；
- 妄图在一个迁就眼前利益而成的基础上改良而达到完整的答案；

——上述两者，其实是同一回事罢。

> ……作为完成了的人道主义，等于自然主义；作为完成了的自然主义，等于人道主义……它是历史之谜的真正解答，并且知道自己就是这种解答。（1844手稿）
> 

因为机械也不过是自然力，人看见的自然必定也都只会是被人参与过了的自然；「机械」的意味更多在于掌控的一面、「自然」则作为其对立面来成为可被辨识的（即存在的）概念，「自然」只有因为它的「未被掌控」而被视为「非机械」从而被辨识、「机械」也只有由于不和谐这一「非自然」才得以成为一个可被认知的（即存在的）性质；而「解答」其实就是二者分歧的消弭——「不协调」之消弭同时也就是「不可控」之消弭，就是不断地显现它们、并最终找到并取得（或者说达到）那个能全部解决它们的方案。

——在程序分发的层面，闭包就像是一个这样的解答。而容器，更像是一种在糟糕的旧秩序里基于新的理念的改进。它是有限的，但它同时也是「伊壁鸠鲁在德谟克利特之基础上所增加的偏斜」——即是使得（方案的）结论整体成为完全不同的另一个的，那么个新增的东西。而当一切历史芥蒂都可以随着不再被迁就的眼前利益一同放下，当函数成为系统内程序的唯一值得使用的组织手段，当冗余臃肿的架构终于真正得到了精简，程序的分发也就能以它本来的（也早已有结论的）方式来进行了吧。到时候，它可以仍然叫闭包，当然也可以叫容器——因为一个可以成为操作系统的语言也必定不能只是像我们传统认知中的语言那样，但这也已然又是「加入过偏斜后」的「容器」了。


--------

good things: 

- [Containerization Explained 容器化解释 | IBM](https://www.ibm.com/topics/containerization)
- [The introduction to Reactive Programming you've been missing](https://gist.github.com/staltz/868e7e9bc2a7b8c1f754)
- [Worse Is Better -- Lisp: Good News, Bad News, How to Win Big](https://dreamsongs.com/WIB.html)
- [容器战争 - Nolla](https://cmgs.me/life/container-war)
- [基于 Rust 讲解容器都有哪些东西](https://litchipi.github.io/series/container_in_rust)
- [UNIKERNEL：从不入门到入门 | 高策](https://gaocegege.com/Blog/%E5%AE%89%E5%88%A9/unikernel-book)
- [一种新的操作系统设计](https://www.yinwang.org/blog-cn/2013/04/14/os-design)
- [Oberon | concatenative.org](https://concatenative.org/wiki/view/Oberon)
- [程序员的酒后真言 | Greycode's Blog](https://greycode.top/posts/a98d5ec3509f483e80919ca2e09bda1b/)
- [编写像 Erlang/Elixir 那样的 Rust 程序](https://lunatic.solutions/blog/writing-rust-the-elixir-way/)
