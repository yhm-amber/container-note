
[src:instance/gh]: https://github.com/risingwavelabs/risingwave.git "(Apache-2.0) (Languages: Rust 92.1%, Java 3.4%, Python 1.9%, Shell 1.0%, TypeScript 0.7%, JavaScript 0.5%, Other 0.4%) The distributed streaming database: SQL stream processing with Postgres-like experience 🪄. 10X faster and more cost-efficient than Apache Flink 🚀. // 分布式流数据库：具有类似 Postgres 体验的 SQL 流处理 🪄 。比 Apache Flink 🚀 快 10 倍且更具成本效益。"

[docs:intro]: https://risingwave.dev/docs/current/intro/
[docs:vs-flink]: https://www.risingwave.dev/docs/current/risingwave-flink-comparison/

[app/site]: https://www.risingwave.cloud/ ""
[play/site]: https://playground.risingwave.dev/ "RisingWave Playground is intended for quick testing purposes only. Your data will not persist after a session expires. Some functionality may be limited. // RisingWave Playground 仅用于快速测试目的。会话过期后，您的数据将不会保留。某些功能可能会受到限制。"

## Intro

ref: [What is RisingWave ?][docs:intro]

> RisingWave is an open-source cloud-native streaming database that uses SQL as the interface to manage and query data. It is designed to reduce the complexity and cost of building real-time applications. RisingWave consumes streaming data, performs incremental computations when new data come in, and updates results dynamically. As a database system, RisingWave maintains results in its own storage so that users can access data efficiently. You can sink data from RisingWave to an external stream for storage or additional processing.
> 
> > > > ----
> 
> RisingWave 是一个用于流处理的分布式 SQL 数据库。它旨在降低构建实时应用程序的复杂性和成本。 RisingWave 消耗流数据，在新数据进入时执行增量计算，并动态更新结果。作为一个数据库系统，RisingWave 将结果维护在自己的存储中，以便用户可以有效地访问数据。
> 

> Both Apache Flink and RisingWave are stream processing systems. However, RisingWave is more than just a modern alternative to Flink.
> 
> If you are looking for a simple, cost-efficient, SQL-based solution for real-time data processing, RisingWave is an excellent choice. RisingWave is designed to be easy to use and can be deployed quickly. This makes it an ideal option for fast-growing businesses that require real-time data processing capabilities.
> 
> > > > ----
> 
> Apache Flink 和 RisingWave 都是流处理系统。然而，RisingWave 不仅仅是 Flink 的现代替代品。
>
> 如果您正在寻找一种简单、经济高效、基于 SQL 的实时数据处理解决方案，RisingWave 是一个绝佳的选择。 RisingWave 的设计易于使用且可快速部署。这使其成为需要实时数据处理能力的快速增长企业的理想选择。
> 

ref: [RisingWave vs. Flink][docs:vs-flink]

> *Apache Flink adopts a big-data style, coupled-compute-storage architecture that is optimized for scalability; RisingWave in contrast implements a cloud-native, decoupled compute-storage architecture that is optimized for cost efficiency.*
> 
> As an open-source project born during the Hadoop-dominant big-data era, the architecture of Flink was heavily influenced by the MapReduce paradigm. Specifically, Flink achieves parallel and distributed execution by dividing a streaming task into multiple parallel instances, each processing a subset of the task's input data. While this compute-storage-coupled architecture enables Flink to achieve high parallelism and scalability, it can also result in high execution costs.
> 
> RisingWave was created during the cloud era. By adopting a modern compute-storage-decoupled architecture, RisingWave achieves better scalability and flexibility. Each component can be configured differently and scaled independently, leading to improved cost-efficiency and performance. The new architecture also allows each component to be optimized separately, reducing resource waste and avoiding task overload.
> 
> > > > ----
> 
> *Apache Flink 采用大数据风格、计算存储耦合架构，针对可扩展性进行了优化；相比之下，RisingWave 实现了云原生、解耦的计算存储架构，该架构针对成本效率进行了优化。*
> 
> 作为诞生于 Hadoop 主导的大数据时代的开源项目，Flink 的架构深受 MapReduce 范式的影响。具体来说，Flink 通过将流任务划分为多个并行实例来实现并行和分布式执行，每个并行实例处理任务输入数据的子集。虽然这种计算-存储耦合的架构使 Flink 能够实现高并行性和可扩展性，但也会导致较高的执行成本。
> 
> RisingWave 是在云时代创建的。通过采用现代计算存储解耦架构，RisingWave 实现了更好的可扩展性和灵活性。每个组件都可以进行不同的配置并独立扩展，从而提高成本效率和性能。新架构还允许单独优化每个组件，减少资源浪费并避免任务过载。
> 

