
[site-gh]: https://github.com/streamnative
[site]: https://streamnative.io
[docs]: https://docs.streamnative.io

[pulsar-site]: https://pulsar.apache.org
[bk-site]: https://bookkeeper.apache.org


## platform

ref: 

[docs-plat]: https://docs.streamnative.io/platform/latest/overview
[docs-plat-start]: https://docs.streamnative.io/platform/latest/quickstart

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


see also: 

- [pulsar note](../pulsar-note)
- [bookkeeper note](../bookkeeper-note)


### deploy cluster instance



need: 

- Kubectl (Command-Line or Other Interface)
- Helm (Command-Line or Other Interface)

[cert man](../cert-manager-note): 

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

repos: 

[repo-charts]: https://github.com/streamnative/charts.git
[repo-flink-operator]: https://github.com/streamnative/flink-operator.git
[repo-community-operators]: https://github.com/streamnative/community-operators.git
[repo-community-operators-prod]: https://github.com/streamnative/community-operators-prod.git
[repo-etcd-operator]: https://github.com/streamnative/etcd-operator.git
[repo-operator-lifecycle-manager]: https://github.com/streamnative/operator-lifecycle-manager.git

- [`streamnative/charts`][repo-charts]:   
  > StreamNative Helm Charts Repository: Apache Pulsar, Pulsar Operators, StreamNative Platform, Function Mesh  
- [`streamnative/flink-operator`][repo-flink-operator]:   
  > Kubernetes operator for managing the lifecycle of Apache Flink and Beam applications.  
- [`streamnative/community-operators`][repo-community-operators]:   
  > The canonical source for Kubernetes Operators that are published on OperatorHub.io and part of the default catalog of the Operator Lifecycle Manager.  
- [`streamnative/community-operators-prod`][repo-community-operators-prod]:   
  > community-operators metadata backing OpenShift OperatorHub  
- [`streamnative/etcd-operator`][repo-etcd-operator]:   
  > Fork of etcd-operator for SN Cloud  
- [`streamnative/operator-lifecycle-manager`][repo-operator-lifecycle-manager]:   
  > A management framework for extending Kubernetes with Operators  

### work with instance

- `pulsarctl` : create tenants, namespaces, and topics.
- `client` : create producers and consumers to simulate a simple production and consumption model.

#### pulsarctl

[repo-pulsarctl]: https://github.com/streamnative/pulsarctl.git
[repo-pulsar-resources-operator]: https://github.com/streamnative/pulsar-resources-operator.git

need: 

- [pulsarctl][repo-pulsarctl]

> pulsarctl is a Command-Line Interface (CLI) tool for Pulsar. In this section, you can use the `pulsarctl` CLI tool to create tenants, namespaces, and topics.
> 
> pulsarctl 是 Pulsar 的一个命令行界面（CLI）工具。在本节中，你可以使用 pulsarctl CLI 来创建租户、命名空间和主题。
> 

simple use case: 

~~~ sh
: Log into pulsarctl and create a tenant.
pulsarctl --admin-service-url <WEB_SERVICE_URL> --token <AUTH_PARAMS> tenants create <tenant_name>

: Create a namespace.
pulsarctl namespaces create <namespace_name> -c <cluster_name>

: Create a topic.
pulsarctl topics create <topic_name>

: List all the topics.
pulsarctl topics list <namespace_name>
~~~

[docs-connect]: https://docs.streamnative.io/platform/latest/user-guides/connect/connect-pulsar-cluster/connect-prepare

- 有关 `WEB_SERVICE_URL` 和 `AUTH_PARAMS` 的详情见 [Prepare to connect to a Pulsar cluster][docs-connect]

see also: 

- [pulsar resources operator][repo-pulsar-resources-operator]

> The Pulsar Resources Operator is a controller that manages the Pulsar resources automatically using the manifest on Kubernetes. Therefore, you can manage the Pulsar resources without the help of `pulsar-admin` or `pulsarctl` CLI tool. It is useful for initializing basic resources when creating a new Pulsar cluster.
> 
> Pulsar 资源 Operator 是一个控制器，它使用 Kubernetes 上的清单自动管理 Pulsar 资源。因此，你可以在没有 `pulsar-admin` 或 `pulsarctl` CLI 工具的帮助下管理 Pulsar 资源。在创建一个新的 Pulsar 集群时，它对初始化基本资源很有用。
> 

