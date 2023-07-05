
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

这个最终结果和上面的创建实例，会不太一样。启动失败的容器不会显示为正常运行，而是正确地显示为未就绪。

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

## 现存错误

像上面的示例这样配置外部数据库的话，会有没有数据库的错误，即便可以从外部连接： https://github.com/alibaba/nacos/issues/6886  

如果为 Nacos 准备的数据库里没有表，也会导致这个错误。

我在我的 `nacos` 数据库应用了 [`distribution/conf/nacos-mysql.sql`](https://github.com/alibaba/nacos/blob/2.0.3/distribution/conf/nacos-mysql.sql) 里面 的SQL ，就没什么问题了。

**（我这个是切换 tag 到版本 `2.0.3` 了，你们谁需要的话注意切到对应的 tag 版本上。）**

<details>

<summary>
<code>nacos-mysql-2.0.3.sql</code>
</summary>

~~~ mysql
/*
 * Copyright 1999-2018 Alibaba Group Holding Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = config_info   */
/******************************************/
CREATE TABLE `config_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) DEFAULT NULL,
  `content` longtext NOT NULL COMMENT 'content',
  `md5` varchar(32) DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text COMMENT 'source user',
  `src_ip` varchar(50) DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) DEFAULT NULL,
  `tenant_id` varchar(128) DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) DEFAULT NULL,
  `c_use` varchar(64) DEFAULT NULL,
  `effect` varchar(64) DEFAULT NULL,
  `type` varchar(64) DEFAULT NULL,
  `c_schema` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfo_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info';

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = config_info_aggr   */
/******************************************/
CREATE TABLE `config_info_aggr` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) NOT NULL COMMENT 'datum_id',
  `content` longtext NOT NULL COMMENT '内容',
  `gmt_modified` datetime NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) DEFAULT NULL,
  `tenant_id` varchar(128) DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfoaggr_datagrouptenantdatum` (`data_id`,`group_id`,`tenant_id`,`datum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='增加租户字段';


/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = config_info_beta   */
/******************************************/
CREATE TABLE `config_info_beta` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) DEFAULT NULL COMMENT 'app_name',
  `content` longtext NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text COMMENT 'source user',
  `src_ip` varchar(50) DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfobeta_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info_beta';

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = config_info_tag   */
/******************************************/
CREATE TABLE `config_info_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) DEFAULT NULL COMMENT 'app_name',
  `content` longtext NOT NULL COMMENT 'content',
  `md5` varchar(32) DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text COMMENT 'source user',
  `src_ip` varchar(50) DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfotag_datagrouptenanttag` (`data_id`,`group_id`,`tenant_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info_tag';

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = config_tags_relation   */
/******************************************/
CREATE TABLE `config_tags_relation` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `tag_name` varchar(128) NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`),
  UNIQUE KEY `uk_configtagrelation_configidtag` (`id`,`tag_name`,`tag_type`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_tag_relation';

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = group_capacity   */
/******************************************/
CREATE TABLE `group_capacity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='集群、各Group容量信息表';

/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = his_config_info   */
/******************************************/
CREATE TABLE `his_config_info` (
  `id` bigint(64) unsigned NOT NULL,
  `nid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) NOT NULL,
  `group_id` varchar(128) NOT NULL,
  `app_name` varchar(128) DEFAULT NULL COMMENT 'app_name',
  `content` longtext NOT NULL,
  `md5` varchar(32) DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `src_user` text,
  `src_ip` varchar(50) DEFAULT NULL,
  `op_type` char(10) DEFAULT NULL,
  `tenant_id` varchar(128) DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`nid`),
  KEY `idx_gmt_create` (`gmt_create`),
  KEY `idx_gmt_modified` (`gmt_modified`),
  KEY `idx_did` (`data_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='多租户改造';


/******************************************/
/*   数据库全名 = nacos_config   */
/*   表名称 = tenant_capacity   */
/******************************************/
CREATE TABLE `tenant_capacity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数',
  `max_aggr_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='租户容量信息表';


CREATE TABLE `tenant_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) default '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) default '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint(20) NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint(20) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_info_kptenantid` (`kp`,`tenant_id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='tenant_info';

CREATE TABLE `users` (
	`username` varchar(50) NOT NULL PRIMARY KEY,
	`password` varchar(500) NOT NULL,
	`enabled` boolean NOT NULL
);

CREATE TABLE `roles` (
	`username` varchar(50) NOT NULL,
	`role` varchar(50) NOT NULL,
	UNIQUE INDEX `idx_user_role` (`username` ASC, `role` ASC) USING BTREE
);

CREATE TABLE `permissions` (
    `role` varchar(50) NOT NULL,
    `resource` varchar(255) NOT NULL,
    `action` varchar(8) NOT NULL,
    UNIQUE INDEX `uk_role_permission` (`role`,`resource`,`action`) USING BTREE
);

INSERT INTO users (username, password, enabled) VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', TRUE);

INSERT INTO roles (username, role) VALUES ('nacos', 'ROLE_ADMIN');
~~~

</details>

。。。

但，我认为我为 Nacos 创建的数据库，应当就是空着的，然后 Nacos 看我指定的数据库是空的，就会自行在其中做必要的 `source nacos-mysql.sql` 。

我找了一下， `nacos/nacos-server:2.0.3` 的镜像内，并没有 `nacos-mysql.sql` 这个文件，但是在 Release 的压缩包和源码中都可以找到这个文件。

这意味着， Nacos 并没有被赋予在自己被指定的 database 中自动初始化 MySQL 表的能力。

但我认为这是需要有的能力。所以，这依然是一个问题，至少在 `2.0.3` 版本存在这个问题，我只是找到了手动修复的途径罢了。

希望在未来版本的 Helm 或 Operator 部署中可以为 Nacos 增加自动初始化外部数据库的能力：只要那个库是空的，就要执行初始化（这应该会需要用到至少一个 Init Container 吧）；如果被指定的目标库不为空但是缺少表，也最好明确报错出还缺少什么表、或什么表结构不正确，而不是像现在这样，在显眼位置的有用的信息只有一个 `No DataSource set` 而已。

（感谢 [`Evasi0n (@wangjiandev(9983583))`](https://github.com/wangjiandev) 提出的 [issue](https://github.com/alibaba/nacos/issues/6886) 👍。）


## Other way by ygqygq2

ref: https://artifacthub.io/packages/helm/ygqygq2/nacos  
ref: https://artifacthub.io/packages/helm/ygqygq2/mysql  



~~~ sh
helm repo add -- ygqygq2 https://ygqygq2.github.io/charts
~~~

~~~ sh
helm pull --untardir ygqygq2 --untar -- ygqygq2/nacos
helm pull --untardir ygqygq2 --untar -- ygqygq2/mysql
~~~

~~~ sh
(cd ygqygq2/nacos && helm dependency build) &&
helm install --namespace nacos --create-namespace -- mysql ygqygq2/nacos
~~~


<details>

<summary>
outs:
</summary>

~~~
Getting updates for unmanaged Helm repositories...
...Successfully got an update from the "https://charts.bitnami.com/bitnami" chart repository
...Successfully got an update from the "https://charts.bitnami.com/bitnami" chart repository
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "jetstack" chart repository
...Successfully got an update from the "rancher-stable" chart repository
...Successfully got an update from the "openebs" chart repository
...Successfully got an update from the "harbor" chart repository
...Successfully got an update from the "ygqygq2" chart repository
Update Complete. ⎈Happy Helming!⎈
Saving 2 charts
Downloading common from repo https://charts.bitnami.com/bitnami
Downloading mysql from repo https://charts.bitnami.com/bitnami
Deleting outdated charts
NAME: mysql
LAST DEPLOYED: Wed Jun  8 16:12:46 2022
NAMESPACE: nacos
STATUS: deployed
REVISION: 1
NOTES:
The nacos has been installed.

Nacos can be accessed:



  * Within your cluster, at the following DNS name at port 8848:

    mysql-nacos.nacos.svc

  * From outside the cluster, run these commands in the same shell:

    export POD_NAME=$(kubectl get pods --namespace nacos -l "app=nacos,release=mysql" -o jsonpath="{.items[0].metadata.name}")
    echo "Visit http://127.0.0.1:8848/nacos to use nacos"
    kubectl port-forward --namespace nacos $POD_NAME 8848:8848

    # The default user is: nacos
    # The default password is: n
~~~

</details>

~~~ sh
(cd ygqygq2/mysql && helm dependency build) &&
helm install --namespace mysql --create-namespace --set root.password='123#@!AaA' -- mysql ygqygq2/mysql
~~~

<details>

<summary>
outs:
</summary>

~~~
Getting updates for unmanaged Helm repositories...
...Successfully got an update from the "https://charts.bitnami.com/bitnami" chart repository
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "ygqygq2" chart repository
...Successfully got an update from the "jetstack" chart repository
...Successfully got an update from the "rancher-stable" chart repository
...Successfully got an update from the "harbor" chart repository
...Successfully got an update from the "openebs" chart repository
Update Complete. ⎈Happy Helming!⎈
Saving 1 charts
Downloading common from repo https://charts.bitnami.com/bitnami
Deleting outdated charts
NAME: mysql
LAST DEPLOYED: Wed Jun  8 16:17:52 2022
NAMESPACE: mysql
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Please be patient while the chart is being deployed

Tip:

  Watch the deployment status using the command: kubectl get pods -w --namespace mysql

Services:

  echo Master: mysql-mysql.mysql.svc.cluster.local:3306
  echo Slave:  mysql-mysql-slave.mysql.svc.cluster.local:3306

Administrator credentials:

  echo Username: root
  echo Password : $(kubectl get secret --namespace mysql mysql-mysql -o jsonpath="{.data.mysql-root-password}" | base64 --decode)

To connect to your database:

  1. Run a pod that you can use as a client:

      kubectl run mysql-mysql-client --rm --tty -i --restart='Never' --image  docker.io/bitnami/mysql:5.7.26 --namespace mysql --command -- bash

  2. To connect to master service (read/write):

      mysql -h mysql-mysql.mysql.svc.cluster.local -uroot -p my_database

  3. To connect to slave service (read-only):

      mysql -h mysql-mysql-slave.mysql.svc.cluster.local -uroot -p my_database

To upgrade this helm chart:

  1. Obtain the password as described on the 'Administrator credentials' section and set the 'root.password' parameter as shown below:

      ROOT_PASSWORD=$(kubectl get secret --namespace mysql mysql-mysql -o jsonpath="{.data.mysql-root-password}" | base64 --decode)
      helm upgrade mysql bitnami/mysql --set root.password=$R
~~~

</details>


