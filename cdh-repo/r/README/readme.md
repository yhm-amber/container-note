# 启动参考

不知道怎么使用这个镜像，[这个](../README/launch.sh)就是使用案例。

# 源

这是一个 CHD 6.3.2 的离线镜像，**适用于 CentOS 7 **。

文件 [`README/cm-6.3.1.repo`](cm-6.3.1.repo) 是一个添加源的示例。

你可以把它下载到你的 CentOS 7 系统的 `/etc/yum.repos.d/` 中并作更改。

比如，执行这个：

~~~~ sh
(cd /etc/yum.repos.d && wget <上面的超链接>)
~~~~

然后编辑它，把里面地址的部分改成正确的。

你应该需要改成[这个](../cm/6.3.1/withdependencies)。

# 其它目录

- [CDH 6.3.2](../cdh/6.3.2)
- [CM 6.3.1](../cm/6.3.1)

# 使用说明

安装、初始化、服务管理

## 安装

添加源后，这样安装：

~~~ sh
yum install -y -- oracle-j2sdk1.8.x86_64 cloudera-manager-server
~~~

最好是用它提供的（也就是这个源里的）这个 JDK 。

## 初始化

安装完后按说就会有这个： `/opt/cloudera/cm/schema/scm_prepare_database.sh`

查看帮助：

~~~ sh
/opt/cloudera/cm/schema/scm_prepare_database.sh --help
~~~

应当印出以下信息：

~~~ help
usage: /opt/cloudera/cm/schema/scm_prepare_database.sh [options] (postgresql|mysql|oracle) database username [password]

Prepares a database (currently either MySQL, PostgreSQL or Oracle)
for use by Cloudera Service Configuration Manager (SCM):
o Creates a database (For PostgreSQL and MySQL only)
o Grants access to that database, by:
  - (PostgreSQL) Creating a role
  - (MySQL) Creating a grant
o Creates the SCM database configuration file.
o Tests if the database connection parameters are valid.

MANDATORY PARAMETERS
database type: either "oracle", "postgresql" or "mysql"
database: For PostgreSQL and MySQL, name of the SCM database to create.
          For Oracle this is the SID of the Oracle database.
username: Username for access to SCM's database.

OPTIONAL PARAMETERS
password: Password for the SCM user. If not provided, and --scm-password-script
          is not specified as an option, will prompt for it.

OPTIONS
   -h|--host       Database host. Default is to connect locally.
   -P|--port       Database port. If not specified, the database specific
                   default will be used: namely, 3306 for MySQL,
                   5432 for PostgreSQL, and 1521 for Oracle.
   -u|--user       Database username that has privileges for creating
                   users and grants.  The default is 'root'.
                   Typical values are 'root' for MySQL and
                   'postgres' for PostgreSQL. Not applicable for Oracle.
   -p|--password   Database Password. Default is no password.
   --scm-host      SCM server's hostname. Omit if SCM is colocated with MySQL.
   --config-path   Path to SCM configuration files.
                   Default is /etc/cloudera-scm-server.
   --scm-password-script Instead of obtaining the SCM username's password
                   directly, execute a script whose stdout is used as the
                   password.
   -f|--force      Don't stop when an error is encountered.
   -v|--verbose    Print more informational messages.
   -?|--help       Show this message.

NOTE ON POSTGRESQL CONFIGURATION
PostgreSQL must be configured to accept connections
with md5 password authentication.  To do so,
edit /var/lib/pgsql/data/pg_hba.conf (or similar)
to include "host all all 127.0.0.1/32 md5" _above_
a similar line that allows 'ident' authentication.
~~~


使用示例：

~~~ sh
/opt/cloudera/cm/schema/scm_prepare_database.sh \
  --host=cent2 \
  --scm-host=cent1 \
  -- mysql scm scm scm-pass-'()' ;
~~~

正确执行后的输出：

