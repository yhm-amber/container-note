[src/gh]: https://github.com/cloudflare/pingora.git "(Apache-2.0) (Languages: Rust 100.0%) A library for building fast, reliable and evolvable network services. // 用于构建快速、可靠和可发展的网络服务的库。 /// Feature highlights // 功能亮点 /// Async Rust: fast and reliable // - 异步 Rust：快速且可靠 /// - HTTP 1/2 end to end proxy // - HTTP 1/2 端到端代理 ///  - TLS over OpenSSL or BoringSSL // - 基于 OpenSSL 或 BoringSSL 的 TLS /// - gRPC and websocket proxying // - gRPC 和 websocket 代理 /// - Graceful reload // - 优雅的重载 /// - Customizable load balancing and failover strategies // - 可定制的负载平衡和故障转移策略 /// - Support for a variety of observability tools // - 支持多种观测工具"
[docs.rs]: https://docs.rs/pingora/latest/pingora/
[crates.io]: https://crates.io/crates/pingora "(27 KiB) (Apache-2.0) A framework to build fast, reliable and programmable networked systems at Internet scale."

[blog:pingora-open-source]: https://blog.cloudflare.com/pingora-open-source "Open sourcing Pingora: our Rust framework for building programmable network services // 开源 Pingora：我们用于构建可编程网络服务的 Rust 框架"
[blog:how-we-built-pingora]: https://blog.cloudflare.com/how-we-built-pingora-the-proxy-that-connects-cloudflare-to-the-internet/ "How we built Pingora, the proxy that connects Cloudflare to the Internet // 我们如何构建 Pingora ，一个将 Cloudflare 连接到互联网的代理"

[part:tinyufo.crates]: https://crates.io/crates/TinyUFO
[part:tinyufo.knowsby]: https://rustcc.cn/article?id=325542e0-9d74-47a5-ba3d-a5cb485b1b99 "TinyUFO - 无锁高性能缓存 /// TinyUFO 是 Cloudflare 开源的 Pingora 中的一个组件，结合了最先进的 S3-FIFO 算法，利用 TinyLFU 作为准入策略，相较于 LRU 和 Moka 在 zipf = 1 的情况下，提供了更高的命中率。 /// 此外，由于 TinyUFO 使用无锁数据结构，在性能上远远超过 Lru 和 Moka ，特别是在混合读写的工作负载下。"
