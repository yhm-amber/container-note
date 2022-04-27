
## 快速开始

ref: https://kubesphere.io/zh/docs/quick-start/minimal-kubesphere-on-k8s/

这个是最小安装

### 安装

~~~ sh
kubectl apply -f https://github.com/kubesphere/ks-installer/releases/download/v3.2.1/kubesphere-installer.yaml
kubectl apply -f https://github.com/kubesphere/ks-installer/releases/download/v3.2.1/cluster-configuration.yaml
~~~

### 检查

~~~ sh
kubectl logs -n kubesphere-system $(kubectl get pod -n kubesphere-system -l app=ks-install -o jsonpath='{.items[0].metadata.name}') -f
~~~
