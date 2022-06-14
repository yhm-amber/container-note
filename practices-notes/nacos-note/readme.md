ref: https://github.com/nacos-group/nacos-k8s/blob/master/operator/README-CN.md

先部署 operator 得到 CRD  `Nacos` 这个类型（ `Kind` ），然后用 CRD 创建 `Nacos` 类型的实例。

operator :

~~~ sh
: get chart
git pull https://github.com/nacos-group/nacos-k8s
cd operator/chart/nacos-operator

: install
helm install -n operators --create-namespace -- nacos-operator .
~~~

nacos resource define like this :

~~~ yaml
apiVersion: nacos.io/v1alpha1
kind: Nacos
metadata:
  name: nacos-cluster
  namespace: nacos
spec:
  type: cluster
  image: nacos/nacos-server:1.4.1
  replicas: 3
  
  database:
    type: embedded
  
  volume:
    # 启动数据卷，不然重启后数据丢失
    enabled: true
    requests:
      storage: 1Gi
    storageClass: default
~~~

or like this :

~~~ yaml
apiVersion: nacos.io/v1alpha1
kind: Nacos
metadata:
  name: nacos-cluster
  namespace: nacos
spec:
  type: cluster
  image: nacos/nacos-server:1.4.1
  replicas: 3
  
  database:
    type: mysql
    mysqlHost: mysql-leader.meta-db.svc.cluster.local
    mysqlDb: nacos
    mysqlUser: nacos
    mysqlPort: "3306"
    mysqlPassword: "P@88w0rd--nacos"
~~~



