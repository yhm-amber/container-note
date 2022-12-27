
[repo-instance]: https://github.com/risingwavelabs/risingwave.git
[docs-intro]: https://risingwave.dev/docs/current/intro/

## Intro

ref: [risingwave.dev/docs][docs-intro]

> RisingWave is an open-source cloud-native streaming database that uses SQL as the interface to manage and query data. It is designed to reduce the complexity and cost of building real-time applications. RisingWave consumes streaming data, performs incremental computations when new data come in, and updates results dynamically. As a database system, RisingWave maintains results in its own storage so that users can access data efficiently. You can sink data from RisingWave to an external stream for storage or additional processing.

## Simple

ref: [`risingwavelabs/risingwave`][repo-instance]

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

[repo-operator]: https://github.com/risingwavelabs/risingwave-operator.git
[repo-certmanager]: https://github.com/cert-manager/cert-manager.git

### need

1.  [Cert Manager][repo-certmanager] : 
    
    [Install](https://cert-manager.io/docs/installation) ([also see](../cert-manager-note))
    
2.  [Operator][repo-operator] : 
    
    ~~~ sh
    kubectl apply -f https://github.com/risingwavelabs/risingwave-operator/releases/latest/download/risingwave-operator.yaml
    ~~~
    
    检查：
    
    ~~~ sh
    kubectl -n cert-manager get pods
    kubectl -n risingwave-operator-system get pods
    ~~~
    
3.  [Instance][repo-instance] : 
    
    `etcd + MinIO`
    
    ~~~ sh
    kubectl apply -f https://raw.githubusercontent.com/risingwavelabs/risingwave-operator/main/examples/risingwave/risingwave-etcd-minio.yaml
    ~~~
    
    chk
    
    ~~~ sh
    kubectl get risingwave
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

[sql-101]: https://risingwave.dev/docs/current/risingwave-sql-101/

ref: [risingwave.dev/docs sql-101][sql-101]