> *To achieve the target performance, Apache Flink is at a higher cost due to its heavy architectural design; On the other hand, RisingWave is much more cost-efficient with its disaggregated architecture.*
> 
> Apache Flink is designed for high-performance and low-latency processing of large-scale data in real-time. However, its compute-storage-coupled architecture can require a significant amount of computational resources. Shortages in either computation or storage capacity can lead to system bottlenecks. Additionally, the JVM runtime used by Apache Flink can introduce significant overhead in terms of memory consumption.
> 
> In contrast, RisingWave focuses on low-cost stream processing on the cloud and, in most cases, achieves better cost efficiency than Apache Flink. Several factors contribute to the cost efficiency of RisingWave.
> 
> 1. RisingWave adopts a compute-storage-decoupled architecture that allows the system to dynamically provision resources for different components based on the workloads.
> 2. As a streaming database, RisingWave implements the concept of materialized views, which provides users with opportunities to reuse computation resources across different stream processing pipelines by maintaining and sharing intermediate computation results.
> 3. RisingWave’s Rust-based implementation achieves high performance with minimal overhead in computation and memory usage.
> 
> > > > ----
> 
> *Apache Flink 由于架构设计繁重，要达到目标性能，成本较高；另一方面， RisingWave 因其分散的架构而更具成本效益。*
> 
> Apache Flink 专为高性能、低延迟的大规模数据实时处理而设计。然而，其计算-存储耦合架构可能需要大量的计算资源。计算或存储容量的短缺可能会导致系统瓶颈。此外，Apache Flink 使用的 JVM 运行时可能会在内存消耗方面带来显着的开销。
> 
> 相比之下， RisingWave 专注于云端的低成本流处理，在大多数情况下比 Apache Flink 实现了更好的成本效率。有几个因素有助于提高 RisingWave 的成本效率。
> 
> 1. RisingWave 采用计算-存储解耦的架构，允许系统根据工作负载为不同组件动态配置资源。
> 2. 作为一个流数据库， RisingWave 实现了物化视图的概念，通过维护和共享中间计算结果，为用户提供了跨不同流处理管道重用计算资源的机会。*（注：意思就是不用像 Flink 那样需要你给配上一层物化视图了从而也能很好地即席查询了就。但它牛逼就牛逼在这个内置物化视图的概念相当于 FP 的 *memoize* 了。）*
> 3. RisingWave 基于 Rust 的实现以最小的计算和内存使用开销实现了高性能。
> 




## Simple

ref: [`risingwavelabs/risingwave`][src:instance/gh]

> Use Docker (Linux, macOS)
> 
> ~~~ sh
> # Start RisingWave in single-binary playground mode
> docker run -it --pull=always -p 4566:4566 -p 5691:5691 ghcr.io/risingwavelabs/risingwave:v0.1.13 playground
> ~~~
> 

> To connect to the RisingWave server, you will need to install PostgreSQL shell (psql) in advance.
> 
> ~~~ sh
> # Use psql to connect RisingWave cluster
> psql -h localhost -p 4566 -d dev -U root
> ~~~
> 
> ~~~ sql
> /* create a table */
> create table t1(v1 int);
> 
> /* create a materialized view based on the previous table */
> create materialized view mv1 as select sum(v1) as sum_v1 from t1;
> 
> /* insert some data into the source table */
> insert into t1 values (1), (2), (3);
> 
> /* (optional) ensure the materialized view has been updated */
> flush;
> 
> /* the materialized view should reflect the changes in source table */
> select * from mv1;
> ~~~
> 
> If everything works correctly, you should see
> 
> ~~~
>  sum_v1
> --------
>       6
> (1 row)
> ~~~
> 
> in the terminal.
> 

ref:

- https://www.risingwave.dev/docs/current/risingwave-local
- https://www.risingwave.dev/docs/current/risingwave-docker-image
- https://www.risingwave.dev/docs/current/risingwave-kubernetes

## Kubernetes

[src:operator/gh]: https://github.com/risingwavelabs/risingwave-operator.git
[certmanager.src/gh]: https://github.com/cert-manager/cert-manager.git

### need

