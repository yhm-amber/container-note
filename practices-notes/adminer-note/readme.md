
这是个数据库客户端。

这是它的发布网站： [`adminer.org`](https://adminer.org/) 。

这是它的镜像存储库： [`docker.io/library/adminer`](https://hub.docker.com/_/adminer/) 。

## 直接创建实例

这是个简单的直接用镜像创建实例的部署方式。

我按照存储库里说明的指示去运行：

~~~~ sh
docker run -d --name adminer --net host -- adminer
~~~~

但是不能用，看 `logs` 是这样：

~~~~ text
[Mon Aug  1 02:03:40 2022] PHP 7.4.30 Development Server (http://[::]:8080) started
[Mon Aug  1 02:03:46 2022] [::ffff:172.21.52.228]:59115 Accepted
[Mon Aug  1 02:03:46 2022] [::ffff:172.21.52.228]:59115 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:46 2022] [::ffff:172.21.52.228]:59115 Closing
[Mon Aug  1 02:03:46 2022] [::ffff:172.21.52.228]:59116 Accepted
[Mon Aug  1 02:03:46 2022] [::ffff:172.21.52.228]:59116 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:46 2022] [::ffff:172.21.52.228]:59116 Closing
[Mon Aug  1 02:03:47 2022] [::ffff:172.21.52.228]:59118 Accepted
[Mon Aug  1 02:03:47 2022] [::ffff:172.21.52.228]:59118 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:47 2022] [::ffff:172.21.52.228]:59118 Closing
[Mon Aug  1 02:03:47 2022] [::ffff:172.21.52.228]:59119 Accepted
[Mon Aug  1 02:03:47 2022] [::ffff:172.21.52.228]:59119 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:47 2022] [::ffff:172.21.52.228]:59119 Closing
[Mon Aug  1 02:03:48 2022] [::ffff:172.21.52.228]:59120 Accepted
[Mon Aug  1 02:03:48 2022] [::ffff:172.21.52.228]:59120 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:48 2022] [::ffff:172.21.52.228]:59120 Closing
[Mon Aug  1 02:03:48 2022] [::ffff:172.21.52.228]:59121 Accepted
[Mon Aug  1 02:03:48 2022] [::ffff:172.21.52.228]:59121 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:48 2022] [::ffff:172.21.52.228]:59121 Closing
[Mon Aug  1 02:03:49 2022] [::ffff:172.21.52.228]:59122 Accepted
[Mon Aug  1 02:03:49 2022] [::ffff:172.21.52.228]:59122 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:49 2022] [::ffff:172.21.52.228]:59122 Closing
[Mon Aug  1 02:03:49 2022] [::ffff:172.21.52.228]:59123 Accepted
[Mon Aug  1 02:03:49 2022] [::ffff:172.21.52.228]:59123 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:49 2022] [::ffff:172.21.52.228]:59123 Closing
[Mon Aug  1 02:03:49 2022] [::ffff:172.21.52.228]:59124 Accepted
[Mon Aug  1 02:03:49 2022] [::ffff:172.21.52.228]:59124 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:49 2022] [::ffff:172.21.52.228]:59124 Closing
[Mon Aug  1 02:03:49 2022] [::ffff:172.21.52.228]:59125 Accepted
[Mon Aug  1 02:03:49 2022] [::ffff:172.21.52.228]:59125 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:49 2022] [::ffff:172.21.52.228]:59125 Closing
[Mon Aug  1 02:03:49 2022] [::ffff:172.21.52.228]:59126 Accepted
[Mon Aug  1 02:03:49 2022] [::ffff:172.21.52.228]:59126 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:49 2022] [::ffff:172.21.52.228]:59126 Closing
[Mon Aug  1 02:03:49 2022] [::ffff:172.21.52.228]:59127 Accepted
[Mon Aug  1 02:03:49 2022] [::ffff:172.21.52.228]:59127 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:49 2022] [::ffff:172.21.52.228]:59127 Closing
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59128 Accepted
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59128 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59128 Closing
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59129 Accepted
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59129 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59129 Closing
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59130 Accepted
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59130 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59130 Closing
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59131 Accepted
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59131 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59131 Closing
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59132 Accepted
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59132 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59132 Closing
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59133 Accepted
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59133 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59133 Closing
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59134 Accepted
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59134 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59134 Closing
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59135 Accepted
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59135 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59135 Closing
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59136 Accepted
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59136 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59136 Closing
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59137 Accepted
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59137 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59137 Closing
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59138 Accepted
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59138 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59138 Closing
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59139 Accepted
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59139 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:50 2022] [::ffff:172.21.52.228]:59139 Closing
[Mon Aug  1 02:03:51 2022] [::ffff:172.21.52.228]:59140 Accepted
[Mon Aug  1 02:03:51 2022] [::ffff:172.21.52.228]:59140 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:51 2022] [::ffff:172.21.52.228]:59140 Closing
[Mon Aug  1 02:03:51 2022] [::ffff:172.21.52.228]:59141 Accepted
[Mon Aug  1 02:03:51 2022] [::ffff:172.21.52.228]:59141 Invalid request (Unsupported SSL request)
[Mon Aug  1 02:03:51 2022] [::ffff:172.21.52.228]:59141 Closing
~~~~

