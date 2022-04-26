

## 快速开始

ref: https://rancher.com/docs/rancher/v2.6/en/quick-start-guide/deployment/quickstart-manual-setup/

### 证书管理器

基于链接中所述，要先部署 `cert-manager` 。

我不依据该连接中的方案，而是它的[官方手册](https://cert-manager.io/docs/installation)。

我基于官方手册做了一个[简单的整理](../cert-manager-note)，可以参考里面的命令。

### 本体

基于 ref 链接，接下来步骤就是用 `helm` 安装 Rancher 。

整理命令：

~~~ sh
helm install \
  --namespace cattle-system \
  --set hostname=<IP_OF_LINUX_NODE>.sslip.io \
  --set replicas=1 \
  --set bootstrapPassword=<PASSWORD_FOR_RANCHER_ADMIN> \
  -- rancher rancher-latest/rancher ;
~~~

上面的 `<PASSWORD_FOR_RANCHER_ADMIN>` 改成你登录 Rancher 的 `admin` 用户的密码。






----

(todo ...)
