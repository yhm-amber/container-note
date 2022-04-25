





## 0

~~~ sh
helm repo add openebs https://openebs.github.io/charts
helm repo update
helm install openebs --namespace openebs openebs/openebs --create-namespace
~~~

## 1

~~~ sh
helm repo add dmwm-bigdata https://mehrwertmacher.github.io/bigdata-charts
~~~

## 2

### hdfs

~~~~ sh
helm install hdfs dmwm-bigdata/hdfs
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

### hbase

~~~~ sh
helm install hbase dmwm-bigdata/hbase
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
helm install hive dmwm-bigdata/hive
~~~~

stdout:

~~~~~
NAME: hive
LAST DEPLOYED: Mon Apr 25 16:24:12 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
~~~~~