但是在 Kubernetes 上就没这个问题：

~~~ sh
kubectl create ns adminer-play --dry-run=client -o yaml | kubectl apply -f-
kubectl create deploy adminer --dry-run=client -o yaml --port 8080 --image adminer -n adminer-play | kubectl apply -f-
~~~

这样就可以启动。

想看 `yaml` 格式的资源定义就删掉上面各行后面的 ` | kubectl apply -f-` 来执行。

启动后日志只有一行：

~~~~ text
[Mon Aug  1 10:16:55 2022] PHP 7.4.27 Development Server (http://[::]:8080) started
~~~~

看着能用。

加个 `NodePort` 的访问：

~~~ sh
kubectl create svc nodeport adminer --dry-run=client -o yaml --tcp=8080:8080 -n adminer-play | kubectl apply -f-
~~~

这样就可以发布这个负载为服务。

想看 `yaml` 格式的资源定义就删掉上面这行后面的 ` | kubectl apply -f-` 来执行。

然后用 `kubectl get svc adminer -n adminer-play` 查看应该使用什么 `nodeport` ，比如我的输出是这样：

~~~ text
NAME      TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
adminer   NodePort   10.103.97.199   <none>        8080:30275/TCP   49m
~~~

那么我就要用节点 IP 加上 `30275` 这个 PORT 来访问。

我可以成功访问。

简单地连了一些网络里可访问的现成的数据库看了看，容器日志又**追加**了这些：

~~~~ text
[Mon Aug  1 10:19:35 2022] [::ffff:100.76.152.192]:53099 Accepted
[Mon Aug  1 10:19:35 2022] [::ffff:100.76.152.192]:53099 [200]: GET /
[Mon Aug  1 10:19:35 2022] [::ffff:100.76.152.192]:53099 Closing
[Mon Aug  1 10:19:35 2022] [::ffff:100.76.152.192]:7737 Accepted
[Mon Aug  1 10:19:35 2022] [::ffff:100.76.152.192]:7559 Accepted
[Mon Aug  1 10:19:35 2022] [::ffff:100.76.152.192]:7559 [200]: GET /?file=functions.js&version=4.8.1
[Mon Aug  1 10:19:35 2022] [::ffff:100.76.152.192]:7559 Closing
[Mon Aug  1 10:19:35 2022] [::ffff:100.76.152.192]:7737 [200]: GET /?file=default.css&version=4.8.1
[Mon Aug  1 10:19:35 2022] [::ffff:100.76.152.192]:7737 Closing
[Mon Aug  1 10:19:37 2022] [::ffff:100.76.152.192]:22071 Accepted
[Mon Aug  1 10:19:37 2022] [::ffff:100.76.152.192]:9517 Accepted
[Mon Aug  1 10:19:37 2022] [::ffff:100.76.152.192]:22071 [200]: GET /?file=favicon.ico&version=4.8.1
[Mon Aug  1 10:19:37 2022] [::ffff:100.76.152.192]:22071 Closing
[Mon Aug  1 10:19:37 2022] [::ffff:100.76.152.192]:9517 [200]: POST /?script=version
[Mon Aug  1 10:19:37 2022] [::ffff:100.76.152.192]:9517 Closing
[Mon Aug  1 10:22:52 2022] [::ffff:100.76.152.192]:19981 Accepted
[Mon Aug  1 10:22:52 2022] [::ffff:100.76.152.192]:19981 [302]: POST /
[Mon Aug  1 10:22:52 2022] [::ffff:100.76.152.192]:19981 Closing
[Mon Aug  1 10:22:52 2022] [::ffff:100.76.152.192]:1185 Accepted
[Mon Aug  1 10:22:52 2022] [::ffff:100.76.152.192]:1185 [200]: GET /?server=mysql-leader.mysql-bdp%3A3306&username=dev&db=auth_center
[Mon Aug  1 10:22:52 2022] [::ffff:100.76.152.192]:1185 Closing
[Mon Aug  1 10:22:52 2022] [::ffff:100.76.152.192]:32573 Accepted
[Mon Aug  1 10:22:52 2022] [::ffff:100.76.152.192]:36229 Accepted
[Mon Aug  1 10:22:52 2022] [::ffff:100.76.152.192]:36229 [200]: GET /?server=mysql-leader.mysql-bdp%3A3306&username=dev&db=auth_center&script=db
[Mon Aug  1 10:22:52 2022] [::ffff:100.76.152.192]:36229 Closing
[Mon Aug  1 10:22:52 2022] [::ffff:100.76.152.192]:32573 [200]: GET /?file=jush.js&version=4.8.1
[Mon Aug  1 10:22:52 2022] [::ffff:100.76.152.192]:32573 Closing
[Mon Aug  1 10:23:23 2022] [::ffff:100.76.152.192]:64846 Accepted
[Mon Aug  1 10:23:23 2022] [::ffff:100.76.152.192]:64846 [302]: POST /
[Mon Aug  1 10:23:23 2022] [::ffff:100.76.152.192]:64846 Closing
[Mon Aug  1 10:23:23 2022] [::ffff:100.76.152.192]:9648 Accepted
[Mon Aug  1 10:23:23 2022] [::ffff:100.76.152.192]:9648 [200]: GET /?server=mysql-leader.mysql-bdp%3A3306&username=dev&db=auth_center
[Mon Aug  1 10:23:23 2022] [::ffff:100.76.152.192]:9648 Closing
[Mon Aug  1 10:23:23 2022] [::ffff:100.76.152.192]:21953 Accepted
[Mon Aug  1 10:23:23 2022] [::ffff:100.76.152.192]:21953 [200]: GET /?server=mysql-leader.mysql-bdp%3A3306&username=dev&db=auth_center&script=db
[Mon Aug  1 10:23:23 2022] [::ffff:100.76.152.192]:21953 Closing
[Mon Aug  1 10:24:02 2022] [::ffff:100.76.152.192]:34285 Accepted
[Mon Aug  1 10:24:02 2022] [::ffff:100.76.152.192]:35246 Accepted
[Mon Aug  1 10:24:02 2022] [::ffff:100.76.152.192]:34285 [200]: GET /
[Mon Aug  1 10:24:02 2022] [::ffff:100.76.152.192]:34285 Closing
[Mon Aug  1 10:24:02 2022] [::ffff:100.76.152.192]:35246 [200]: GET /?file=default.css&version=4.8.1
[Mon Aug  1 10:24:02 2022] [::ffff:100.76.152.192]:35246 Closing
[Mon Aug  1 10:24:02 2022] [::ffff:100.76.152.192]:2235 Accepted
[Mon Aug  1 10:24:03 2022] [::ffff:100.76.152.192]:2235 [200]: GET /?file=functions.js&version=4.8.1
[Mon Aug  1 10:24:03 2022] [::ffff:100.76.152.192]:2235 Closing
[Mon Aug  1 10:24:03 2022] [::ffff:100.76.152.192]:48213 Accepted
[Mon Aug  1 10:24:03 2022] [::ffff:100.76.152.192]:48213 [200]: GET /?file=favicon.ico&version=4.8.1
[Mon Aug  1 10:24:03 2022] [::ffff:100.76.152.192]:48213 Closing
[Mon Aug  1 10:24:40 2022] [::ffff:100.76.152.192]:63334 Accepted
[Mon Aug  1 10:24:40 2022] [::ffff:100.76.152.192]:13870 Accepted
[Mon Aug  1 10:24:40 2022] [::ffff:100.76.152.192]:63334 [302]: POST /
[Mon Aug  1 10:24:40 2022] [::ffff:100.76.152.192]:63334 Closing
[Mon Aug  1 10:24:40 2022] [::ffff:100.76.152.192]:13870 [404]: GET /?server=mysql-leader.mysql-bdp%3A3306&username=dev&db=auth-center
[Mon Aug  1 10:24:40 2022] [::ffff:100.76.152.192]:13870 Closing
[Mon Aug  1 10:24:40 2022] [::ffff:100.76.152.192]:4829 Accepted
[Mon Aug  1 10:24:40 2022] [::ffff:100.76.152.192]:4829 [200]: GET /?file=jush.js&version=4.8.1
[Mon Aug  1 10:24:40 2022] [::ffff:100.76.152.192]:4829 Closing
[Mon Aug  1 10:24:49 2022] [::ffff:100.76.152.192]:36723 Accepted
[Mon Aug  1 10:24:49 2022] [::ffff:100.76.152.192]:36723 [200]: GET /?server=mysql-leader.mysql-bdp%3A3306&username=dev&db=auth_center
[Mon Aug  1 10:24:49 2022] [::ffff:100.76.152.192]:36723 Closing
[Mon Aug  1 10:24:49 2022] [::ffff:100.76.152.192]:27218 Accepted
[Mon Aug  1 10:24:49 2022] [::ffff:100.76.152.192]:27218 [200]: GET /?server=mysql-leader.mysql-bdp%3A3306&username=dev&db=auth_center&script=db
[Mon Aug  1 10:24:49 2022] [::ffff:100.76.152.192]:27218 Closing
[Mon Aug  1 10:24:55 2022] [::ffff:100.76.152.192]:25413 Accepted
[Mon Aug  1 10:24:55 2022] [::ffff:100.76.152.192]:59226 Accepted
[Mon Aug  1 10:24:55 2022] [::ffff:100.76.152.192]:25413 [200]: GET /?server=mysql-leader.mysql-bdp%3A3306&username=dev&db=auth_center&table=sys_group
[Mon Aug  1 10:24:55 2022] [::ffff:100.76.152.192]:25413 Closing
[Mon Aug  1 10:25:00 2022] [::ffff:100.76.152.192]:59226 [200]: GET /?server=mysql-leader.mysql-bdp%3A3306&username=dev&db=auth_center&select=sys_group
[Mon Aug  1 10:25:00 2022] [::ffff:100.76.152.192]:59226 Closing
[Mon Aug  1 10:25:00 2022] [::ffff:100.76.152.192]:59136 Accepted
[Mon Aug  1 10:25:04 2022] [::ffff:100.76.152.192]:59136 [200]: GET /?server=mysql-leader.mysql-bdp%3A3306&username=dev&db=auth_center&table=flyway_schema_history
[Mon Aug  1 10:25:04 2022] [::ffff:100.76.152.192]:59136 Closing
[Mon Aug  1 10:25:04 2022] [::ffff:100.76.152.192]:42430 Accepted
[Mon Aug  1 10:25:06 2022] [::ffff:100.76.152.192]:42430 [200]: GET /?server=mysql-leader.mysql-bdp%3A3306&username=dev&db=auth_center&select=flyway_schema_history
[Mon Aug  1 10:25:06 2022] [::ffff:100.76.152.192]:42430 Closing
[Mon Aug  1 10:25:06 2022] [::ffff:100.76.152.192]:41708 Accepted
[Mon Aug  1 10:25:09 2022] [::ffff:100.76.152.192]:41708 [200]: GET /?server=mysql-leader.mysql-bdp%3A3306&username=dev&db=auth_center&table=sys_user
[Mon Aug  1 10:25:09 2022] [::ffff:100.76.152.192]:41708 Closing
[Mon Aug  1 10:25:09 2022] [::ffff:100.76.152.192]:39385 Accepted
[Mon Aug  1 10:25:11 2022] [::ffff:100.76.152.192]:39385 [200]: GET /?server=mysql-leader.mysql-bdp%3A3306&username=dev&db=auth_center&select=sys_user
[Mon Aug  1 10:25:11 2022] [::ffff:100.76.152.192]:39385 Closing
[Mon Aug  1 10:25:11 2022] [::ffff:100.76.152.192]:48744 Accepted
[Mon Aug  1 10:26:58 2022] [::ffff:100.76.152.192]:54893 Accepted
[Mon Aug  1 10:26:58 2022] [::ffff:100.76.152.192]:54893 [200]: GET /
[Mon Aug  1 10:26:58 2022] [::ffff:100.76.152.192]:54893 Closing
[Mon Aug  1 10:29:47 2022] [::ffff:100.76.152.192]:27224 Accepted
[Mon Aug  1 10:29:47 2022] [::ffff:100.76.152.192]:27224 [302]: POST /
[Mon Aug  1 10:29:47 2022] [::ffff:100.76.152.192]:27224 Closing
[Mon Aug  1 10:29:47 2022] [::ffff:100.76.152.192]:47727 Accepted
[Mon Aug  1 10:29:47 2022] [::ffff:100.76.152.192]:47727 [302]: GET /?mssql=10.47.99.86&username=sa&db=ReportServer
[Mon Aug  1 10:29:47 2022] [::ffff:100.76.152.192]:47727 Closing
[Mon Aug  1 10:29:47 2022] [::ffff:100.76.152.192]:11140 Accepted
[Mon Aug  1 10:29:48 2022] [::ffff:100.76.152.192]:11140 [200]: GET /?mssql=10.47.99.86&username=sa&db=ReportServer&ns=dbo
[Mon Aug  1 10:29:48 2022] [::ffff:100.76.152.192]:11140 Closing
[Mon Aug  1 10:29:48 2022] [::ffff:100.76.152.192]:20688 Accepted
[Mon Aug  1 10:29:48 2022] [::ffff:100.76.152.192]:20688 [200]: GET /?mssql=10.47.99.86&username=sa&db=ReportServer&ns=dbo&script=db
[Mon Aug  1 10:29:48 2022] [::ffff:100.76.152.192]:20688 Closing
[Mon Aug  1 10:34:14 2022] [::ffff:100.76.152.192]:48744 Closed without sending a request; it was probably just an unused speculative preconnection
[Mon Aug  1 10:34:14 2022] [::ffff:100.76.152.192]:48744 Closing
[Mon Aug  1 10:38:14 2022] [::ffff:100.76.152.192]:33914 Accepted
[Mon Aug  1 10:38:15 2022] [::ffff:100.76.152.192]:33914 [200]: GET /?mssql=10.47.99.86&username=sa&db=ReportServer&ns=dbo&table=ActiveSubscriptions
[Mon Aug  1 10:38:15 2022] [::ffff:100.76.152.192]:33914 Closing
[Mon Aug  1 10:38:20 2022] [::ffff:100.76.152.192]:51067 Accepted
[Mon Aug  1 10:38:20 2022] [::ffff:100.76.152.192]:51067 [200]: GET /?mssql=10.47.99.86&username=sa&db=ReportServer&ns=dbo&table=CachePolicy
[Mon Aug  1 10:38:20 2022] [::ffff:100.76.152.192]:51067 Closing
[Mon Aug  1 10:38:27 2022] [::ffff:100.76.152.192]:65054 Accepted
[Mon Aug  1 10:38:27 2022] [::ffff:100.76.152.192]:65054 [200]: GET /?mssql=10.47.99.86&username=sa&db=ReportServer&ns=dbo&table=Keys
[Mon Aug  1 10:38:27 2022] [::ffff:100.76.152.192]:65054 Closing
[Mon Aug  1 10:38:33 2022] [::ffff:100.76.152.192]:64005 Accepted
[Mon Aug  1 10:38:33 2022] [::ffff:100.76.152.192]:64005 [200]: GET /?mssql=10.47.99.86&username=sa&db=ReportServer&ns=dbo&select=Keys
[Mon Aug  1 10:38:33 2022] [::ffff:100.76.152.192]:64005 Closing
[Mon Aug  1 10:38:45 2022] [::ffff:100.76.152.192]:32293 Accepted
[Mon Aug  1 10:38:45 2022] [::ffff:100.76.152.192]:32293 [200]: GET /?mssql=10.47.99.86&username=sa&db=ReportServer&ns=
[Mon Aug  1 10:38:45 2022] [::ffff:100.76.152.192]:32293 Closing
[Mon Aug  1 10:38:49 2022] [::ffff:100.76.152.192]:20600 Accepted
[Mon Aug  1 10:38:49 2022] [::ffff:100.76.152.192]:20600 [200]: GET /?mssql=10.47.99.86&username=sa&db=ReportServer&ns=&import=
[Mon Aug  1 10:38:49 2022] [::ffff:100.76.152.192]:20600 Closing
[Mon Aug  1 10:38:57 2022] [::ffff:100.76.152.192]:48215 Accepted
[Mon Aug  1 10:38:58 2022] [::ffff:100.76.152.192]:48215 [200]: GET /?mssql=10.47.99.86&username=sa&db=ReportServer&ns=
[Mon Aug  1 10:38:58 2022] [::ffff:100.76.152.192]:48215 Closing
[Mon Aug  1 10:39:00 2022] [::ffff:100.76.152.192]:15473 Accepted
[Mon Aug  1 10:39:00 2022] [::ffff:100.76.152.192]:15473 [200]: GET /?mssql=10.47.99.86&username=sa&db=ReportServer&ns=&database=
[Mon Aug  1 10:39:00 2022] [::ffff:100.76.152.192]:15473 Closing
[Mon Aug  1 10:39:04 2022] [::ffff:100.76.152.192]:11268 Accepted
[Mon Aug  1 10:39:04 2022] [::ffff:100.76.152.192]:11268 [200]: GET /?mssql=10.47.99.86&username=sa&db=ReportServer&ns=&scheme=
[Mon Aug  1 10:39:04 2022] [::ffff:100.76.152.192]:11268 Closing
[Mon Aug  1 10:39:12 2022] [::ffff:100.76.152.192]:26215 Accepted
[Mon Aug  1 10:39:12 2022] [::ffff:100.76.152.192]:26215 [200]: GET /?mssql=10.47.99.86&username=sa&db=ReportServer&ns=&sql=
[Mon Aug  1 10:39:12 2022] [::ffff:100.76.152.192]:26215 Closing
[Mon Aug  1 10:39:20 2022] [::ffff:100.76.152.192]:61797 Accepted
[Mon Aug  1 10:39:20 2022] [::ffff:100.76.152.192]:61797 [200]: GET /?mssql=10.47.99.86&username=sa&db=ReportServer&ns=dbo&view=ExecutionLog
[Mon Aug  1 10:39:20 2022] [::ffff:100.76.152.192]:61797 Closing
[Mon Aug  1 10:39:26 2022] [::ffff:100.76.152.192]:25250 Accepted
[Mon Aug  1 10:39:27 2022] [::ffff:100.76.152.192]:25250 [200]: GET /?mssql=10.47.99.86&username=sa&db=ReportServer&ns=dbo&select=ExecutionLog
[Mon Aug  1 10:39:27 2022] [::ffff:100.76.152.192]:25250 Closing
~~~~

上面的 `kubectl` 命令同时也是不错的创建简单资源的示例。

## 基于 Helm 的部署

ref: https://github.com/cetic/helm-adminer

你需要先添加应用（ `chart` ）仓库：把地址 `https://cetic.github.io/helm-charts` 添加为名称 `cetic` 。

命令：

~~~ sh
helm repo add -- cetic https://cetic.github.io/helm-charts
helm repo update
~~~

安装很简单：

~~~ sh
helm upgrade --install -n db-tools -- adminer cetic/adminer
~~~

或者任何等价的操作。总之，不需要什么参数。

这个 `chart` 或许也可以作为一个简单的 Helm 模板的示例用来帮助学习。




