

> # 简介
> 
> KCP是一个快速可靠协议，能以比 TCP 浪费 10%-20% 的带宽的代价，换取平均延迟降低 30%-40%，且最大延迟降低三倍的传输效果。纯算法实现，并不负责底层协议（如UDP）的收发，需要使用者自己定义下层数据包的发送方式，以 callback的方式提供给 KCP。 连时钟都需要外部传递进来，内部不会有任何一次系统调用。
> 
> 整个协议只有 ikcp.h, ikcp.c两个源文件，可以方便的集成到用户自己的协议栈中。也许你实现了一个P2P，或者某个基于 UDP的协议，而缺乏一套完善的ARQ可靠协议实现，那么简单的拷贝这两个文件到现有项目中，稍微编写两行代码，即可使用。
> 
> 
> # 技术特性
> 
> TCP是为流量设计的（每秒内可以传输多少KB的数据），讲究的是充分利用带宽。而 KCP是为流速设计的（单个数据包从一端发送到一端需要多少时间），以10%-20%带宽浪费的代价换取了比 TCP快30%-40%的传输速度。TCP信道是一条流速很慢，但每秒流量很大的大运河，而KCP是水流湍急的小激流。KCP有正常模式和快速模式两种，通过以下策略达到提高流速的结果：
> 
> #### RTO翻倍vs不翻倍：
> 
>    TCP超时计算是RTOx2，这样连续丢三次包就变成RTOx8了，十分恐怖，而KCP启动快速模式后不x2，只是x1.5（实验证明1.5这个值相对比较好），提高了传输速度。
> 
> #### 选择性重传 vs 全部重传：
> 
>    TCP丢包时会全部重传从丢的那个包开始以后的数据，KCP是选择性重传，只重传真正丢失的数据包。
> 
> #### 快速重传：
> 
>    发送端发送了1,2,3,4,5几个包，然后收到远端的ACK: 1, 3, 4, 5，当收到ACK3时，KCP知道2被跳过1次，收到ACK4时，知道2被跳过了2次，此时可以认为2号丢失，不用等超时，直接重传2号包，大大改善了丢包时的传输速度。
> 
> #### 延迟ACK vs 非延迟ACK：
> 
>    TCP为了充分利用带宽，延迟发送ACK（NODELAY都没用），这样超时计算会算出较大 RTT时间，延长了丢包时的判断过程。KCP的ACK是否延迟发送可以调节。
> 
> #### UNA vs ACK+UNA：
> 
>    ARQ模型响应有两种，UNA（此编号前所有包已收到，如TCP）和ACK（该编号包已收到），光用UNA将导致全部重传，光用ACK则丢失成本太高，以往协议都是二选其一，而 KCP协议中，除去单独的 ACK包外，所有包都有UNA信息。
> 
> #### 非退让流控：
> 
>    KCP正常模式同TCP一样使用公平退让法则，即发送窗口大小由：发送缓存大小、接收端剩余接收缓存大小、丢包退让及慢启动这四要素决定。但传送及时性要求很高的小数据时，可选择通过配置跳过后两步，仅用前两项来控制发送频率。以牺牲部分公平性及带宽利用率之代价，换取了开着BT都能流畅传输的效果。
> 



