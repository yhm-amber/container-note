
## operator way

ref: https://ot-container-kit.github.io/redis-operator/  
ref: https://github.com/ot-container-kit/redis-operator  
ref: https://operatorhub.io/operator/redis-operator  

~~~ sh
helm repo add -- ot-helm https://ot-container-kit.github.io/helm-charts
~~~

## install operator

ref: https://ot-container-kit.github.io/redis-operator/guide/setup.html  
ref: https://ot-container-kit.github.io/redis-operator/guide/installation.html  

you may need :
- https://github.com/OT-CONTAINER-KIT/helm-charts.git
- https://github.com/OT-CONTAINER-KIT/helm-charts/releases/download/redis-operator-0.10.3/redis-operator-0.10.3.tgz

~~~ sh
mkdir -p -- ot-helm && (cd ot-helm && helm pull --untar -- ot-helm/redis-operator)
helm upgrade --install -n operators --create-namespace -- redis-operator ot-helm/redis-operator
~~~

outs:

~~~~ text
Release "redis-operator" does not exist. Installing it now.
NAME: redis-operator
LAST DEPLOYED: Thu Jun 23 11:32:37 2022
NAMESPACE: operators
STATUS: deployed
REVISION: 1
TEST SUITE: None
~~~~

## create cluster

ref: https://ot-container-kit.github.io/redis-operator/guide/redis-cluster-config.html  

you may need :
- https://github.com/OT-CONTAINER-KIT/helm-charts.git

~~~ sh
mkdir -p -- ot-helm && (cd ot-helm && helm pull --untar -- ot-helm/redis-cluster)
helm upgrade --set redisCluster.clusterSize=3 --install -n redis-yourns --create-namespace -- redis-cluster ot-helm/redis-cluster
~~~

outs:

~~~~ text
Release "redis-cluster" does not exist. Installing it now.
NAME: redis-cluster
LAST DEPLOYED: Thu Jun 23 11:47:41 2022
NAMESPACE: redis-yourns
STATUS: deployed
REVISION: 1
TEST SUITE: None
~~~~

check:

~~~ sh
watch 'kubectl get po -n redis-yourns'
~~~

~~~ sh
kubectl exec -it redis-cluster-leader-0 -n redis-yourns -- redis-cli -a Opstree@1234 cluster nodes
~~~


