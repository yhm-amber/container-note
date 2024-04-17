[src/gh]: https://github.com/quickwit-oss/tantivy.git "(MIT) (Languages: Rust 100.0%) Tantivy is a full-text search engine library inspired by Apache Lucene and written in Rust // Tantivy 是一个全文搜索引擎库，受 Apache Lucene 启发并用 Rust 编写 /// (Jaeger Native)"
[crates]: https://crates.io/crates/tantivy "(: cargo add -- tantivy)"

[quickwit.src/gh]: https://github.com/quickwit-oss/quickwit.git "(AGPL-3.0) (Languages: Rust 96.3%, TypeScript 1.6%, Python 0.7%, HCL 0.4%, JavaScript 0.3%, Shell 0.3%, Other 0.4%) Cloud-native search engine for observability. An open-source alternative to Datadog, Elasticsearch, Loki, and Tempo. // 具备可观察性的云原生搜索引擎。 Datadog、Elasticsearch、Loki 和 Tempo 的开源替代品。"
[quickwit.site]: https://quickwit.io/ "Search more / with less /// Sub-second search & analytics engine on cloud storage // 搜更多 / 用更少 /// 云存储上亚秒级别的搜索和分析引擎"
[quickwit.bookademo]: https://meetings.hubspot.com/francois84
[quickwit.docs]: https://quickwit.io/docs/
[quickwit.tutorials]: https://quickwit.io/tutorials

[quickwit.blog]: https://quickwit.io/blog/
[quickwit.commoncrawl/blog]: https://quickwit.io/blog/commoncrawl/
[quickwit.commoncrawl.demo]: https://common-crawl.quickwit.io/

[quickwit.docs:helm]: https://quickwit.io/docs/deployment/kubernetes/helm "(: helm repo add -- quickwit https://helm.quickwit.io) (: helm show values -- quickwit/quickwit) (: helm install <deployment name> quickwit/quickwit -f values.yaml)"

[quickwit.docs:jaeger]: https://quickwit.io/docs/distributed-tracing/plug-quickwit-to-jaeger "(: QW_ENABLE_OPENTELEMETRY_OTLP_EXPORTER=true OTEL_EXPORTER_OTLP_ENDPOINT=http://127.0.0.1:7281 ./quickwit run) (: docker run --rm --name jaeger-qw -e SPAN_STORAGE_TYPE=grpc-plugin -e GRPC_STORAGE_SERVER=host.docker.internal:7281 -p 16686:16686 -- jaegertracing/jaeger-query:latest ;: change 'host.docker.internal' to '127.0.0.1' at linux)"
