





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

~~~~~


