
## 快速开始

ref: https://kubesphere.io/zh/docs/quick-start/minimal-kubesphere-on-k8s/

这个是最小安装

### 安装

**安装前，务必先搞好一个默认的存储类。可以参考[这里](../openebs-note)。**

这就是最简单的安装步骤：

~~~ sh
kubectl apply -f https://github.com/kubesphere/ks-installer/releases/download/v3.2.1/kubesphere-installer.yaml
kubectl apply -f https://github.com/kubesphere/ks-installer/releases/download/v3.2.1/cluster-configuration.yaml
~~~

*（如果没有 Kubernetes 集群又暂且不想研究的话，可以用 [`sealos`](https://github.com/fanux/sealos) 这个工具来比较省心地创建一个。想快速研究 Kubernetes 的话可以看看 [`K8E`](https://github.com/xiaods/k8e) 这个项目的安装说明，或者[看我这里](../rke2-note)动手搞一搞 RKE2 。多找点事儿做以后，用任何 Kubernetes 发行版的时候也就都能如履平地一点。）*

*（上面如果网不好从 github.com 下东西失败的话，可以尝试使用 ghproxy 做代理（[这是使用说明](https://ghproxy.com)）。注意，人家是个人支撑的免费项目，别用得太过火。）*

### 检查

执行过上面的，再执行这个，就能看到安装过程中的日志输出了。

~~~ sh
kubectl logs -n kubesphere-system $(kubectl get pod -n kubesphere-system -l app=ks-install -o jsonpath='{.items[0].metadata.name}') -f
~~~

它打到最后，成了的话，就会给你打出一个欢迎界面一样的信息。上面有管理员账户的初始密码以及一个可用的访问地址。

out:

~~~ text
2022-04-25T17:08:17+08:00 INFO     : shell-operator latest
2022-04-25T17:08:17+08:00 INFO     : HTTP SERVER Listening on 0.0.0.0:9115
2022-04-25T17:08:17+08:00 INFO     : Use temporary dir: /tmp/shell-operator
2022-04-25T17:08:17+08:00 INFO     : Initialize hooks manager ...
2022-04-25T17:08:17+08:00 INFO     : Search and load hooks ...
2022-04-25T17:08:17+08:00 INFO     : Load hook config from '/hooks/kubesphere/installRunner.py'
2022-04-25T17:08:18+08:00 INFO     : Load hook config from '/hooks/kubesphere/schedule.sh'
2022-04-25T17:08:18+08:00 INFO     : Initializing schedule manager ...
2022-04-25T17:08:18+08:00 INFO     : KUBE Init Kubernetes client
2022-04-25T17:08:18+08:00 INFO     : KUBE-INIT Kubernetes client is configured successfully
2022-04-25T17:08:18+08:00 INFO     : MAIN: run main loop
2022-04-25T17:08:18+08:00 INFO     : MAIN: add onStartup tasks
2022-04-25T17:08:18+08:00 INFO     : QUEUE add all HookRun@OnStartup
2022-04-25T17:08:18+08:00 INFO     : Running schedule manager ...
2022-04-25T17:08:18+08:00 INFO     : MSTOR Create new metric shell_operator_live_ticks
2022-04-25T17:08:18+08:00 INFO     : MSTOR Create new metric shell_operator_tasks_queue_length
2022-04-25T17:08:18+08:00 INFO     : GVR for kind 'ClusterConfiguration' is installer.kubesphere.io/v1alpha1, Resource=clusterconfigurations
2022-04-25T17:08:18+08:00 INFO     : EVENT Kube event '3d647bbe-24f3-4abb-81dd-d9384f771de4'
2022-04-25T17:08:18+08:00 INFO     : QUEUE add TASK_HOOK_RUN@KUBE_EVENTS kubesphere/installRunner.py
2022-04-25T17:08:21+08:00 INFO     : TASK_RUN HookRun@KUBE_EVENTS kubesphere/installRunner.py
2022-04-25T17:08:21+08:00 INFO     : Running hook 'kubesphere/installRunner.py' binding 'KUBE_EVENTS' ...
[WARNING]: No inventory was parsed, only implicit localhost is available
[WARNING]: provided hosts list is empty, only localhost is available. Note that
the implicit localhost does not match 'all'

PLAY [localhost] ***************************************************************

TASK [download : Generating images list] ***************************************
skipping: [localhost]

TASK [download : Synchronizing images] *****************************************

TASK [kubesphere-defaults : KubeSphere | Setting images' namespace override] ***
skipping: [localhost]

TASK [kubesphere-defaults : KubeSphere | Configuring defaults] *****************
ok: [localhost] => {
    "msg": "Check roles/kubesphere-defaults/defaults/main.yml"
}

TASK [preinstall : KubeSphere | Stopping if Kubernetes version is nonsupport] ***
ok: [localhost] => {
    "changed": false,
    "msg": "All assertions passed"
}

TASK [preinstall : KubeSphere | Checking StorageClass] *************************
changed: [localhost]

TASK [preinstall : KubeSphere | Stopping if StorageClass was not found] ********
skipping: [localhost]

TASK [preinstall : KubeSphere | Checking default StorageClass] *****************
changed: [localhost]

TASK [preinstall : KubeSphere | Stopping if default StorageClass was not found] ***
ok: [localhost] => {
    "changed": false,
    "msg": "All assertions passed"
}

TASK [preinstall : KubeSphere | Checking KubeSphere component] *****************
changed: [localhost]

TASK [preinstall : KubeSphere | Getting KubeSphere component version] **********
skipping: [localhost]

TASK [preinstall : KubeSphere | Getting KubeSphere component version] **********
skipping: [localhost] => (item=ks-openldap)
skipping: [localhost] => (item=ks-redis)
skipping: [localhost] => (item=ks-minio)
skipping: [localhost] => (item=ks-openpitrix)
skipping: [localhost] => (item=elasticsearch-logging)
skipping: [localhost] => (item=elasticsearch-logging-curator)
skipping: [localhost] => (item=istio)
skipping: [localhost] => (item=istio-init)
skipping: [localhost] => (item=jaeger-operator)
skipping: [localhost] => (item=ks-jenkins)
skipping: [localhost] => (item=ks-sonarqube)
skipping: [localhost] => (item=logging-fluentbit-operator)
skipping: [localhost] => (item=uc)
skipping: [localhost] => (item=metrics-server)

PLAY RECAP *********************************************************************
localhost                  : ok=6    changed=3    unreachable=0    failed=0    skipped=6    rescued=0    ignored=0

[WARNING]: No inventory was parsed, only implicit localhost is available
[WARNING]: provided hosts list is empty, only localhost is available. Note that
the implicit localhost does not match 'all'

PLAY [localhost] ***************************************************************

TASK [download : Generating images list] ***************************************
skipping: [localhost]

TASK [download : Synchronizing images] *****************************************

TASK [kubesphere-defaults : KubeSphere | Setting images' namespace override] ***
skipping: [localhost]

TASK [kubesphere-defaults : KubeSphere | Configuring defaults] *****************
ok: [localhost] => {
    "msg": "Check roles/kubesphere-defaults/defaults/main.yml"
}

TASK [Metrics-Server | Getting metrics-server installation files] **************
skipping: [localhost]

TASK [metrics-server : Metrics-Server | Creating manifests] ********************
skipping: [localhost] => (item={'file': 'metrics-server.yaml'})

TASK [metrics-server : Metrics-Server | Checking Metrics-Server] ***************
skipping: [localhost]

TASK [Metrics-Server | Uninstalling old metrics-server] ************************
skipping: [localhost]

TASK [Metrics-Server | Installing new metrics-server] **************************
skipping: [localhost]

TASK [metrics-server : Metrics-Server | Waitting for metrics.k8s.io ready] *****
skipping: [localhost]

TASK [Metrics-Server | Importing metrics-server status] ************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=0    skipped=10   rescued=0    ignored=0

[WARNING]: No inventory was parsed, only implicit localhost is available
[WARNING]: provided hosts list is empty, only localhost is available. Note that
the implicit localhost does not match 'all'

PLAY [localhost] ***************************************************************

TASK [download : Generating images list] ***************************************
skipping: [localhost]

TASK [download : Synchronizing images] *****************************************

TASK [kubesphere-defaults : KubeSphere | Setting images' namespace override] ***
skipping: [localhost]

TASK [kubesphere-defaults : KubeSphere | Configuring defaults] *****************
ok: [localhost] => {
    "msg": "Check roles/kubesphere-defaults/defaults/main.yml"
}

TASK [common : KubeSphere | Checking kube-node-lease namespace] ****************
changed: [localhost]

TASK [common : KubeSphere | Getting system namespaces] *************************
ok: [localhost]

TASK [common : set_fact] *******************************************************
ok: [localhost]

TASK [common : debug] **********************************************************
ok: [localhost] => {
    "msg": [
        "kubesphere-system",
        "kubesphere-controls-system",
        "kubesphere-monitoring-system",
        "kubesphere-monitoring-federated",
        "kube-node-lease"
    ]
}

TASK [common : KubeSphere | Creating KubeSphere namespace] *********************
changed: [localhost] => (item=kubesphere-system)
changed: [localhost] => (item=kubesphere-controls-system)
changed: [localhost] => (item=kubesphere-monitoring-system)
changed: [localhost] => (item=kubesphere-monitoring-federated)
changed: [localhost] => (item=kube-node-lease)

TASK [common : KubeSphere | Labeling system-workspace] *************************
changed: [localhost] => (item=default)
changed: [localhost] => (item=kube-public)
changed: [localhost] => (item=kube-system)
changed: [localhost] => (item=kubesphere-system)
changed: [localhost] => (item=kubesphere-controls-system)
changed: [localhost] => (item=kubesphere-monitoring-system)
changed: [localhost] => (item=kubesphere-monitoring-federated)
changed: [localhost] => (item=kube-node-lease)

TASK [common : KubeSphere | Labeling namespace for network policy] *************
changed: [localhost]

TASK [common : KubeSphere | Getting Kubernetes master num] *********************
changed: [localhost]

TASK [common : KubeSphere | Setting master num] ********************************
ok: [localhost]

TASK [KubeSphere | Getting common component installation files] ****************
changed: [localhost] => (item=common)

TASK [common : KubeSphere | Checking Kubernetes version] ***********************
changed: [localhost]

TASK [KubeSphere | Getting common component installation files] ****************
changed: [localhost] => (item=snapshot-controller)

TASK [common : KubeSphere | Creating snapshot controller values] ***************
changed: [localhost] => (item={'name': 'custom-values-snapshot-controller', 'file': 'custom-values-snapshot-controller.yaml'})

TASK [common : KubeSphere | Updating snapshot crd] *****************************
changed: [localhost]

TASK [common : KubeSphere | Deploying snapshot controller] *********************
changed: [localhost]

TASK [KubeSphere | Checking openpitrix common component] ***********************
changed: [localhost]

TASK [common : include_tasks] **************************************************
skipping: [localhost] => (item={'op': 'openpitrix-db', 'ks': 'mysql-pvc'})
skipping: [localhost] => (item={'op': 'openpitrix-etcd', 'ks': 'etcd-pvc'})

TASK [common : Getting PersistentVolumeName (mysql)] ***************************
skipping: [localhost]

TASK [common : Getting PersistentVolumeSize (mysql)] ***************************
skipping: [localhost]

TASK [common : Setting PersistentVolumeName (mysql)] ***************************
skipping: [localhost]

TASK [common : Setting PersistentVolumeSize (mysql)] ***************************
skipping: [localhost]

TASK [common : Getting PersistentVolumeName (etcd)] ****************************
skipping: [localhost]

TASK [common : Getting PersistentVolumeSize (etcd)] ****************************
skipping: [localhost]

TASK [common : Setting PersistentVolumeName (etcd)] ****************************
skipping: [localhost]

TASK [common : Setting PersistentVolumeSize (etcd)] ****************************
skipping: [localhost]

TASK [common : KubeSphere | Checking mysql PersistentVolumeClaim] **************
changed: [localhost]

TASK [common : KubeSphere | Setting mysql db pv size] **************************
skipping: [localhost]

TASK [common : KubeSphere | Checking redis PersistentVolumeClaim] **************
changed: [localhost]

TASK [common : KubeSphere | Setting redis db pv size] **************************
skipping: [localhost]

TASK [common : KubeSphere | Checking minio PersistentVolumeClaim] **************
changed: [localhost]

TASK [common : KubeSphere | Setting minio pv size] *****************************
skipping: [localhost]

TASK [common : KubeSphere | Checking openldap PersistentVolumeClaim] ***********
changed: [localhost]

TASK [common : KubeSphere | Setting openldap pv size] **************************
skipping: [localhost]

TASK [common : KubeSphere | Checking etcd db PersistentVolumeClaim] ************
changed: [localhost]

TASK [common : KubeSphere | Setting etcd pv size] ******************************
skipping: [localhost]

TASK [common : KubeSphere | Checking redis ha PersistentVolumeClaim] ***********
changed: [localhost]

TASK [common : KubeSphere | Setting redis ha pv size] **************************
skipping: [localhost]

TASK [common : KubeSphere | Checking es-master PersistentVolumeClaim] **********
changed: [localhost]

TASK [common : KubeSphere | Setting es master pv size] *************************
skipping: [localhost]

TASK [common : KubeSphere | Checking es data PersistentVolumeClaim] ************
changed: [localhost]

TASK [common : KubeSphere | Setting es data pv size] ***************************
skipping: [localhost]

TASK [KubeSphere | Creating common component manifests] ************************
changed: [localhost] => (item={'path': 'redis', 'file': 'redis.yaml'})

TASK [common : KubeSphere | Deploying etcd and mysql] **************************
skipping: [localhost] => (item=etcd.yaml)
skipping: [localhost] => (item=mysql.yaml)

TASK [common : KubeSphere | Getting minio installation files] ******************
skipping: [localhost] => (item=minio-ha)

TASK [common : KubeSphere | Creating manifests] ********************************
skipping: [localhost] => (item={'name': 'custom-values-minio', 'file': 'custom-values-minio.yaml'})

TASK [common : KubeSphere | Checking minio] ************************************
skipping: [localhost]

TASK [common : KubeSphere | Deploying minio] ***********************************
skipping: [localhost]

TASK [common : debug] **********************************************************
skipping: [localhost]

TASK [common : fail] ***********************************************************
skipping: [localhost]

TASK [common : KubeSphere | Importing minio status] ****************************
skipping: [localhost]

TASK [common : KubeSphere | Generet Random password] ***************************
skipping: [localhost]

TASK [common : KubeSphere | Creating Redis Password Secret] ********************
skipping: [localhost]

TASK [common : KubeSphere | Getting redis installation files] ******************
skipping: [localhost] => (item=redis-ha)

TASK [common : KubeSphere | Creating manifests] ********************************
skipping: [localhost] => (item={'name': 'custom-values-redis', 'file': 'custom-values-redis.yaml'})

TASK [common : KubeSphere | Checking old redis status] *************************
skipping: [localhost]

TASK [common : KubeSphere | Deleting and backup old redis svc] *****************
skipping: [localhost]

TASK [common : KubeSphere | Deploying redis] ***********************************
skipping: [localhost]

TASK [common : KubeSphere | Deploying redis] ***********************************
skipping: [localhost] => (item=redis.yaml)

TASK [common : KubeSphere | Importing redis status] ****************************
skipping: [localhost]

TASK [common : KubeSphere | Getting openldap installation files] ***************
skipping: [localhost] => (item=openldap-ha)

TASK [common : KubeSphere | Creating manifests] ********************************
skipping: [localhost] => (item={'name': 'custom-values-openldap', 'file': 'custom-values-openldap.yaml'})

TASK [common : KubeSphere | Checking old openldap status] **********************
skipping: [localhost]

TASK [common : KubeSphere | Shutdown ks-account] *******************************
skipping: [localhost]

TASK [common : KubeSphere | Deleting and backup old openldap svc] **************
skipping: [localhost]

TASK [common : KubeSphere | Checking openldap] *********************************
skipping: [localhost]

TASK [common : KubeSphere | Deploying openldap] ********************************
skipping: [localhost]

TASK [common : KubeSphere | Loading old openldap data] *************************
skipping: [localhost]

TASK [common : KubeSphere | Checking openldap-ha status] ***********************
skipping: [localhost]

TASK [common : KubeSphere | Getting openldap-ha pod list] **********************
skipping: [localhost]

TASK [common : KubeSphere | Getting old openldap data] *************************
skipping: [localhost]

TASK [common : KubeSphere | Migrating openldap data] ***************************
skipping: [localhost]

TASK [common : KubeSphere | Disabling old openldap] ****************************
skipping: [localhost]

TASK [common : KubeSphere | Restarting openldap] *******************************
skipping: [localhost]

TASK [common : KubeSphere | Restarting ks-account] *****************************
skipping: [localhost]

TASK [common : KubeSphere | Importing openldap status] *************************
skipping: [localhost]

TASK [common : KubeSphere | Generet Random password] ***************************
ok: [localhost]

TASK [common : KubeSphere | Creating Redis Password Secret] ********************
changed: [localhost]

TASK [common : KubeSphere | Getting redis installation files] ******************
changed: [localhost] => (item=redis-ha)

TASK [common : KubeSphere | Creating manifests] ********************************
changed: [localhost] => (item={'name': 'custom-values-redis', 'file': 'custom-values-redis.yaml'})

TASK [common : KubeSphere | Checking old redis status] *************************
changed: [localhost]

TASK [common : KubeSphere | Deleting and backup old redis svc] *****************
skipping: [localhost]

TASK [common : KubeSphere | Deploying redis] ***********************************
changed: [localhost]

TASK [common : KubeSphere | Deploying redis] ***********************************
skipping: [localhost] => (item=redis.yaml)

TASK [common : KubeSphere | Importing redis status] ****************************
changed: [localhost]

TASK [common : KubeSphere | Getting openldap installation files] ***************
skipping: [localhost] => (item=openldap-ha)

TASK [common : KubeSphere | Creating manifests] ********************************
skipping: [localhost] => (item={'name': 'custom-values-openldap', 'file': 'custom-values-openldap.yaml'})

TASK [common : KubeSphere | Checking old openldap status] **********************
skipping: [localhost]

TASK [common : KubeSphere | Shutdown ks-account] *******************************
skipping: [localhost]

TASK [common : KubeSphere | Deleting and backup old openldap svc] **************
skipping: [localhost]

TASK [common : KubeSphere | Checking openldap] *********************************
skipping: [localhost]

TASK [common : KubeSphere | Deploying openldap] ********************************
skipping: [localhost]

TASK [common : KubeSphere | Loading old openldap data] *************************
skipping: [localhost]

TASK [common : KubeSphere | Checking openldap-ha status] ***********************
skipping: [localhost]

TASK [common : KubeSphere | Getting openldap-ha pod list] **********************
skipping: [localhost]

TASK [common : KubeSphere | Getting old openldap data] *************************
skipping: [localhost]

TASK [common : KubeSphere | Migrating openldap data] ***************************
skipping: [localhost]

TASK [common : KubeSphere | Disabling old openldap] ****************************
skipping: [localhost]

TASK [common : KubeSphere | Restarting openldap] *******************************
skipping: [localhost]

TASK [common : KubeSphere | Restarting ks-account] *****************************
skipping: [localhost]

TASK [common : KubeSphere | Importing openldap status] *************************
skipping: [localhost]

TASK [common : KubeSphere | Getting minio installation files] ******************
skipping: [localhost] => (item=minio-ha)

TASK [common : KubeSphere | Creating manifests] ********************************
skipping: [localhost] => (item={'name': 'custom-values-minio', 'file': 'custom-values-minio.yaml'})

TASK [common : KubeSphere | Checking minio] ************************************
skipping: [localhost]

TASK [common : KubeSphere | Deploying minio] ***********************************
skipping: [localhost]

TASK [common : debug] **********************************************************
skipping: [localhost]

TASK [common : fail] ***********************************************************
skipping: [localhost]

TASK [common : KubeSphere | Importing minio status] ****************************
skipping: [localhost]

TASK [common : KubeSphere | Getting elasticsearch and curator installation files] ***
skipping: [localhost]

TASK [common : KubeSphere | Creating custom manifests] *************************
skipping: [localhost] => (item={'name': 'custom-values-elasticsearch', 'file': 'custom-values-elasticsearch.yaml'})
skipping: [localhost] => (item={'name': 'custom-values-elasticsearch-curator', 'file': 'custom-values-elasticsearch-curator.yaml'})

TASK [common : KubeSphere | Checking elasticsearch data StatefulSet] ***********
skipping: [localhost]

TASK [common : KubeSphere | Checking elasticsearch storageclass] ***************
skipping: [localhost]

TASK [common : KubeSphere | Commenting elasticsearch storageclass parameter] ***
skipping: [localhost]

TASK [common : KubeSphere | Creating elasticsearch credentials secret] *********
skipping: [localhost]

TASK [common : KubeSphere | Checking internal es] ******************************
skipping: [localhost]

TASK [common : KubeSphere | Deploying elasticsearch-logging] *******************
skipping: [localhost]

TASK [common : KubeSphere | Getting PersistentVolume Name] *********************
skipping: [localhost]

TASK [common : KubeSphere | Patching PersistentVolume (persistentVolumeReclaimPolicy)] ***
skipping: [localhost]

TASK [common : KubeSphere | Deleting elasticsearch] ****************************
skipping: [localhost]

TASK [common : KubeSphere | Waiting for seconds] *******************************
skipping: [localhost]

TASK [common : KubeSphere | Deploying elasticsearch-logging] *******************
skipping: [localhost]

TASK [common : KubeSphere | Importing es status] *******************************
skipping: [localhost]

TASK [common : KubeSphere | Deploying elasticsearch-logging-curator] ***********
skipping: [localhost]

TASK [common : KubeSphere | Getting fluentbit installation files] **************
skipping: [localhost]

TASK [common : KubeSphere | Creating custom manifests] *************************
skipping: [localhost] => (item={'path': 'fluentbit', 'file': 'custom-fluentbit-fluentBit.yaml'})
skipping: [localhost] => (item={'path': 'init', 'file': 'custom-fluentbit-operator-deployment.yaml'})

TASK [common : KubeSphere | Preparing fluentbit operator setup] ****************
skipping: [localhost]

TASK [common : KubeSphere | Deploying new fluentbit operator] ******************
skipping: [localhost]

TASK [common : KubeSphere | Importing fluentbit status] ************************
skipping: [localhost]

TASK [common : Setting persistentVolumeReclaimPolicy (mysql)] ******************
skipping: [localhost]

TASK [common : Setting persistentVolumeReclaimPolicy (etcd)] *******************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=33   changed=27   unreachable=0    failed=0    skipped=100  rescued=0    ignored=0

[WARNING]: No inventory was parsed, only implicit localhost is available
[WARNING]: provided hosts list is empty, only localhost is available. Note that
the implicit localhost does not match 'all'

PLAY [localhost] ***************************************************************

TASK [download : Generating images list] ***************************************
skipping: [localhost]

TASK [download : Synchronizing images] *****************************************

TASK [kubesphere-defaults : KubeSphere | Setting images' namespace override] ***
skipping: [localhost]

TASK [kubesphere-defaults : KubeSphere | Configuring defaults] *****************
ok: [localhost] => {
    "msg": "Check roles/kubesphere-defaults/defaults/main.yml"
}

TASK [ks-core/init-token : KubeSphere | Creating KubeSphere directory] *********
ok: [localhost]

TASK [ks-core/init-token : KubeSphere | Getting installation init files] *******
changed: [localhost] => (item=jwt-script)

TASK [ks-core/init-token : KubeSphere | Creating KubeSphere Secret] ************
changed: [localhost]

TASK [ks-core/init-token : KubeSphere | Creating KubeSphere Secret] ************
ok: [localhost]

TASK [ks-core/init-token : KubeSphere | Creating KubeSphere Secret] ************
skipping: [localhost]

TASK [ks-core/init-token : KubeSphere | Enabling Token Script] *****************
changed: [localhost]

TASK [ks-core/init-token : KubeSphere | Getting KubeSphere Token] **************
changed: [localhost]

TASK [ks-core/init-token : KubeSphere | Checking KubeSphere secrets] ***********
changed: [localhost]

TASK [ks-core/init-token : KubeSphere | Deleting KubeSphere secret] ************
skipping: [localhost]

TASK [ks-core/init-token : KubeSphere | Creating components token] *************
changed: [localhost]

TASK [ks-core/ks-core : KubeSphere | Setting Kubernetes version] ***************
ok: [localhost]

TASK [ks-core/ks-core : KubeSphere | Getting Kubernetes master num] ************
changed: [localhost]

TASK [ks-core/ks-core : KubeSphere | Setting master num] ***********************
ok: [localhost]

TASK [ks-core/ks-core : KubeSphere | Override master num] **********************
skipping: [localhost]

TASK [ks-core/ks-core : KubeSphere | Setting enableHA] *************************
ok: [localhost]

TASK [ks-core/ks-core : KubeSphere | Checking ks-core Helm Release] ************
changed: [localhost]

TASK [ks-core/ks-core : KubeSphere | Checking ks-core Exsit] *******************
changed: [localhost]

TASK [ks-core/ks-core : KubeSphere | Convert ks-core to helm mananged] *********
skipping: [localhost] => (item={'ns': 'kubesphere-controls-system', 'kind': 'serviceaccounts', 'resource': 'kubesphere-cluster-admin', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-controls-system', 'kind': 'serviceaccounts', 'resource': 'kubesphere-router-serviceaccount', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-controls-system', 'kind': 'role', 'resource': 'system:kubesphere-router-role', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-controls-system', 'kind': 'rolebinding', 'resource': 'nginx-ingress-role-nisa-binding', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-controls-system', 'kind': 'deployment', 'resource': 'default-http-backend', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-controls-system', 'kind': 'service', 'resource': 'default-http-backend', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-system', 'kind': 'secrets', 'resource': 'ks-controller-manager-webhook-cert', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-system', 'kind': 'serviceaccounts', 'resource': 'kubesphere', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-system', 'kind': 'configmaps', 'resource': 'ks-console-config', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-system', 'kind': 'configmaps', 'resource': 'ks-router-config', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-system', 'kind': 'configmaps', 'resource': 'sample-bookinfo', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-system', 'kind': 'clusterroles', 'resource': 'system:kubesphere-router-clusterrole', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-system', 'kind': 'clusterrolebindings', 'resource': 'system:nginx-ingress-clusterrole-nisa-binding', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-system', 'kind': 'clusterrolebindings', 'resource': 'system:kubesphere-cluster-admin', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-system', 'kind': 'clusterrolebindings', 'resource': 'kubesphere', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-system', 'kind': 'services', 'resource': 'ks-apiserver', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-system', 'kind': 'services', 'resource': 'ks-console', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-system', 'kind': 'services', 'resource': 'ks-controller-manager', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-system', 'kind': 'deployments', 'resource': 'ks-apiserver', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-system', 'kind': 'deployments', 'resource': 'ks-console', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-system', 'kind': 'deployments', 'resource': 'ks-controller-manager', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-system', 'kind': 'validatingwebhookconfigurations', 'resource': 'users.iam.kubesphere.io', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-system', 'kind': 'validatingwebhookconfigurations', 'resource': 'resourcesquotas.quota.kubesphere.io', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-system', 'kind': 'validatingwebhookconfigurations', 'resource': 'network.kubesphere.io', 'release': 'ks-core'})
skipping: [localhost] => (item={'ns': 'kubesphere-system', 'kind': 'users.iam.kubesphere.io', 'resource': 'admin', 'release': 'ks-core'})

TASK [ks-core/ks-core : KubeSphere | Patch admin user] *************************
skipping: [localhost]

TASK [ks-core/ks-core : KubeSphere | Getting ks-core helm charts] **************
changed: [localhost] => (item=ks-core)

TASK [ks-core/ks-core : KubeSphere | Creating manifests] ***********************
changed: [localhost] => (item={'path': 'ks-core', 'file': 'custom-values-ks-core.yaml'})

TASK [ks-core/ks-core : KubeSphere | Upgrade CRDs] *****************************
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/app_v1beta1_application.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/application.kubesphere.io_helmapplications.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/application.kubesphere.io_helmapplicationversions.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/application.kubesphere.io_helmcategories.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/application.kubesphere.io_helmreleases.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/application.kubesphere.io_helmrepos.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/cluster.kubesphere.io_clusters.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/gateway.kubesphere.io_gateways.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/gateway.kubesphere.io_nginxes.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/iam.kubesphere.io_federatedrolebindings.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/iam.kubesphere.io_federatedroles.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/iam.kubesphere.io_federatedusers.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/iam.kubesphere.io_globalrolebindings.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/iam.kubesphere.io_globalroles.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/iam.kubesphere.io_groupbindings.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/iam.kubesphere.io_groups.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/iam.kubesphere.io_loginrecords.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/iam.kubesphere.io_rolebases.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/iam.kubesphere.io_users.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/iam.kubesphere.io_workspacerolebindings.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/iam.kubesphere.io_workspaceroles.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/network.kubesphere.io_ipamblocks.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/network.kubesphere.io_ipamhandles.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/network.kubesphere.io_ippools.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/network.kubesphere.io_namespacenetworkpolicies.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/quota.kubesphere.io_resourcequotas.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/servicemesh.kubesphere.io_servicepolicies.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/servicemesh.kubesphere.io_strategies.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/tenant.kubesphere.io_workspaces.yaml)
changed: [localhost] => (item=/kubesphere/kubesphere/ks-core/crds/tenant.kubesphere.io_workspacetemplates.yaml)

TASK [ks-core/ks-core : KubeSphere | Creating ks-core] *************************
changed: [localhost]

TASK [ks-core/ks-core : KubeSphere | Importing ks-core status] *****************
changed: [localhost]

TASK [ks-core/prepare : KubeSphere | Checking core components (1)] *************
changed: [localhost]

TASK [ks-core/prepare : KubeSphere | Checking core components (2)] *************
changed: [localhost]

TASK [ks-core/prepare : KubeSphere | Checking core components (3)] *************
skipping: [localhost]

TASK [ks-core/prepare : KubeSphere | Checking core components (4)] *************
skipping: [localhost]

TASK [ks-core/prepare : KubeSphere | Updating ks-core status] ******************
skipping: [localhost]

TASK [ks-core/prepare : set_fact] **********************************************
skipping: [localhost]

TASK [ks-core/prepare : KubeSphere | Creating KubeSphere directory] ************
ok: [localhost]

TASK [ks-core/prepare : KubeSphere | Getting installation init files] **********
changed: [localhost] => (item=ks-init)

TASK [ks-core/prepare : KubeSphere | Initing KubeSphere] ***********************
changed: [localhost] => (item=role-templates.yaml)

TASK [ks-core/prepare : KubeSphere | Generating kubeconfig-admin] **************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=25   changed=18   unreachable=0    failed=0    skipped=13   rescued=0    ignored=0

Start installing monitoring
Start installing multicluster
Start installing openpitrix
Start installing network
**************************************************
Waiting for all tasks to be completed ...
task network status is successful  (1/4)
task openpitrix status is successful  (2/4)
task multicluster status is successful  (3/4)
task monitoring status is successful  (4/4)
**************************************************
Collecting installation results ...
#####################################################
###              Welcome to KubeSphere!           ###
#####################################################

Console: http://10.11.10.100:30880
Account: admin
Password: P@88w0rd

NOTES：
  1. After you log into the console, please check the
     monitoring status of service components in
     "Cluster Management". If any service is not
     ready, please wait patiently until all components
     are up and running.
  2. Please change the default password after login.

#####################################################
https://kubesphere.io             2022-04-25 17:19:02
#####################################################
~~~

