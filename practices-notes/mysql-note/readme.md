
# RadonDB note

集群 MySQL 在 Kubernetes 上有几个云原生方案， RadonDB 是其中之一。

## install by operator

新版本的 RadonDB 只支持使用 Operator 创建实例。

~~~ sh
: helm repo
helm repo add -- radondb-mysql-operator https://radondb.github.io/radondb-mysql-kubernetes

: app get
helm pull --untar --untardir radondb-mysql-operator -- radondb-mysql-operator/mysql-operator
~~~

这个在安装时基本不需要设置啥 `values.yaml` ，注意选择好 ns 即可。

你可以为你的项目建立一个名为 `operators-xxx` 的 namespace ，也可以全局地使用一个名为 `operators` 的 namespace ，或者随你喜欢，但一定要为后面的管理创造方便而不要“死后哪管它洪水滔天”。

安好 operator 了，你就能使用这些个 `Kind` 了： `MysqlCluster` `MysqlUser` ；前者用于创建一个 HA 的 MySQL 集群实例（目前用着感觉还挺方便维护的），后者用于以 Kubernetes 的方式创建 MySQL 用户。

<details>

<summary>示例</summary>

~~~~ yaml
apiVersion: mysql.radondb.com/v1alpha1
kind: MysqlCluster
metadata:
  name: meta-mysql
  namespace: bigdataplat-db
spec:
  replicas: 3
  mysqlVersion: "5.7"
  
  # the backupSecretName specify the secret file name which store S3 information,
  # if you want S3 backup or restore, please create backup_secret.yaml, uncomment below and fill secret name:
  # backupSecretName: 
  
  # if you want create mysqlcluster from S3, uncomment and fill the directory in S3 bucket below:
  # restoreFrom: 
  
  mysqlOpts:
    rootPassword: "RadonDB@123"
    rootHost: "%" # 这个原来是 localhost ，我改成这样但其实没用。
    user: radondb_usr
    password: RadonDB@123
    database: radondb
    initTokuDB: true

    # A simple map between string and string.
    # Such as:
    #    mysqlConf:
    #      expire_logs_days: "7"
    mysqlConf:
      expire_logs_days: "7"

    resources:
      requests:
        cpu: 100m
        memory: 256Mi
      limits:
        cpu: 500m
        memory: 1Gi

  xenonOpts:
    image: radondb/xenon:1.1.5-alpha
    admitDefeatHearbeatCount: 5
    electionTimeout: 10000

    resources:
      requests:
        cpu: 50m
        memory: 128Mi
      limits:
        cpu: 100m
        memory: 256Mi

  metricsOpts:
    enabled: false
    image: prom/mysqld-exporter:v0.12.1

    resources:
      requests:
        cpu: 10m
        memory: 32Mi
      limits:
        cpu: 100m
        memory: 128Mi

  podPolicy:
    imagePullPolicy: IfNotPresent
    sidecarImage: radondb/mysql-sidecar:v2.1.4
    busyboxImage: busybox:1.32

    slowLogTail: false
    auditLogTail: false

    labels: {}
    annotations: {}
    affinity: {}
    priorityClassName: ""
    tolerations: []
    schedulerName: ""
    # extraResources defines quotas for containers other than mysql or xenon.
    extraResources:
      requests:
        cpu: 10m
        memory: 32Mi

  persistence:
    enabled: true
    accessModes:
    - ReadWriteOnce
    # storageClass: ""
    size: 20Gi
~~~~

</details>

## user account management

用户管理有点有趣。

我先是看了[他们网站的说明](https://radondb.com/docs/mysql/v2.1.3/feature/mysqluser)，然后产生了疑问。我就在[这个地方](https://github.com/radondb/radondb-mysql-kubernetes/issues/337)提出了疑问。

结合已知信息和里面的恢复，可以得到下列结论：

1. 内置用户如 `root` `replication-user` `metrics-user` 是被 operator 的部分功能所依赖的， `root` 密码是一个随机密码（而不是被资源定义里的 `spec.mysqlOpts.rootPassword` 所指定）。
   
   而我唯一一个能首次成功访问 `root` 的途径就是对 `leader` Pod 的 `mysql` 容器的终端使用 `mysql -uroot` 。
   
   我可以在里面使用这个打开外部访问并设定密码：
   
   ~~~~ mysql
   grant all privileges on *.* to 'root'@'%' identified by 'RadonDB@123' with grant option ;
   ~~~~
   
   但这会影响 operator 的功能，但这会在“节点重启”（我也不知道是 STS 还是 node 算节点）后恢复。
   
   替代远程 `root` 的超级用户目前是像这样创建： https://github.com/radondb/radondb-mysql-kubernetes/issues/182
   
   或者这样或许也行：
   
   ~~~~ mysql
   grant all privileges on *.* to 'dev'@'%' identified by 'P@88w0rd--dev' with grant option ;
   ~~~~
   
2. 上述对非内置用户没有关系，也就是说我还是可以用这样的模板创建用户和库：
   
   ~~~~ mysql
   create database if not exists `{}` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci ;
   grant all on `{}`.* to "{}"@"%" identified by "{}-P@88w0rd" ; show grants for "{}"@"%" ;
   ~~~~
   
   当然，这部分行为是不能被 `mysqluser` 的 Kubernetes Kind 追踪并同步的。


