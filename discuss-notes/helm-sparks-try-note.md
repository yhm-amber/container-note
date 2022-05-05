
# nostate

## spark

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



# state

## openebs

### self

`https://openebs.github.io/charts/`

#### install

~~~~ bash
helm repo add -- openebs https://openebs.github.io/charts
helm repo update
helm install --namespace openebs-ns --create-namespace --set cstor.enabled=true -- openebs-app openebs/openebs
~~~~

out:

~~~~ stdout
~~~~

or:

~~~~ bash
kubectl apply -f https://openebs.github.io/charts/openebs-operator.yaml
~~~~

#### check

see sth:

~~~~ bash
helm ls -n openebs-ns
kubectl get sc
kubectl get pods -n openebs-ns -o wide
~~~~

#### uninstall

~~~~ bash
helm delete -n openebs-ns -- openebs-app
~~~~

### sealer

#### `localpv-operator.yaml`

~~~~ yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: openebs
...
---
# Create Maya Service Account
apiVersion: v1
kind: ServiceAccount
metadata:
  name: openebs-maya-operator
  namespace: openebs
...
---
# Define Role that allows operations on K8s pods/deployments
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: openebs-maya-operator
rules:
  - apiGroups: [ "*" ]
    resources: [ "nodes", "nodes/proxy" ]
    verbs: [ "*" ]
  - apiGroups: [ "*" ]
    resources: [ "namespaces", "services", "pods", "deployments", "events", "endpoints", "configmaps", "jobs" ]
    verbs: [ "*" ]
  - apiGroups: [ "*" ]
    resources: [ "storageclasses", "persistentvolumeclaims", "persistentvolumes" ]
    verbs: [ "*" ]
...
---
# Bind the Service Account with the Role Privileges.
# TODO: Check if default account also needs to be there
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: openebs-maya-operator
subjects:
  - kind: ServiceAccount
    name: openebs-maya-operator
    namespace: openebs
roleRef:
  kind: ClusterRole
  name: openebs-maya-operator
  apiGroup: rbac.authorization.k8s.io
...
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: openebs-localpv-provisioner
  namespace: openebs
  labels:
    name: openebs-localpv-provisioner
    openebs.io/component-name: openebs-localpv-provisioner
    openebs.io/version: 2.11.0
spec:
  selector:
    matchLabels:
      name: openebs-localpv-provisioner
      openebs.io/component-name: openebs-localpv-provisioner
  replicas: 1
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        name: openebs-localpv-provisioner
        openebs.io/component-name: openebs-localpv-provisioner
        openebs.io/version: 2.11.0
    spec:
      serviceAccountName: openebs-maya-operator
      containers:
        - name: openebs-provisioner-hostpath
          imagePullPolicy: IfNotPresent
          image: openebs/provisioner-localpv:2.11.1
          env:
            # OPENEBS_IO_K8S_MASTER enables openebs provisioner to connect to K8s
            # based on this address. This is ignored if empty.
            # This is supported for openebs provisioner version 0.5.2 onwards
            #- name: OPENEBS_IO_K8S_MASTER
            #  value: "http://10.128.0.12:8080"
            # OPENEBS_IO_KUBE_CONFIG enables openebs provisioner to connect to K8s
            # based on this config. This is ignored if empty.
            # This is supported for openebs provisioner version 0.5.2 onwards
            #- name: OPENEBS_IO_KUBE_CONFIG
            #  value: "/home/ubuntu/.kube/config"
            - name: NODE_NAME
              valueFrom:
                fieldRef:
                  fieldPath: spec.nodeName
            - name: OPENEBS_NAMESPACE
              valueFrom:
                fieldRef:
                  fieldPath: metadata.namespace
            # OPENEBS_SERVICE_ACCOUNT provides the service account of this pod as
            # environment variable
            - name: OPENEBS_SERVICE_ACCOUNT
              valueFrom:
                fieldRef:
                  fieldPath: spec.serviceAccountName
            - name: OPENEBS_IO_ENABLE_ANALYTICS
              value: "true"
            - name: OPENEBS_IO_INSTALLER_TYPE
              value: "openebs-operator-hostpath"
            - name: OPENEBS_IO_HELPER_IMAGE
              value: "openebs/linux-utils:2.11.0"
          # LEADER_ELECTION_ENABLED is used to enable/disable leader election. By default
          # leader election is enabled.
          #- name: LEADER_ELECTION_ENABLED
          #  value: "true"
          # OPENEBS_IO_IMAGE_PULL_SECRETS environment variable is used to pass the image pull secrets
          # to the helper pod launched by local-pv hostpath provisioner
          #- name: OPENEBS_IO_IMAGE_PULL_SECRETS
          #  value: ""
          # Process name used for matching is limited to the 15 characters
          # present in the pgrep output.
          # So fullname can't be used here with pgrep (>15 chars).A regular expression
          # that matches the entire command name has to specified.
          # Anchor `^` : matches any string that starts with `provisioner-loc`
          # `.*`: matches any string that has `provisioner-loc` followed by zero or more char
          livenessProbe:
            exec:
              command:
                - sh
                - -c
                - test `pgrep -c "^provisioner-loc.*"` = 1
            initialDelaySeconds: 30
            periodSeconds: 60
...
---
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: local-hostpath
  annotations:
    openebs.io/cas-type: local
    cas.openebs.io/config: |
      - name: StorageType
        value: hostpath
      - name: BasePath
        value: /var/local-hostpath
provisioner: openebs.io/local
reclaimPolicy: Delete
volumeBindingMode: WaitForFirstConsumer
...
~~~~


## hdfs

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

## Pravega

Link:

- `https://charts.pravega.io/`
- `https://github.com/pravega/charts`

### `pravega/pravega`



## OpenVPN

### `aniskhan001/openvpn-internet`

`https://github.com/aniskhan001/openvpn-helm-chart`

#### install

~~~~ bash
helm repo add -- aniskhan001 https://raw.githubusercontent.com/aniskhan001/openvpn-helm-chart/master
helm repo update
helm install --namespace openvpn--aniskhan001--ns --create-namespace --set persistence.storageClass=local-hostpath -- openvpn--aniskhan001--app aniskhan001/openvpn-internet
~~~~

out:

~~~~ stdout

~~~~

### `stenic/openvpn-as`

`https://artifacthub.io/packages/helm/stenic/openvpn-as`

#### install

#### check

#### uninstall

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






