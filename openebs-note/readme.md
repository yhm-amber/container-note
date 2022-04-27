
## 安装

ref: https://openebs.io/docs/user-guishang es/quickstart


### use `helm`

~~~ sh
helm repo add openebs https://openebs.github.io/charts
# helm repo update
helm install --namespace openebs --create-namespace -- openebs openebs/openebs
~~~

### use `kubectl`

~~~ sh
kubectl apply -f https://openebs.github.io/charts/openebs-operator.yaml
~~~

## 配置默认

需要配置存储类 `openebs-hostpath` 为默认。

ref: https://kubernetes.io/zh/docs/tasks/administer-cluster/change-default-storage-class/

设为默认：

~~~ sh
kubectl patch storageclass openebs-hostpath -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
~~~

验证：

~~~ sh
kubectl get storageclass
~~~

可以看到在 `openebs-hostpath` 后面有 `(default)` 就是成了。

*上面的 `storageclass` 可简写为 `sc` 。*
