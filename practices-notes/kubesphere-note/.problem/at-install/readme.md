copy for issue: [Having problem(s) while install minimal-kubesphere : `Unable to connect to the server: net/http: TLS handshake timeout`](https://github.com/kubesphere/kubesphere/issues/4920)


----



**What's your question**

I'm tring to install a minimal-kubesphere by following [this page](https://kubesphere.io/docs/quick-start/minimal-kubesphere-on-k8s/) :

~~~ sh
kubectl apply -f https://github.com/kubesphere/ks-installer/releases/download/v3.2.1/kubesphere-installer.yaml
kubectl apply -f https://github.com/kubesphere/ks-installer/releases/download/v3.2.1/cluster-configuration.yaml
~~~

I know if the install done, I will get these things :

~~~ text
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

Console: http://10.xxx.xx.xxx:30880
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
https://kubesphere.io             2022-xx-xx xx:xx:xx
#####################################################
~~~

---- by a command `kubectl logs -n kubesphere-system -f -- ks-installer-85dcfff87d-wpd7p` for me .

But, I'm getting these things now 🤒 : 

![ks-in-logs-xx.png](https://github.com/yhm-amber/container-note/raw/main/practices-notes/kubesphere-note/.problem/at-install/ks-in-logs-xx.png)

And, by the app Lens , I found that these `redis-ha-haproxy` pods may have some problem : 

![p](https://github.com/yhm-amber/container-note/raw/main/practices-notes/kubesphere-note/.problem/at-install/ks-in-x.png)

They say `Node is not ready` , but my Kubernetes node is `ready` now ... (so, is the 'node' here may not means kubernetes node ? .... 🤔)

**Environment: OS & Hardware Information**

OS :

- Machine: `QEMU/KVM`
- OS: `openEuler-22.03-LTS`
- CPU: `16`
- MEM: `40960 MiB`
- OS Storage: `256 GiB`

Kubernetes :

- version: `v1.19.16`
- installer: [`sealos v3.3.9-rc.11`](https://github.com/labring/sealos/releases/tag/v3.3.9-rc.11)


**Error logs or message (Attach logs or screenshot)**

~~~ text
TASK [common : KubeSphere | Creating KubeSphere namespace] *********************
changed: [localhost] => (item=kubesphere-system)
changed: [localhost] => (item=kubesphere-controls-system)
failed: [localhost] (item=kubesphere-monitoring-system) => {"ansible_loop_var": "item", "changed": true, "cmd": ["/usr/local/bin/kubectl", "create", "namespace", "kubesphere-monitoring-system"], "delta": "0:00:11.999286", "end": "2022-05-26 18:03:16.105522", "failed_when_result": true, "item": "kubesphere-monitoring-system", "msg": "non-zero return code", "rc": 1, "start": "2022-05-26 18:03:04.106236", "stderr": "Unable to connect to the server: net/http: TLS handshake timeout", "stderr_lines": ["Unable to connect to the server: net/http: TLS handshake timeout"], "stdout": "", "stdout_lines": []}
changed: [localhost] => (item=kubesphere-monitoring-federated)

PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=1    unreachable=0    failed=1    skipped=3    rescued=0    ignored=0

~~~

<details>

<summary>see full</summary>

~~~~ text
[root@e2 ~]# kubectl logs -n kubesphere-system $(kubectl get pod -n kubesphere-system -l app=ks-install -o jsonpath='{.items[0].metadata.name}') -f
2022-05-26T18:01:59+08:00 INFO     : shell-operator latest
2022-05-26T18:01:59+08:00 INFO     : HTTP SERVER Listening on 0.0.0.0:9115
2022-05-26T18:01:59+08:00 INFO     : Use temporary dir: /tmp/shell-operator
2022-05-26T18:01:59+08:00 INFO     : Initialize hooks manager ...
2022-05-26T18:01:59+08:00 INFO     : Search and load hooks ...
2022-05-26T18:01:59+08:00 INFO     : Load hook config from '/hooks/kubesphere/installRunner.py'
2022-05-26T18:02:01+08:00 INFO     : Load hook config from '/hooks/kubesphere/schedule.sh'
2022-05-26T18:02:01+08:00 INFO     : Initializing schedule manager ...
2022-05-26T18:02:01+08:00 INFO     : KUBE Init Kubernetes client
2022-05-26T18:02:01+08:00 INFO     : KUBE-INIT Kubernetes client is configured successfully
2022-05-26T18:02:01+08:00 INFO     : MAIN: run main loop
2022-05-26T18:02:01+08:00 INFO     : MAIN: add onStartup tasks
2022-05-26T18:02:01+08:00 INFO     : Running schedule manager ...
2022-05-26T18:02:01+08:00 INFO     : QUEUE add all HookRun@OnStartup
2022-05-26T18:02:01+08:00 INFO     : MSTOR Create new metric shell_operator_live_ticks
2022-05-26T18:02:01+08:00 INFO     : MSTOR Create new metric shell_operator_tasks_queue_length
2022-05-26T18:02:02+08:00 INFO     : GVR for kind 'ClusterConfiguration' is installer.kubesphere.io/v1alpha1, Resource=clusterconfigurations
2022-05-26T18:02:02+08:00 INFO     : EVENT Kube event 'b9ec809a-8fac-43f3-9aaf-45906161de03'
2022-05-26T18:02:02+08:00 INFO     : QUEUE add TASK_HOOK_RUN@KUBE_EVENTS kubesphere/installRunner.py
2022-05-26T18:02:04+08:00 INFO     : TASK_RUN HookRun@KUBE_EVENTS kubesphere/installRunner.py
2022-05-26T18:02:04+08:00 INFO     : Running hook 'kubesphere/installRunner.py' binding 'KUBE_EVENTS' ...
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
        "kubesphere-monitoring-federated"
    ]
}

TASK [common : KubeSphere | Creating KubeSphere namespace] *********************
changed: [localhost] => (item=kubesphere-system)
changed: [localhost] => (item=kubesphere-controls-system)
failed: [localhost] (item=kubesphere-monitoring-system) => {"ansible_loop_var": "item", "changed": true, "cmd": ["/usr/local/bin/kubectl", "create", "namespace", "kubesphere-monitoring-system"], "delta": "0:00:11.999286", "end": "2022-05-26 18:03:16.105522", "failed_when_result": true, "item": "kubesphere-monitoring-system", "msg": "non-zero return code", "rc": 1, "start": "2022-05-26 18:03:04.106236", "stderr": "Unable to connect to the server: net/http: TLS handshake timeout", "stderr_lines": ["Unable to connect to the server: net/http: TLS handshake timeout"], "stdout": "", "stdout_lines": []}
changed: [localhost] => (item=kubesphere-monitoring-federated)

PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=1    unreachable=0    failed=1    skipped=3    rescued=0    ignored=0

^C
[root@e2 ~]# kubectl get svc/ks-console -n kubesphere-system
Error from server (NotFound): services "ks-console" not found
[root@e2 ~]# 
~~~~

</details>



**Installer Version**

[`https://github.com/kubesphere/ks-installer/releases/download/v3.2.1/kubesphere-installer.yaml`](https://github.com/kubesphere/ks-installer/releases/download/v3.2.1/kubesphere-installer.yaml)