> # 文档索引
> 
> 协议的使用和配置都是很简单的，大部分情况看完上面的内容基本可以使用了。如果你需要进一步进行精细的控制，比如改变 KCP的内存分配器，或者你需要更有效的大规模调度 KCP链接（比如 3500个以上），或者如何更好的同 TCP结合，那么可以继续延伸阅读：
> 
> - [Wiki Home](https://github.com/skywind3000/kcp/wiki)
> - [KCP 最佳实践](https://github.com/skywind3000/kcp/wiki/KCP-Best-Practice)
> - [同现有TCP服务器集成](https://github.com/skywind3000/kcp/wiki/Cooperate-With-Tcp-Server)
> - [传输数据加密](https://github.com/skywind3000/kcp/wiki/Network-Encryption)
> - [应用层流量控制](https://github.com/skywind3000/kcp/wiki/Flow-Control-for-Users)
> - [性能评测](https://github.com/skywind3000/kcp/wiki/KCP-Benchmark)
> 
> 
> # 开源案例
> 
> - [kcptun](https://github.com/xtaci/kcptun): 基于 kcp-go做的高速远程端口转发(隧道) ，配合ssh -D，可以比 shadowsocks 更流畅的看在线视频。
> - [dog-tunnel](https://github.com/vzex/dog-tunnel): GO开发的网络隧道，使用 KCP极大的改进了传输速度，并移植了一份 GO版本 KCP
> - [v2ray](https://www.v2ray.com): 著名代理软件，Shadowsocks 代替者，1.17后集成了 kcp协议，使用UDP传输，无数据包特征。
> - [HP-Socket](https://github.com/ldcsaa/HP-Socket): 高性能网络通信框架 HP-Socket。
> - [frp](https://github.com/fatedier/frp): 高性能内网穿透的反向代理软件，可将将内网服务暴露映射到外网服务器。
> - [asio-kcp](https://github.com/libinzhangyuan/asio_kcp): 使用 KCP的完整 UDP网络库，完整实现了基于 UDP的链接状态管理，会话控制，KCP协议调度等
> - [kcp-java](https://github.com/hkspirt/kcp-java): Java版本 KCP协议实现。
> - [kcp-netty](https://github.com/szhnet/kcp-netty): kcp的Java语言实现，基于netty。
> - [java-kcp](https://github.com/l42111996/java-Kcp): JAVA版本KCP,基于netty实现(包含fec功能)
> - [csharp-kcp](https://github.com/l42111996/csharp-kcp): csharp版本KCP,基于dotNetty实现(包含fec功能)
> - [kcp-cpp](https://github.com/Unit-X/kcp-cpp): KCP 的多平台（Windows、MacOS、Linux）C++ 实现作为应用程序中的简单库。包含适用于所有平台的套接字处理和辅助函数。
> - [kcp-perl](https://github.com/Homqyy/kcp-perl): kcp的Perl实现，其是面向对象的，Perl-Like的。
> - [kcp-go](https://github.com/xtaci/kcp-go): 高安全性的kcp的 GO语言实现，包含 UDP会话管理的简单实现，可以作为后续开发的基础库。 
> - [kcp-csharp](https://github.com/limpo1989/kcp-csharp): kcp的 csharp移植，同时包含一份回话管理，可以连接上面kcp-go的服务端。
> - [kcp-csharp](https://github.com/KumoKyaku/KCP): 新版本 Kcp的 csharp移植。线程安全，运行时无alloc，对gc无压力。
> - [kcp2k](https://github.com/vis2k/kcp2k/): Line-by-line translation to C#, with optional Server/Client on top.
> - [kcp-rs](https://github.com/en/kcp-rs): KCP的 rust移植
> - [kcp-rust](https://github.com/Matrix-Zhang/kcp)：新版本 KCP的 rust 移植
> - [tokio-kcp](https://github.com/Matrix-Zhang/tokio_kcp)：rust tokio 的 kcp 集成
> - [kcp-rust-native](https://github.com/b23r0/kcp-rust-native)：rust 的 kcp bindings
> - [lua-kcp](https://github.com/linxiaolong/lua-kcp): KCP的 Lua扩展，用于 Lua服务器
> - [node-kcp](https://github.com/leenjewel/node-kcp): node-js 的 KCP 接口  
> - [nysocks](https://github.com/oyyd/nysocks): 基于libuv实现的[node-addon](https://nodejs.org/api/addons.html)，提供nodejs版本的代理服务，客户端接入支持SOCKS5和ss两种协议
> - [shadowsocks-android](https://github.com/shadowsocks/shadowsocks-android): Shadowsocks for android 集成了 kcptun 使用 kcp协议加速 shadowsocks，效果不错
> - [kcpuv](https://github.com/elisaday/kcpuv): 使用 libuv开发的kcpuv库，目前还在 Demo阶段
> - [Lantern](https://getlantern.org/)：更好的 VPN，Github 50000 星，使用 kcpgo 加速
> - [rpcx](https://github.com/smallnest/rpcx) ：RPC 框架，1000+ 星，使用 kcpgo 加速 RPC
> - [xkcptun](https://github.com/liudf0716/xkcptun): c语言实现的kcptun，主要用于[OpenWrt](https://github.com/openwrt/openwrt), [LEDE](https://github.com/lede-project/source)开发的路由器项目上
> - [et-frame](https://github.com/egametang/ET): C#前后端框架(前端unity3d)，统一用C#开发游戏，实现了前后端kcp协议
> - [yasio](https://github.com/yasio/yasio): 一个跨平台专注于任意客户端程序的异步socket库, 易于使用，相同的API操作KCP/TCP/UDP, 性能测试结果: [benchmark-pump](https://github.com/yasio/yasio/blob/master/benchmark.md).
> - [gouxp](https://github.com/shaoyuan1943/gouxp): 用Go实现基于回调方式的KCP开发包，包含加解密和FEC支持，简单易用。  
> - [skcp](https://github.com/xboss/skcp): 基于libev实现的库，具备传输加密及基本的连接管理能力。
> - [pykcp](https://github.com/enkiller/pykcp): Python 版本的 KCP 实现
> 
> # 商业案例
> 
> - [原神](https://ys.mihoyo.com/)：米哈游的《原神》使用 KCP 降低游戏消息的传输耗时，提升操作的体验。
> - [SpatialOS](https://improbable.io/spatialOS): 大型多人分布式游戏服务端引擎，BigWorld 的后继者，使用 KCP 加速数据传输。
> - [西山居](https://www.xishanju.com/)：使用 KCP 进行游戏数据加速。
> - [CC](http://cc.163.com/)：网易 CC 使用 kcp 加速视频推流，有效提高流畅性
> - [BOBO](http://bobo.163.com/)：网易 BOBO 使用 kcp 加速主播推流
> - [UU](https://uu.163.com)：网易 UU 加速器使用 KCP/KCPTUN 经行远程传输加速。
> - [阿里云](https://cn.aliyun.com/)：阿里云的视频传输加速服务 GRTN 使用 KCP 进行音视频数据传输优化，动态加速产品也使用 KCP。
> - [云帆加速](http://www.yfcloud.com/)：使用 KCP 加速文件传输和视频推流，优化了台湾主播推流的流畅度。
> - [明日帝国](https://www.taptap.com/app/50664)：Game K17 的 《明日帝国》 （Google Play），使用 KCP 加速游戏消息，让全球玩家流畅联网
> - [仙灵大作战](https://www.taptap.com/app/27242)：4399 的 MOBA游戏，使用 KCP 优化游戏同步
> 
> KCP 成功的运行在多个用户规模上亿的项目上，为他们提供了更加灵敏和丝滑网络体验。
> 
> 欢迎告知更多案例
> 
> # 协议比较
> 
> 如果网络永远不卡，那 KCP/TCP 表现类似，但是网络本身就是不可靠的，丢包和抖动无法避免（否则还要各种可靠协议干嘛）。在内网这种几乎理想的环境里直接比较，大家都差不多，但是放到公网上，放到3G/4G网络情况下，或者使用内网丢包模拟，差距就很明显了。公网在高峰期有平均接近10%的丢包，wifi/3g/4g下更糟糕，这些都会让传输变卡。
> 
> 感谢 [asio-kcp](https://github.com/libinzhangyuan/asio_kcp) 的作者 [zhangyuan](https://github.com/libinzhangyuan) 对 KCP 与 enet, udt做过的一次横向评测，结论如下：
> 
> - ASIO-KCP **has good performace in wifi and phone network(3G, 4G)**.
> - The kcp is the **first choice for realtime pvp game**.
> - The lag is less than 1 second when network lag happen. **3 times better than enet** when lag happen.
> - The enet is a good choice if your game allow 2 second lag.
> - **UDT is a bad idea**. It always sink into badly situation of more than serval seconds lag. And the recovery is not expected.
> - enet has the problem of lack of doc. And it has lots of functions that you may intrest.
> - kcp's doc is chinese. Good thing is the function detail which is writen in code is english. And you can use asio_kcp which is a good wrap.
> - The kcp is a simple thing. You will write more code if you want more feature.
> - UDT has a perfect doc. UDT may has more bug than others as I feeling.
> 
> 具体见：[横向比较](https://github.com/libinzhangyuan/reliable_udp_bench_mark) 和 [评测数据](https://github.com/skywind3000/kcp/wiki/KCP-Benchmark)，为犹豫选择的人提供了更多指引。
> 
> 大型多人游戏服务端引擎 [SpatialOS](https://improbable.io/spatialOS) 在集成 KCP 协议后做了同 TCP/RakNet 的评测：
> 
> ![spatialos-50.png](./.images/spatialos-50.png)
> 
> 对比了在服务端刷新率为 60 Hz 同时维护 50 个角色时的响应时间，详细对比报告见：
> 
> - [Kcp a new low latency secure network stack](https://improbable.io/blog/kcp-a-new-low-latency-secure-network-stack)
> 
> 
> # 关于协议
> 
> 近年来，网络游戏和各类社交网络都在成几何倍数的增长，不管网络游戏还是各类互动社交网络，交互性和复杂度都在迅速提高，都需要在极短的时间内将数据同时投递给大量用户，因此传输技术自然变为未来制约发展的一个重要因素，而开源界里各种著名的传输协议，如 raknet/enet 之类，一发布都是整套协议栈一起发布，这种形式是不利于多样化的，我的项目只能选择用或者不用你，很难选择 “部分用你”，然而你一套协议栈设计的再好，是非常难以满足不同角度的各种需求的。
> 
> 因此 KCP 的方式是把协议栈 “拆开”，让大家可以根据项目需求进行灵活的调整和组装，你可以下面加一层 reed solomon 的纠删码做 FEC，上面加一层类 RC4/Salsa20 做流加密，握手处再设计一套非对称密钥交换，底层 UDP 传输层再做一套动态路由系统，同时探测多条路径，选最好路径进行传输。这些不同的 “协议单元” 可以像搭建积木一般根据需要自由组合，保证 “简单性” 和 “可拆分性”，这样才能灵活适配多变的业务需求，哪个模块不好，换了就是。
> 
> 未来传输方面的解决方案必然是根据使用场景深度定制的，因此给大家一个可以自由组合的 “协议单元” ，方便大家集成在自己的协议栈中。
> 
> For more information, please see the [Success Stories](https://github.com/skywind3000/kcp/wiki/Success-Stories).
> 
> 
> # 关于作者
> 
> 作者：林伟 (skywind3000)
> 
> 欢迎关注我的：[twitter](https://twitter.com/skywind3000) 和 [zhihu](https://www.zhihu.com/people/skywind3000)。
> 
> 我在多年的开发经历中，一直都喜欢研究解决程序中的一些瓶颈问题，早年喜欢游戏开发，照着《VGA编程》来做游戏图形，读 Michael Abrash 的《图形程序开发人员指南》做软渲染器，爱好摆弄一些能够榨干 CPU 能够运行更快的代码，参加工作后，兴趣转移到服务端和网络相关的技术。
> 
> 2007 年时做了几个传统游戏后开始研究快速动作游戏的同步问题，期间写过不少文章，算是国内比较早研究同步问题的人，然而发现不管怎么解决同步都需要在网络传输方面有所突破，后来离开游戏转行互联网后也发现不少领域有这方面的需求，于是开始花时间在网络传输这个领域上，尝试基于 UDP 实现一些保守的可靠协议，仿照 BSD Lite 4.4 的代码实现一些类 TCP 协议，觉得比较有意思，又接着实现一些 P2P 和动态路由网相关的玩具。KCP 协议诞生于 2011 年，基本算是自己传输方面做的几个玩具中的一个。
> 
> Kcptun 的作者 xtaci 是我的大学同学，我俩都是学通信的，经常在一起研究如何进行传输优化。
> 


