
## operator way

ref: https://github.com/nacos-group/nacos-k8s/blob/master/operator/README-CN.md

先部署 operator 得到 CRD  `Nacos` 这个类型（ `Kind` ），然后用 CRD 创建 `Nacos` 类型的实例。

operator :

~~~ sh
: get chart
git pull -- https://github.com/nacos-group/nacos-k8s nacos-group/nacos-k8s && cd nacos-group/nacos-k8s

: install
helm install -n operators --create-namespace -- nacos-operator ./operator/chart/nacos-operator
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
  # image: nacos/nacos-server:1.4.1
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
  # image: nacos/nacos-server:1.4.1
  replicas: 3
  
  database:
    type: mysql
    mysqlHost: mysql-leader.meta-db.svc.cluster.local
    mysqlDb: nacos
    mysqlUser: nacos
    mysqlPort: "3306"
    mysqlPassword: "P@88w0rd--nacos"
~~~

## helm way

ref: https://github.com/nacos-group/nacos-k8s/tree/master/helm#configuration

need values:

~~~ properties
nacos.image.repository=nacos/nacos-server
nacos.env.serverPort=8848

service.type=NodePort
service.port=8848
service.nodePort=31790

global.mode=cluster
nacos.replicaCount=3

ingress.enabled=false

nacos.plugin.enable=true
nacos.plugin.image.repository=nacos/nacos-peer-finder-plugin

nacos.storage.type=mysql
nacos.storage.db.host=mysql-leader.meta-db.svc.cluster.local
nacos.storage.db.port=3306
nacos.storage.db.name=nacos
nacos.storage.db.username=nacos
nacos.storage.db.password=P@88w0rd--nacos
~~~

use :

~~~ sh
echo properties | xargs -i -- printf %s, {}
~~~

and add out string to `--set` flag :

~~~ sh
: get chart
git pull -- https://github.com/nacos-group/nacos-k8s nacos-group/nacos-k8s && cd nacos-group/nacos-k8s

: install
helm install -n nacos-yourns --create-namespace --set $(
    
    echo '
        
        nacos.image.repository=nacos/nacos-server
        nacos.env.serverPort=8848
        
        service.type=NodePort
        service.port=8848
        service.nodePort=30848
        
        global.mode=cluster
        nacos.replicaCount=3
        
        ingress.enabled=false
        
        nacos.plugin.enable=true
        nacos.plugin.image.repository=nacos/nacos-peer-finder-plugin
        
        nacos.storage.type=mysql
        nacos.storage.db.host=mysql-leader.meta-db.svc.cluster.local
        nacos.storage.db.port=3306
        nacos.storage.db.name=nacos
        nacos.storage.db.username=nacos
        nacos.storage.db.password=P@88w0rd--nacos
        
        ' | xargs -i -- printf %s, {} | xargs -d, | tr ' ' , &&
    : ) -- nacos-cluster ./helm
~~~

out:

~~~~ text
NAME: nacos-cluster
LAST DEPLOYED: Wed Jun 22 14:33:57 2022
NAMESPACE: nacos-yourns
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
1. Get the application URL by running these commands:
  export NODE_PORT=$(kubectl get --namespace nacos-yourns -o jsonpath="{.spec.ports[0].nodePort}" services  nacos-cs)
  export NODE_IP=$(kubectl get nodes --namespace nacos-yourns -o jsonpath="{.items[0].status.addresses[0].address}")
  echo http://$NODE_IP:$NODE_PORT/nacos
2. MODE:
   standalone: you need to modify replicaCount in the values.yaml, .Values.replicaCount=1
   cluster: kubectl scale sts nacos-yourns-nacos --replicas=3
~~~~


