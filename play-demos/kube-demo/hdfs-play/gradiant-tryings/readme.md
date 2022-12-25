### `gradiant-bigdata/hdfs`

#### install

~~~~ bash
# hdfs 2.7.7
helm repo add -- gradiant-bigdata https://gradiant.github.io/bigdata-charts
helm repo update
helm install --create-namespace --namespace hdfs--gradiant-bigdata--ns --set persistence.dataNode.storageClass=local-hostpath --set persistence.nameNode.storageClass=local-hostpath -- hdfs--gradiant-bigdata--app gradiant-bigdata/hdfs
~~~~

out:

~~~~ stdout
NAME: hdfs--gradiant-bigdata--app
LAST DEPLOYED: Thu Nov 11 16:19:07 2021
NAMESPACE: hdfs--gradiant-bigdata--ns
STATUS: deployed
REVISION: 1
NOTES:
1. You can check the status of HDFS by running this command:
   kubectl exec -n hdfs--gradiant-bigdata--ns -it hdfs--gradiant-bigdata--app-namenode-0 -- hdfs dfsadmin -report

2. Create a port-forward to the hdfs manager UI:
   kubectl port-forward -n hdfs--gradiant-bigdata--ns hdfs--gradiant-bigdata--app-namenode-0 50070:50070

   Then open the ui in your browser:

   open http://localhost:50070
~~~~

#### check

~~~~ bash
kubectl get po -n hdfs--gradiant-bigdata--ns
~~~~

out:

~~~~ stdout
NAME                                                  READY   STATUS    RESTARTS   AGE
hdfs--gradiant-bigdata--app-datanode-0                1/1     Running   0          4d19h
hdfs--gradiant-bigdata--app-datanode-1                1/1     Running   0          4d19h
hdfs--gradiant-bigdata--app-datanode-2                1/1     Running   0          4d19h
hdfs--gradiant-bigdata--app-httpfs-5cd867b486-rms54   1/1     Running   0          4d19h
hdfs--gradiant-bigdata--app-namenode-0                2/2     Running   2          4d19h
~~~~

#### usage

上面输出信息有这样一段：

~~~
2. Create a port-forward to the hdfs manager UI:
   kubectl port-forward -n hdfs--gradiant-bigdata--ns hdfs--gradiant-bigdata--app-namenode-0 50070:50070

   Then open the ui in your browser:

   open http://localhost:50070
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
kubectl port-forward --address 0.0.0.0 -n hdfs--gradiant-bigdata--ns -- hdfs--gradiant-bigdata--app-namenode-0 50070:50070
~~~

然后就能网页访问被执行节点的这个端口来检验了。


#### uninstall

~~~~ bash
# see name
helm ls -A
helm uninstall -n hdfs--gradiant-bigdata--ns -- hdfs--gradiant-bigdata--app
~~~~

more see: `helm uninstall --help`





### `gradiant-bigdata/hive`

#### install

##### metastore:

~~~~ bash
# 2.3.6
helm repo add gradiant-bigdata https://gradiant.github.io/bigdata-charts
helm repo update
helm install --create-namespace --namespace hive-metastore--gradiant-bigdata--ns -- hive-metastore--gradiant-bigdata--app gradiant-bigdata/hive-metastore
~~~~

out:

~~~~ stdout
NAME: hive-metastore--gradiant-bigdata--app
LAST DEPLOYED: Fri Nov 12 15:58:09 2021
NAMESPACE: hive-metastore--gradiant-bigdata--ns
STATUS: deployed
REVISION: 1
TEST SUITE: None
~~~~

##### hive:

~~~~ bash
# 2.3.6
helm repo add gradiant-bigdata https://gradiant.github.io/bigdata-charts
helm repo update
helm install --create-namespace --namespace hive--gradiant-bigdata--ns -- hive--gradiant-bigdata--app gradiant-bigdata/hive
~~~~

out:

~~~~ stdout
NAME: hive--gradiant-bigdata--app
LAST DEPLOYED: Fri Nov 12 16:04:50 2021
NAMESPACE: hive--gradiant-bigdata--ns
STATUS: deployed
REVISION: 1
~~~~

#### check

~~~~ bash
kubectl get po -n hive--gradiant-bigdata--ns
~~~~

out:

~~~~ stdout
NAME                                                       READY   STATUS    RESTARTS   AGE
hive--gradiant-bigdata--app-hdfs-datanode-0                1/1     Running   1          118s
hive--gradiant-bigdata--app-hdfs-datanode-1                1/1     Running   0          59s
hive--gradiant-bigdata--app-hdfs-datanode-2                1/1     Running   0          33s
hive--gradiant-bigdata--app-hdfs-httpfs-7b459cfb7b-kfmss   1/1     Running   0          118s
hive--gradiant-bigdata--app-hdfs-namenode-0                2/2     Running   2          118s
hive--gradiant-bigdata--app-metastore-0                    1/1     Running   0          118s
hive--gradiant-bigdata--app-postgresql-0                   0/1     Pending   0          118s
hive--gradiant-bigdata--app-server-0                       0/1     Running   0          118s
~~~~


### `gradiant-bigdata/hbase`

`https://artifacthub.io/packages/helm/gradiant-bigdata/hbase`

#### insrtall

~~~~ bash
# 2.0.1
helm repo add -- gradiant-bigdata https://gradiant.github.io/bigdata-charts
helm repo update
helm install --namespace hbase--gradiant-bigdata--ns --create-namespace -- hbase--gradiant-bigdata--app gradiant-bigdata/hbase
~~~~

out:

~~~~ stdout
NAME: hbase--gradiant-bigdata--app
LAST DEPLOYED: Tue Nov 16 11:37:10 2021
NAMESPACE: hbase--gradiant-bigdata--ns
STATUS: deployed
REVISION: 1
NOTES:
1. You can get an HBASE Shell by running this command:
   kubectl exec -n hbase--gradiant-bigdata--ns -it hbase--gradiant-bigdata--app-hbase-master-0 -- hbase shell

2. Inspect hbase master service ports with:
   kubectl exec -n hbase--gradiant-bigdata--ns describe service hbase--gradiant-bigdata--app-hbase-master

3. Create a port-forward to the hbase manager UI:
   kubectl port-forward -n hbase--gradiant-bigdata--ns svc/hbase--gradiant-bigdata--app-hbase-master 16010:16010

   Then open the ui in your browser:

   open http://localhost:16010

4. Create a port-forward to the hbase thrift manager UI:
   kubectl port-forward -n hbase--gradiant-bigdata--ns svc/hbase--gradiant-bigdata--app-hbase-master 9095:9095

   Then open the ui in your browser:

   open http://localhost:9095
~~~~

#### check

~~~~ bash
kubectl get pods -n hbase--gradiant-bigdata--ns
~~~~

out:

~~~~ stdout
NAME                                                        READY   STATUS            RESTARTS   AGE
hbase--gradiant-bigdata--app-hbase-master-0                 0/1     PodInitializing   0          60s
hbase--gradiant-bigdata--app-hbase-regionserver-0           0/1     PodInitializing   0          60s
hbase--gradiant-bigdata--app-hdfs-datanode-0                1/1     Running           0          60s
hbase--gradiant-bigdata--app-hdfs-datanode-1                0/1     Running           0          16s
hbase--gradiant-bigdata--app-hdfs-httpfs-6747cf5996-8b4rj   1/1     Running           0          60s
hbase--gradiant-bigdata--app-hdfs-namenode-0                2/2     Running           2          60s
hbase--gradiant-bigdata--app-zookeeper-0                    0/1     Pending           0          60s
~~~~