1.  [Cert Manager][certmanager.src/gh] : 
    
    [Install](https://cert-manager.io/docs/installation) ([also see](../cert-manager-note))
    
2.  [Operator][src:operator/gh] : 
    
    ~~~ sh
    kubectl apply --server-side -f https://github.com/risingwavelabs/risingwave-operator/releases/latest/download/risingwave-operator.yaml
    ~~~
    
    检查：
    
    ~~~ sh
    kubectl -n cert-manager get pods
    kubectl -n risingwave-operator-system get pods
    ~~~
    

### [Instance][src:instance/gh]

`etcd+s3`: 

~~~ sh
kubectl create secret generic s3-credentials --from-literal AccessKeyID=${ACCESS_KEY} --from-literal SecretAccessKey=${SECRET_ACCESS_KEY}
kubectl apply -f https://raw.githubusercontent.com/risingwavelabs/risingwave-operator/main/docs/manifests/stable/persistent/s3/risingwave.yaml
kubectl get risingwave
~~~

`risingwave.yaml`: 

~~~ yaml
---
apiVersion: v1
kind: Service
metadata:
  name: etcd
  labels:
    app: etcd
spec:
  clusterIP: None
  ports:
  - port: 2388
    name: client
  - port: 2389
    name: peer
  selector:
    app: etcd
...

---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: etcd
  labels:
    app: etcd
spec:
  replicas: 1
  selector:
    matchLabels:
      app: etcd
  serviceName: etcd
  volumeClaimTemplates:
  - metadata:
      name: etcd-data
    spec:
      accessModes: [ "ReadWriteOnce" ]
      resources:
        requests:
          storage: 10Gi
  persistentVolumeClaimRetentionPolicy:
    whenDeleted: Delete
    whenScaled: Retain
  template:
    metadata:
      labels:
        app: etcd
    spec:
      containers:
      - name: etcd
        image: quay.io/coreos/etcd:latest
        imagePullPolicy: IfNotPresent
        command:
        - /usr/local/bin/etcd
        args:
        - --listen-client-urls
        - http://0.0.0.0:2388
        - --advertise-client-urls
        - http://etcd-0:2388
        - --listen-peer-urls
        - http://0.0.0.0:2389
        - --initial-advertise-peer-urls
        - http://etcd-0:2389
        - --listen-metrics-urls
        - http://0.0.0.0:2379
        - --name
        - etcd
        - --max-txn-ops
        - "999999"
        - --auto-compaction-mode
        - periodic
        - --auto-compaction-retention
        - 1m
        - --snapshot-count
        - "10000"
        - --data-dir
        - /var/lib/etcd
        - --max-request-byte
        - "104857600"
        - --quota-backend-bytes
        - "8589934592"
        env:
        - name: ALLOW_NONE_AUTHENTICATION
          value: "1"
        ports:
        - containerPort: 2389
          name: peer
          protocol: TCP
        - containerPort: 2388
          name: client
          protocol: TCP
        volumeMounts:
        - mountPath: /var/lib/etcd
          name: etcd-data
...

---
apiVersion: risingwave.risingwavelabs.com/v1alpha1
kind: RisingWave
metadata:
  name: risingwave
spec:
  image: ghcr.io/risingwavelabs/risingwave:v1.0.0
  metaStore:
    etcd:
      endpoint: etcd:2388
  stateStore:
    dataDirectory: hummock001
    s3:
      bucket: risingwave
      region: us-east-1
      credentials:
        secretName: s3-credentials
  components:
    meta:
      nodeGroups:
      - replicas: 1
        name: ''
    compactor:
      nodeGroups:
      - replicas: 1
        name: ''
    frontend:
      nodeGroups:
      - replicas: 1
        name: ''
    compute:
      nodeGroups:
      - replicas: 1
        name: ''
...
~~~

### connect

#### ClusterIP

need to play with kubectl :

~~~ sh
kubectl apply -f https://raw.githubusercontent.com/risingwavelabs/risingwave-operator/main/examples/psql/psql-console.yaml
kubectl exec psql-console -it -- psql -h risingwave-etcd-minio-frontend -p 4567 -d dev -U root
~~~

#### NodePort

Set `risingwave` instance's `spec.global.serviceType` as `NodePort` , then e.g. :

~~~ sh
rw_name=risingwave-etcd-minio &&
rw_ns=default &&
rw_host="$( kubectl -n ${rw_ns} get node -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}' )" &&
rw_port="$( kubectl -n ${rw_ns} get svc -l risingwave/name=${rw_name},risingwave/component=frontend -o jsonpath='{.items[0].spec.ports[0].nodePort}' )" &&

psql -h ${rw_host} -p ${rw_port} -d dev -U root
~~~

#### LoadBalancer

Set `risingwave` instance's `spec.global.serviceType` as `LoadBalancer` , then e.g. :

~~~ sh
rw_name=risingwave-etcd-minio &&
rw_ns=default &&
rw_host="$( kubectl -n ${rw_ns} get svc -l risingwave/name=${rw_name},risingwave/component=frontend -o jsonpath='{.items[0].status.loadBalancer.ingress[0].ip}' )" &&
rw_port="$( kubectl -n ${rw_ns} get svc -l risingwave/name=${rw_name},risingwave/component=frontend -o jsonpath='{.items[0].spec.ports[0].port}' )" &&

psql -h ${rw_host} -p ${rw_port} -d dev -U root
~~~

## Use

[docs:sql-101]: https://risingwave.dev/docs/current/risingwave-sql-101/

ref: [sql 101 | risingwave.dev/docs][docs:sql-101]



