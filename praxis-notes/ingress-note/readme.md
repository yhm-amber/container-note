

## kubernetes default nginx ingress

ref: https://kubernetes.github.io/ingress-nginx/deploy/

helm way :

~~~~ sh
helm upgrade --install --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace -- ingress-nginx ingress-nginx
~~~~

它会安装或升级现有的 `ingress-nginx` 应用到 `ingress-nginx` 命名空间，基于的是源 `https://kubernetes.github.io/ingress-nginx` 中的 `ingress-nginx` Chart 。

out:

~~~~
Release "ingress-nginx" does not exist. Installing it now.

~~~~


如果安装完毕，应该能在这个 NS 看到一些启动的 Pod ：

~~~ sh
kubectl get pods -n ingress-nginx
~~~



