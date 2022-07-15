
ref: https://github.com/debezium/debezium/blob/main/README_ZH.md  

> Debezium 是一个开源项目，为捕获数据更改 (change data capture,CDC) 提供了一个低延迟的流式处理平台。你可以安装并且配置 Debezium 去监控你的数据库，然后你的应用就可以消费对数据库的每一个行级别 (row-level) 的更改。只有已提交的更改才是可见的，所以你的应用不用担心事务 (transaction) 或者更改被回滚 (roll back) 。 Debezium 为所有的数据库更改事件提供了一个统一的模型，所以你的应用不用担心每一种数据库管理系统的错综复杂性。另外，由于 Debezium 用持久化的、有副本备份的日志来记录数据库数据变化的历史，因此，你的应用可以随时停止再重启，而不会错过它停止运行时发生的事件，保证了所有的事件都能被正确地、完全地处理掉。
> 
> 监控数据库，并且在数据变动的时候获得通知一直是很复杂的事情。关系型数据库的触发器可以做到，但是只对特定的数据库有效，而且通常只能更新数据库内的状态 (无法和外部的进程通信) 。一些数据库提供了监控数据变动的 API 或者框架，但是没有一个标准，每种数据库的实现方式都是不同的，并且需要大量特定的知识和理解特定的代码才能运用。确保以相同的顺序查看和处理所有更改，同时最小化影响数据库仍然非常具有挑战性。
> 
>  Debezium 提供了模块为你做这些复杂的工作。一些模块是通用的，并且能够适用多种数据库管理系统，但在功能和性能方面仍有一些限制。另一些模块是为特定的数据库管理系统定制的，所以他们通常可以更多地利用数据库系统本身的特性来提供更多功能。
> 

## install

第一个参考里是第三方实现的 operator ；第二个参考里是目前的正式步骤，但是很罗嗦；第三个是这个软件的中文介绍。

### 官方的步骤

ref: https://debezium.io/documentation/reference/stable/operations/kubernetes.html

我是一步一步来的，但是在创建 `debezium-cluster` 的时候得到了这样的报错：

~~~
error: unable to recognize "debezium-cluster.yaml": no matches for kind "Kafka" in version "kafka.strimzi.io/v1beta2"
~~~

<details>

<summary>这是我使用的资源定义</summary>

~~~ yaml
apiVersion: kafka.strimzi.io/v1beta2
kind: Kafka
metadata:
  name: debezium-cluster
spec:
  kafka:
    replicas: 1
    listeners:
      - name: plain
        port: 9092
        type: internal
        tls: false
      - name: tls
        port: 9093
        type: internal
        tls: true
        authentication:
          type: tls
      - name: external
        port: 9094
        type: nodeport
        tls: false
    storage:
      type: jbod
      volumes:
      - id: 0
        type: persistent-claim
        size: 100Gi
        deleteClaim: false
    config:
      offsets.topic.replication.factor: 1
      transaction.state.log.replication.factor: 1
      transaction.state.log.min.isr: 1
      default.replication.factor: 1
      min.insync.replicas: 1
  zookeeper:
    replicas: 1
    storage:
      type: persistent-claim
      size: 100Gi
      deleteClaim: false
  entityOperator:
    topicOperator: {}
    userOperator: {}
~~~

</details>

我认为，要么是官方文档完全是个过期的文档，要么它本身就没写对。

### `Alfusainey/debezium-server-operator`

根据 [`Alfusainey/debezium-server-operator`](https://github.com/Alfusainey/debezium-server-operator.git) 页面的[简介处链接](https://debezium.io/documentation/reference/1.6/operations/debezium-server.html)可知，目前它的版本是 `1.6` ，而[最新版](https://debezium.io/documentation/reference/stable/operations/debezium-server.html)目前是 `1.9` 。

这个很简单，就是应用几个资源定义。我先编辑了一下，主要是 mysql 的地址等，还有命名空间，它里面写的是 default 。

很糟糕的是，这个 `DebeziumServer` 类型的资源并不会创建 `Service` ，这就导致我需要从别处的攻略弄到默认的监听端口（ `8083` ），太不像话了。。。

我认为比较合适的方式应当还是类似于 Elasticsearch 的 helm 库那样。可以分不同组件，但是都能在一个源里呈现出来。

另外，这个 ref-1 里也并不包括 [`debezium-ui`](https://debezium.io/documentation/reference/stable/operations/debezium-ui.html) 组件。。。。。








