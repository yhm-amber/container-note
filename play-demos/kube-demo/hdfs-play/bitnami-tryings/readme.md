

see also:

- `https://godatadriven.com/blog/spark-kubernetes-argo-helm/`
- `https://github.com/mykidong/hive-on-spark-in-kubernetes`
- 数据本地原则： `https://www.researchgate.net/publication/220423204_The_Locality_Principle`

### `bitnami/spark`

~~~~ bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install --create-namespace --namespace spark-bitnami -- spark-bitnami bitnami/spark
~~~~

out:

~~~~
NAME: spark-bitnami
LAST DEPLOYED: Tue Nov  9 14:32:28 2021
NAMESPACE: spark-bitnami
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: spark
CHART VERSION: 5.7.9
APP VERSION: 3.2.0

** Please be patient while the chart is being deployed **

1. Get the Spark master WebUI URL by running these commands:

  kubectl port-forward --namespace spark-bitnami svc/spark-bitnami-master-svc 80:80
  echo "Visit http://127.0.0.1:80 to use your application"

2. Submit an application to the cluster:

  To submit an application to the cluster the spark-submit script must be used. That script can be
  obtained at https://github.com/apache/spark/tree/master/bin. Also you can use kubectl run.

  export EXAMPLE_JAR=$(kubectl exec -ti --namespace spark-bitnami spark-bitnami-worker-0 -- find examples/jars/ -name 'spark-example*\.jar' | tr -d '\r')

  kubectl exec -ti --namespace spark-bitnami spark-bitnami-worker-0 -- spark-submit --master spark://spark-bitnami-master-svc:7077 \
    --class org.apache.spark.examples.SparkPi \
    $EXAMPLE_JAR 5

** IMPORTANT: When submit an application from outside the cluster service type should be set to the NodePort or LoadBalancer. **

** IMPORTANT: When submit an application the --master parameter should be set to the service IP, if not, the application will not resolve the master. **
~~~~







## hdfs


### `dmwm-bigdata/hdfs`

#### install

~~~~ bash
# hdfs 3.2.2
helm repo add -- dmwm-bigdata https://mehrwertmacher.github.io/bigdata-charts
helm repo update
helm install --create-namespace --namespace hdfs--dmwm-bigdata--ns --set persistence.dataNode.storageClass=local-hostpath --set persistence.nameNode.storageClass=local-hostpath -- hdfs--dmwm-bigdata--app dmwm-bigdata/hdfs
~~~~

out:

~~~~ stdout
NAME: hdfs--dmwm-bigdata--app
LAST DEPLOYED: Thu Nov 11 16:21:55 2021
NAMESPACE: hdfs--dmwm-bigdata--ns
STATUS: deployed
REVISION: 1
NOTES:
1. You can check the status of HDFS by running this command:
   kubectl exec -n hdfs--dmwm-bigdata--ns -it hdfs--dmwm-bigdata--app-namenode-0 -- hdfs dfsadmin -report

2. Create a port-forward to the hdfs manager UI:
   kubectl port-forward -n hdfs--dmwm-bigdata--ns hdfs--dmwm-bigdata--app-namenode-0 9870:9870

   Then open the ui in your browser:

   open http://localhost:9870
~~~~

#### check

~~~~ bash
kubectl get po -n hdfs--dmwm-bigdata--ns
~~~~

out:

~~~~ stdout
NAME                                              READY   STATUS    RESTARTS   AGE
hdfs--dmwm-bigdata--app-datanode-0                1/1     Running   1          4d19h
hdfs--dmwm-bigdata--app-datanode-1                1/1     Running   0          4d19h
hdfs--dmwm-bigdata--app-datanode-2                1/1     Running   0          4d19h
hdfs--dmwm-bigdata--app-httpfs-66b89b54dc-r7j2w   1/1     Running   0          4d19h
hdfs--dmwm-bigdata--app-namenode-0                2/2     Running   2          4d19h
~~~~

#### usage

上面输出信息有这样一段：

~~~
2. Create a port-forward to the hdfs manager UI:
   kubectl port-forward -n hdfs--dmwm-bigdata--ns hdfs--dmwm-bigdata--app-namenode-0 9870:9870

   Then open the ui in your browser:

   open http://localhost:9870
~~~

执行 `kubectl port-forward --help` 查看该 *子命令* 的使用帮助，其中有这样一段：