#### client


> StreamNative Platform supports all the official Pulsar clients. You can use the pulsar-client CLI tool to create producers and consumers to simulate a simple production and consumption model.
> 
> StreamNative Platform 支持所有的 official Pulsar 客户端。你可以使用 pulsar-client CLI 工具来创建生产者和消费者，以模拟一个简单的生产和消费模型。
> 

simple client: 

> To facilitate the usage of the official Pulsar CLI tools, such as pulsar-client, StreamNative Platform provides a `toolset` Pod, which you can use to the `kubectl exec` command to connect to, to directly use the official Pulsar CLI tools.
> 
> 为了方便使用官方的 Pulsar CLI 工具，如 pulsar-client ， StreamNative Platform 提供了一个工具集 (`toolset`) Pod ，你可以用它与 kubectl exec 命令连接它，从而直接使用官方的 Pulsar CLI 工具。
> 

~~~ sh
: just connect
kubectl exec <release_name>-sn-platform-toolset-0 -n <k8s_namespace> -i -t -- bash

: connect with Create a consumer.
kubectl exec <release_name>-sn-platform-toolset-0 -n <k8s_namespace> -- pulsar-client consume -s <subscription_name> -n 0 -- <TOPIC_NAME>

: connect with Create a producer.
kubectl exec <release_name>-sn-platform-toolset-0 -n <k8s_namespace> -- pulsar-client produce -m ":: hello streamnative platform ::" -n 4 -- <TOPIC_NAME>
~~~

- 对于这里的 `producer` ，看到这个说明创建成功了：
  
  ~~~ text
  23:04:25.652 [main] INFO  org.apache.pulsar.client.cli.PulsarClientTool - 10 messages successfully produced
  ~~~
  
  同时会在该 Topic 的 `consumer` 处看到这样的消息：
  
  ~~~ txt
  ----- got message -----
  :: hello streamnative platform ::
  ----- got message -----
  :: hello streamnative platform ::
  ----- got message -----
  :: hello streamnative platform ::
  ----- got message -----
  :: hello streamnative platform ::
  ~~~
  
- 如需令 `producer` 从标准输入获取信息，则 `kubectl exec` 需增用 `-i` 选项。
  
  如需令 `producer` 从交互式输入获取信息，则 `kubectl exec` 需增用 `-i` 和 `-t` 选项。
  
- 用 `just connect` 的方式连接该工具集 Pod 后，就可以在交互式的 `bash` 界面直接使用 `pulsar-client` 命令了。

more see: 

- [quick start][docs-plat-start]

repos: 

[repo-pulsar-rs]: https://github.com/streamnative/pulsar-rs.git
[repo-pulsar-client-node]: https://github.com/streamnative/pulsar-client-node.git
[repo-pulsar-client-cpp]: https://github.com/streamnative/pulsar-client-cpp.git
[repo-pulsar-client-go]: https://github.com/streamnative/pulsar-client-go.git
[repo-pulsar-dotpulsar]: https://github.com/streamnative/pulsar-dotpulsar.git
[repo-pulsar-tracing]: https://github.com/streamnative/pulsar-tracing.git
[repo-pulsar-recipes]: https://github.com/streamnative/pulsar-recipes.git

- [`streamnative/pulsar-rs`][repo-pulsar-rs]:   
  > Rust Client library for Apache Pulsar  
- [`streamnative/pulsar-client-node`][repo-pulsar-client-node]:   
  > Apache Pulsar NodeJS Client  
- [`streamnative/pulsar-client-cpp`][repo-pulsar-client-cpp]:   
  > Apache Pulsar C++ client library  
- [`streamnative/pulsar-client-go`][repo-pulsar-client-go]:   
  > Apache Pulsar Go Client Library  
- [`streamnative/pulsar-dotpulsar`][repo-pulsar-dotpulsar]:   
  > The official .NET client library for Apache Pulsar  
- [`streamnative/pulsar-tracing`][repo-pulsar-tracing]:   
  > Tracing instrumentation for Apache Pulsar clients.  
- [`streamnative/pulsar-recipes`][repo-pulsar-recipes]:   
  > A StreamNative library containing a collection of recipes that are implemented on top of the Pulsar client to provide higher-level functionality closer to the application domain.  





