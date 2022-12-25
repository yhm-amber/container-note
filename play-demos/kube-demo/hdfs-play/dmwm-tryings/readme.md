



~~~ sh
helm repo add -- dmwm-bigdata https://mehrwertmacher.github.io/bigdata-charts
~~~

### hdfs

#### simple

~~~~ sh
helm install -- hdfs dmwm-bigdata/hdfs
~~~~

stdout:

~~~~~
NAME: hdfs
LAST DEPLOYED: Mon Apr 25 10:27:25 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
1. You can check the status of HDFS by running this command:
   kubectl exec -n default -it hdfs-namenode-0 -- hdfs dfsadmin -report

2. Create a port-forward to the hdfs manager UI:
   kubectl port-forward -n default hdfs-namenode-0 9870:9870

   Then open the ui in your browser:

   open http://localhost:9870
~~~~~

#### using some options

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




### hbase

~~~~ sh
helm install -- hbase dmwm-bigdata/hbase
~~~~

stdout:

~~~~~
NAME: hbase
LAST DEPLOYED: Mon Apr 25 16:30:54 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
1. You can get an HBASE Shell by running this command:
   kubectl exec -n default -it hbase-hbase-master-0 -- hbase shell

2. Inspect hbase master service ports with:
   kubectl exec -n default describe service hbase-hbase-master

3. Create a port-forward to the hbase manager UI:
   kubectl port-forward -n default svc/hbase-hbase-master 16010:16010

   Then open the ui in your browser:

   open http://localhost:16010

4. Create a port-forward to the hbase thrift manager UI:
   kubectl port-forward -n default svc/hbase-hbase-master 9095:9095

   Then open the ui in your browser:

   open http://localhost:9095
~~~~~

### hive

~~~~ sh
helm install -- hive dmwm-bigdata/hive
~~~~

stdout:

~~~~~
NAME: hive
LAST DEPLOYED: Mon Apr 25 16:24:12 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
~~~~~