~~~
  # Listen on port 8888 on all addresses, forwarding to 5000 in the pod
  kubectl port-forward --address 0.0.0.0 pod/mypod 8888:5000

  # Listen on port 8888 on localhost and selected IP, forwarding to 5000 in the pod
  kubectl port-forward --address localhost,10.19.21.23 pod/mypod 8888:5000
~~~

根据这里的提示，可以像这样：

~~~ sh
kubectl port-forward --address 0.0.0.0 -n hdfs--dmwm-bigdata--ns -- hdfs--dmwm-bigdata--app-namenode-0 9870:9870
~~~

然后就能网页访问被执行节点的这个端口来检验了。


## hive

## flink

### `riskfocus/flink`

`https://artifacthub.io/packages/helm/riskfocus/flink`

#### install

~~~~ bash
# 1.11.2
helm repo add riskfocus https://riskfocus.github.io/helm-charts-public
helm repo update
helm install --create-namespace --namespace flink--riskfocus--ns \
        --set jobmanager.statefulset=true,jobmanager.persistent.enabled=true,jobmanager.persistent.storageClass=local-hostpath \
        --set taskmanager.statefulset=true,taskmanager.persistent.enabled=true,taskmanager.persistent.storageClass=local-hostpath \
        -- flink--riskfocus--app riskfocus/flink
        #--set zookeeper.enabled=true,jobmanager.replicaCount=2,jobmanager.highAvailability.enabled=true,jobmanager.highAvailability.storageDir=s3://MY_BUCKET/flink/jobmanager \
~~~~

out:

~~~~ stdout
NAME: flink--riskfocus--app
LAST DEPLOYED: Mon Nov 15 18:17:07 2021
NAMESPACE: flink--riskfocus--ns
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace flink--riskfocus--ns -l "app.kubernetes.io/name=flink,app.kubernetes.io/instance=flink--riskfocus--app" -o jsonpath="{.items[0].metadata.name}")
  echo "Visit http://127.0.0.1:8081 to use your application"
  kubectl port-forward $POD_NAME 8081:8081
~~~~

#### check

~~~~ bash
kubectl get pods -n flink--riskfocus--ns
~~~~

out:

~~~~ stdout
NAME                                  READY   STATUS              RESTARTS   AGE
flink--riskfocus--app-jobmanager-0    0/1     Running             0          11s
flink--riskfocus--app-taskmanager-0   0/1     ContainerCreating   0          11s
flink--riskfocus--app-taskmanager-1   1/1     Running             0          11s
flink--riskfocus--app-taskmanager-2   1/1     Running             0          11s
flink--riskfocus--app-taskmanager-3   1/1     Running             0          11s
~~~~

#### usage

~~~ sh
kubectl port-forward --address 0.0.0.0 -n flink--riskfocus--ns -- $(kubectl get pods --namespace flink--riskfocus--ns -l "app.kubernetes.io/name=flink,app.kubernetes.io/instance=flink--riskfocus--app" -o jsonpath="{.items[0].metadata.name}") 8081:8081
~~~

#### uninstall

~~~~ bash
# see name
helm ls -A
helm uninstall -n flink--riskfocus--ns -- flink--riskfocus--app
~~~~

## HBase

## Pravega

Link:

- `https://charts.pravega.io/`
- `https://github.com/pravega/charts`

### `pravega/pravega`




## ignite

`https://www.ignite-service.cn/doc/java/Installation.html`

`https://github.com/thredup/helm-ignite`

## hok

see:

- `https://github.com/hokstack/hok-helm`

### `hokstack/hokstack`

`https://artifacthub.io/packages/helm/hokstack/hokstack`

#### install

~~~~ bash
helm repo add -- hok https://charts.hokstack.io
helm repo update
helm install --namespace hokstack-ns --create-namespace \
        --set postgres.storageClassName=openebs-jiva-csi-sc \
        --set ambariserver.persistentVolume.storageClassName=openebs-jiva-csi-sc \
        --set masternode.persistentVolume.storageClassName=local-hostpath,datanode.persistentVolume.storageClassName=local-hostpath \
        --set edgenode.persistentVolume.storageClassName=local-hostpath \
        --set kdc.persistentVolume.storageClassName=openebs-jiva-csi-sc \
        -- hokstack-app hok/hokstack
~~~~






