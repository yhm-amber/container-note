
[site-gh]: https://github.com/streamnative
[site]: https://streamnative.io
[docs]: https://docs.streamnative.io

[pulsar-site]: https://pulsar.apache.org
[bk-site]: https://bookkeeper.apache.org


## platform

[docs-plat]: https://docs.streamnative.io/platform/latest/overview
[docs-plat-start]: https://docs.streamnative.io/platform/latest/quickstart

ref:

- [Overview | StreamNative Documentation][docs-plat]
- [Get Started | StreamNative Documentation][docs-plat-start]

### intro

> StreamNative Platform is a cloud-native messaging and event-streaming platform that enables you to build a real-time application and data infrastructure for both real-time and historical events.
>  Founded by the original developers of [Apache Pulsar][pulsar-site] and Apache [BookKeeper][bk-site], [StreamNative][site] offers a complete, self-managed platform for continuously streaming data across your organization to power rich customer experiences and data-driven operations.
>  You can deploy StreamNative Platform on-premise or in-cloud.
> 
> StreamNative 平台是一个云原生消息和事件流平台，使你能够为实时和历史事件建立一个实时应用程序和数据基础设施。 StreamNative 由 Apache Pulsar 和 Apache BookKeeper 的原始开发者创建，它提供了一个完整的、自我管理的平台，用于在你的组织中持续流转数据，以促进丰富的客户体验和数据驱动的运营。你可以在内部或云中部署 StreamNative 平台。
> 
> Powered by Apache Pulsar, StreamNative Platform makes it easy to build mission-critical messaging and streaming applications and real-time data pipelines by integrating data from multiple sources into a single, central messaging and event streaming platform for your company. StreamNative Platform lets you focus on how to maximize business value from real-time data rather than worrying about the underlying mechanisms such as how data is messaged between various systems and how data is stored reliably for processing.
> 
> 在 Apache Pulsar 的支持下， StreamNative 平台通过将多个来源的数据整合到一个单一的中央消息和事件流平台，使你可以轻松地建立关键任务的消息和流应用以及实时数据管线。 StreamNative 平台让你专注于如何从实时数据中获得最大的商业价值，而不是担心底层机制，如数据如何在各个系统之间传递消息，以及如何可靠地存储数据以便处理。
> 




### deploy

> following tasks:
> 
> - Install the StreamNative Platform on Kubernetes using operators.
> - Start and stop StreamNative Platform.
> - Create tenants, namespaces, and topics using the pulsarctl CLI tool.
> - Produce and consume events using pulsar-client.
> - Produce and consume events using Kafka client.
> - Verify interoperability between Pulsar and Kafka.
> - Monitor StreamNative Platform status with Prometheus and Grafana.
> 

cert man: 

~~~ sh
helm repo add -- jetstack https://charts.jetstack.io
helm upgrade --install -n <k8s_namespace> --set installCRDs=true -- cert-manager jetstack/cert-manager
~~~

repo add: 

~~~ sh
helm repo add -- streamnative https://charts.streamnative.io
helm repo add -- banzaicloud-stable https://kubernetes-charts.banzaicloud.com
helm repo add -- function-mesh http://charts.functionmesh.io/
helm repo update
~~~

operators create: 

~~~ sh
helm upgrade --install -n <k8s_namespace> -- vault-operator banzaicloud-stable/vault-operator
helm upgrade --install -n <k8s_namespace> -- pulsar-operator streamnative/pulsar-operator
helm upgrade --install -n <k8s_namespace> -- function-mesh-operator function-mesh/function-mesh-operator
~~~

cluster instance: 

~~~ sh
helm install --set initialize=true -n <namespace> -- <release_name> streamnative/sn-platform
~~~

