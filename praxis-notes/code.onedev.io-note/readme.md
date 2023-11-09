
[app]: https://code.onedev.io
[web]: https://onedev.io

[docs]: https://docs.onedev.io
[docs.repo]: https://code.onedev.io/onedev/manual

[app.repo]: https://code.onedev.io/onedev/server
[app.repo.gh]: https://github.com/theonedev/onedev.git

这是个 Git 托管。

开源、支持自己部署；比 GitLab 更轻，很适合团队协作。

功能齐全，可以设置 Pull Mirror 和 Push Mirror 。
我已经把我自己的东西做了镜像 ([yhm-ypa](https://code.onedev.io/yhm-ypa)) ，
有资源以后也会怎加一个自己的部署实例，并在上面放自己的代码。

作为一个 Server 程序，要 Kubernetes (云原生) 化应该不难，
要在某个链 (e.g. Arweave) 的 VM 上部署应该也不是做不到。


资源：

- [Projects | OneDev][web] ([repo][app.repo])
- [Introduction | OneDev Documentation][docs] ([repo][docs.repo])

[docs.in.repo]: https://code.onedev.io/onedev/manual/~files/main/pages/installation-guide.md "installation-guide.md at main - onedev/manual"
[docs.in]: https://docs.onedev.io/category/installation-guide "Installation Guide | OneDev Documentation"

## 部署在操作系统

[app.release]: https://code.onedev.io/onedev/server/~builds?query=%22Job%22+is+%22Release%22
[app.release.gh]: https://github.com/theonedev/onedev/releases

1. 确保 Git 已经安装。
2. 从释放页 ([release][app.release] or [release.gh][app.release.gh]) 下载你对应的二进制包。
3. 解压下载的包并确保它在它所在目录 (以及下属所有子目录) 有 *完整的权限 (full permissions)* 。
4. 执行 `bin/server.sh console` 脚本 (脚本后缀名会因为对应的系统不同而有所不同) 。


## 容器化部署

[img.dockerhub]: https://hub.docker.com/r/1dev/server

Containerized Deploy.

[1dev/server | DockerHub][img.dockerhub]



[docs.docker.repo]: https://code.onedev.io/onedev/manual/~files/main/pages/run-as-docker-container.md "run-as-docker-container.md at main - onedev/manual"
[docs.docker]: https://docs.onedev.io/installation-guide/run-as-docker-container "Run as Docker Container | OneDev Documentation"

[docs.k8s.repo]: https://code.onedev.io/onedev/manual/~files/main/pages/deploy-into-k8s.md "deploy-into-k8s.md at main - onedev/manual"
[docs.k8s]: https://code.onedev.io/onedev/manual/~files/main/pages/deploy-into-k8s.md "Deploy into Kubernetes Cluster | OneDev Documentation"

### Docker

#### docker

~~~ sh
: daemon
docker run --name onedev -d --restart always \
  -v <host docker sock>:/var/run/docker.sock \
  -v <data dir>:/opt/onedev \
  -p 6610:6610 -p 6611:6611 \
  -- 1dev/server ;

: foreground
docker run -t --name onedev --rm \
  -v <host docker sock>:/var/run/docker.sock \
  -v <data dir>:/opt/onedev \
  -p 6610:6610 -p 6611:6611 \
  -- 1dev/server ;
~~~

> Here `<host docker sock>` should be replaced
>  with `/var/run/docker.sock` if docker runs in root mode,
>  or `$XDG_RUNTIME_DIR/docker.sock` for rootless mode.
>  `<data dir>` replaced by a directory storing OneDev data.
> 
> Wait a while for OneDev to get up and running,
>  then point your browser to `http://localhost:6610` to access it.
> 

#### podman

~~~ sh
: Make sure podman system service is started

: foreground
podman run -it --name onedev --rm \
  -v $XDG_RUNTIME_DIR/podman/podman.sock:/var/run/docker.sock \
  -v <data dir>:/opt/onedev \
  -p 6610:6610 -p 6611:6611 \
  -- docker.io/1dev/server ;

: the <data dir> should be created first
:  before running above command
~~~

#### External Database

默认是用的内部自带的数据库。如果想用另外的数据库引擎，
可以用如下环境变量予以设置：

##### MySQL

~~~ sh
hibernate_dialect=org.hibernate.dialect.MySQL5InnoDBDialect
hibernate_connection_driver_class=com.mysql.cj.jdbc.Driver
hibernate_connection_url=jdbc:mysql://localhost:3306/onedev?serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false&disableMariaDbDriver=true
hibernate_connection_username=root
hibernate_connection_password=root
~~~

##### PostgreSQL

~~~ sh
hibernate_dialect=io.onedev.server.persistence.PostgreSQLDialect
hibernate_connection_driver_class=org.postgresql.Driver
hibernate_connection_url=jdbc:postgresql://localhost:5432/onedev
hibernate_connection_username=postgres
hibernate_connection_password=postgres
~~~

##### MariaDB

需要先准备好 MariaDB JDBC driver 放到 `<data dir>/site/lib` 目录。

~~~ sh
hibernate_dialect=org.hibernate.dialect.MySQL5InnoDBDialect
hibernate_connection_driver_class=org.mariadb.jdbc.Driver
hibernate_connection_url=jdbc:mariadb://localhost:3306/onedev
hibernate_connection_username=root
hibernate_connection_password=root
~~~

##### MS SQL Server

需要先准备好 SQL server JDBC driver 放到 `<data dir>/site/lib` 目录。

~~~ sh
hibernate_dialect=org.hibernate.dialect.SQLServer2012Dialect
hibernate_connection_driver_class=com.microsoft.sqlserver.jdbc.SQLServerDriver
hibernate_connection_url=jdbc:sqlserver://localhost:1433;databaseName=onedev
hibernate_connection_username=sa
hibernate_connection_password=sa
~~~

##### Oracle

需要先准备好 Oracle JDBC driver 放到 `<data dir>/site/lib` 目录。

~~~ sh
hibernate_dialect=org.hibernate.dialect.Oracle10gDialect
hibernate_connection_driver_class=oracle.jdbc.driver.OracleDriver
hibernate_connection_url=jdbc:oracle:thin:@localhost:1521:XE
hibernate_connection_username=onedev
hibernate_connection_password=onedev
~~~

#### Additional Environment Variables

| Name | Required | Description |
| ---- | -------- | ----------- |
| `initial_user` | Yes | Login name of administrator account ~ 管理员用户登录名 |
| `initial_password` | Yes | Password of administrator account ~ 管理员用户的密码 |
| `initial_email` | Yes | Email address of administrator account ~ 管理员用户的邮箱 |
| `initial_server_url` | Yes | Root url of this server ~ 该服务实例的根地址 |
| `initial_ssh_root_url` | No | SSH root url of this server (will derive from initial_server_url if left empty) ~ 该服务实例的 SSH 根地址 (留空则值同 `initial_server_url` ) |

> As the name indicates, these environment
>  variables are only used to initialize OneDev,
>  and will not affect subseuqent changes.
> 

这些变量仅在服务实例初始化阶段有效。

### Kubernetes

#### Helm

[helm/values.yaml]: https://code.onedev.io/onedev/server/~files/main/server-product/helm/values.yaml

~~~ sh
helm install --namespace onedev --create-namespace \
  --repo https://dl.cloudsmith.io/public/onedev/onedev/helm/charts \
  -- onedev onedev
~~~

or `add repo` for a many times use: 

~~~ sh
helm repo add -- onedev https://dl.cloudsmith.io/public/onedev/onedev/helm/charts &&
helm repo update -- onedev ;
~~~

配置值见 [`values.yaml`][helm/values.yaml] 。