~~~ log
JAVA_HOME=/opt/jdk1.8.0_241
Verifying that we can write to /etc/cloudera-scm-server
Creating SCM configuration file in /etc/cloudera-scm-server
Executing:  /opt/jdk1.8.0_241/bin/java -cp /usr/share/java/mysql-connector-java.jar:/usr/share/java/oracle-connector-java.jar:/usr/share/java/postgresql-connector-java.jar:/opt/cloudera/cm/schema/../lib/* com.cloudera.enterprise.dbutil.DbCommandExecutor /etc/cloudera-scm-server/db.properties com.cloudera.cmf.db.
Fri Apr 15 18:46:05 CST 2022 WARN: Establishing SSL connection without server's identity verification is not recommended. According to MySQL 5.5.45+, 5.6.26+ and 5.7.6+ requirements SSL connection must be established by default if explicit option isn't set. For compliance with existing applications not using SSL the verifyServerCertificate property is set to 'false'. You need either to explicitly disable SSL by setting useSSL=false, or set useSSL=true and provide truststore for server certificate verification.
[                          main] DbCommandExecutor              INFO  Successfully connected to database.
All done, your SCM database is configured correctly!
~~~

参考：[Step 5: Set up the Cloudera Manager Database | 6.3.x | Cloudera Documentation](https://docs.cloudera.com/documentation/enterprise/6/6.3/topics/prepare_cm_database.html)

其中：

- 参数：
  
  - `--host` 后面，是你数据库的地址。用的是默认端口号。
  - `--scm-host` 后面，是这个刚刚安装了 `cloudera-manager-server` 包的节点地址。
  
  这两者建议用节点在集群网络中的主机名——最原始的手段就是对每个节点的 `/etc/hosts` 里都配上集群每个 IP 与主机名的对应。
  
  如果是在 Kubernetes 里，如果后端终点为数据库的 SVC 对象名为 `cdh-metadb-svc` 并在 `db-meta` NS 中的话，数据库（即要写在选项 `--host` 后）的主机名，可能是这个样的： `cdh-metadb-svc-clusterip.db-meta.svc.cluster.local` 。
  
- 数据库需要有一些初步的配置，下面有示例代码。
  
  对于 MySQL ，请使用 `5` 版本而不是 `8` 版本。
  
- 执行这个命令的节点**需要 JDBC Driver ：**
  
  - driver: [`mysql-connector-java-5.1.49.tar.gz`](https://downloads.mysql.com/archives/get/p/3/file/mysql-connector-java-5.1.49.tar.gz) （或[这个](../metadb/mysql-connector-java-5.1.49.tar.gz)）
  - md5: `e7bc11a55398bad0ea8548163deabaa8`
  - gpg: [`mysql-connector-java-5.1.49.tar.gz.asc`](https://downloads.mysql.com/archives/gpg/?file=mysql-connector-java-5.1.49.tar.gz&p=3) （或[这个](../metadb/mysql-connector-java-5.1.49.tar.gz.asc)）
  
  解压并把里面的 `.jar` 文件放到 `/usr/share/java` 内即可：
  
  ~~~ sh
  mkdir -p -- /usr/share/java
  tar -xzf mysql-connector-java-5.1.49.tar.gz -C /usr/share/java
  (cd /usr/share/java && ln -s -- ./mysql-connector-java-5.1.49/mysql-connector-java-5.1.49-bin.jar ./mysql-connector-java.jar)
  ~~~
  

  


### 示例的环境

主机名与地址的映射、元数据数据库

#### 主机名与地址的映射

简单的集群节点主机名与地址的映射方案：

~~~ bash
mkhosts ()
{
    local counts="${1:-3}" &&
    
    echo &&
    seq "$counts" |
        xargs -i -- echo 10.28.3.10{} cent{} &&
    echo &&
    
    :;
} &&

mkhosts 3 | cut -d' ' -f1 |
    
    xargs -i -- ssh root@{} -- "
        
        $(declare -f -- mkhosts)"' ;
        
        mkhosts 3 | tee -a -- /etc/hosts &&
        echo ::: $HOSTNAME :: done ::: ' ;
~~~

#### 元数据数据库

我准备了一个用于元数据库的镜像： [`cdh-meta.tar.xz`](../metadb/cdh-meta.tar.xz)

导入：

~~~ sh
docker load -i cdh-meta.tar.xz
~~~

导入后，使用：

~~~ bash
eval "$(docker run --rm -- cdh-meta cat /creator.sh)"
~~~

这是一个工具，它会问你要一个密码的统一后缀。我输入了这个： `pass-()` 。

再回车，就可以创建容器。**重复执行会删掉已经创建的容器**。

也可以只是打印这个工具的代码：

~~~ bash
docker run --rm -- cdh-meta cat /creator.sh
~~~

这就是使用这个镜像的方式。

镜像的构建文件这样获取：

~~~ sh
docker run --rm -- cdh-meta cat /Dockerfile
~~~

这样你就能看出我是怎么做出来的这个东西。（里面的空行往下的部分是应当有用但不起效果的。留着就是为了证明它不起效果。）

里面的任何文件也可以通过这种方式获取。





## 服务管理

请在上面的 `scm_prepare_database.sh` 执行初始化它的元数据库完成后，再第一次启动服务。

服务自启动/重启：

~~~ sh
systemctl enable cloudera-scm-server.service
systemctl restart cloudera-scm-server.service
~~~

查看启动日志：

~~~ sh
sudo tail -f /var/log/cloudera-scm-server/cloudera-scm-server.log
~~~

过会儿就能访问 `cent1` 的 `7180` 端口了。

安装时， CM 源填写[这个](../cm/6.3.1/withdependencies/)， Parcel 源写[这个](../cdh/6.3.2)。

----