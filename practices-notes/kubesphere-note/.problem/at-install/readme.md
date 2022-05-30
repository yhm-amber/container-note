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

----

@xyz-li :  
Can you provide the log of redis-ha-proxy?

----

> Can you provide the log of redis-ha-proxy?

The `running` of one of the `redis-ha-proxy` pod, was over in the blink of an eye.

so, may be difficult ... to get a log ... (or have some way I don't know ?)

~~~ text
[root@e2 ~]# kubectl -n kubesphere-system get po
NAME                                READY   STATUS             RESTARTS   AGE
ks-installer-85dcfff87d-wpd7p       1/1     Running            1          4d15h
redis-ha-haproxy-7d6d8885cc-b4c5g   0/1     CrashLoopBackOff   2270       4d15h
redis-ha-haproxy-7d6d8885cc-hkzz9   0/1     CrashLoopBackOff   1177       2d12h
redis-ha-haproxy-7d6d8885cc-rd7qd   0/1     CrashLoopBackOff   482        24h
redis-ha-server-0                   0/2     Pending            0          4d15h
[root@e2 ~]# kubectl -n kubesphere-system get po
NAME                                READY   STATUS             RESTARTS   AGE
ks-installer-85dcfff87d-wpd7p       1/1     Running            1          4d15h
redis-ha-haproxy-7d6d8885cc-b4c5g   0/1     CrashLoopBackOff   2270       4d15h
redis-ha-haproxy-7d6d8885cc-hkzz9   0/1     CrashLoopBackOff   1177       2d12h
redis-ha-haproxy-7d6d8885cc-rd7qd   1/1     Running            483        24h
redis-ha-server-0                   0/2     Pending            0          4d15h
[root@e2 ~]# kubectl logs -n kubesphere-system -- redis-ha-haproxy-7d6d8885cc-rd7qd
[root@e2 ~]# kubectl -n kubesphere-system get po
NAME                                READY   STATUS             RESTARTS   AGE
ks-installer-85dcfff87d-wpd7p       1/1     Running            1          4d15h
redis-ha-haproxy-7d6d8885cc-b4c5g   0/1     CrashLoopBackOff   2270       4d15h
redis-ha-haproxy-7d6d8885cc-hkzz9   0/1     CrashLoopBackOff   1177       2d12h
redis-ha-haproxy-7d6d8885cc-rd7qd   0/1     CrashLoopBackOff   484        24h
redis-ha-server-0                   0/2     Pending            0          4d15h
[root@e2 ~]# kubectl logs -f -n kubesphere-system -- redis-ha-haproxy-7d6d8885cc-rd7qd
[root@e2 ~]# 
~~~

----

@xyz-li :  

`kubectl -n kubesphere-system get po redis-ha-haproxy-7d6d8885cc-rd7qd -oyaml`

Why `redis-ha-server-0` is in pending state?

----

> `kubectl -n kubesphere-system get po redis-ha-haproxy-7d6d8885cc-rd7qd -oyaml`

<details>

<summary>out</summary>

~~~ yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    checksum/config: 1ee7a49ef4d254e0475df5375135569b1e4b7a22ee4b8d435c9ca901144a4cf7
    cni.projectcalico.org/podIP: 100.99.106.212/32
    cni.projectcalico.org/podIPs: 100.99.106.212/32
    prometheus.io/path: /metrics
    prometheus.io/port: "9101"
    prometheus.io/scrape: "true"
  creationTimestamp: "2022-05-29T02:20:05Z"
  generateName: redis-ha-haproxy-7d6d8885cc-
  labels:
    app: redis-ha-haproxy
    pod-template-hash: 7d6d8885cc
    release: ks-redis
  managedFields:
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:status:
        f:conditions:
          .: {}
          k:{"type":"PodScheduled"}:
            .: {}
            f:lastProbeTime: {}
            f:lastTransitionTime: {}
            f:message: {}
            f:reason: {}
            f:status: {}
            f:type: {}
    manager: kube-scheduler
    operation: Update
    time: "2022-05-29T02:20:05Z"
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:metadata:
        f:annotations:
          f:cni.projectcalico.org/podIP: {}
          f:cni.projectcalico.org/podIPs: {}
    manager: calico
    operation: Update
    time: "2022-05-29T02:20:38Z"
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:metadata:
        f:annotations:
          .: {}
          f:checksum/config: {}
          f:prometheus.io/path: {}
          f:prometheus.io/port: {}
          f:prometheus.io/scrape: {}
        f:generateName: {}
        f:labels:
          .: {}
          f:app: {}
          f:pod-template-hash: {}
          f:release: {}
        f:ownerReferences:
          .: {}
          k:{"uid":"71ceb856-446a-4c93-8dc1-0145d57f0ebd"}:
            .: {}
            f:apiVersion: {}
            f:blockOwnerDeletion: {}
            f:controller: {}
            f:kind: {}
            f:name: {}
            f:uid: {}
      f:spec:
        f:affinity:
          .: {}
          f:nodeAffinity:
            .: {}
            f:preferredDuringSchedulingIgnoredDuringExecution: {}
          f:podAntiAffinity:
            .: {}
            f:requiredDuringSchedulingIgnoredDuringExecution: {}
        f:containers:
          k:{"name":"haproxy"}:
            .: {}
            f:image: {}
            f:imagePullPolicy: {}
            f:livenessProbe:
              .: {}
              f:failureThreshold: {}
              f:httpGet:
                .: {}
                f:path: {}
                f:port: {}
                f:scheme: {}
              f:initialDelaySeconds: {}
              f:periodSeconds: {}
              f:successThreshold: {}
              f:timeoutSeconds: {}
            f:name: {}
            f:ports:
              .: {}
              k:{"containerPort":6379,"protocol":"TCP"}:
                .: {}
                f:containerPort: {}
                f:name: {}
                f:protocol: {}
            f:resources: {}
            f:terminationMessagePath: {}
            f:terminationMessagePolicy: {}
            f:volumeMounts:
              .: {}
              k:{"mountPath":"/run/haproxy"}:
                .: {}
                f:mountPath: {}
                f:name: {}
              k:{"mountPath":"/usr/local/etc/haproxy"}:
                .: {}
                f:mountPath: {}
                f:name: {}
        f:dnsPolicy: {}
        f:enableServiceLinks: {}
        f:initContainers:
          .: {}
          k:{"name":"config-init"}:
            .: {}
            f:args: {}
            f:command: {}
            f:env:
              .: {}
              k:{"name":"AUTH"}:
                .: {}
                f:name: {}
                f:valueFrom:
                  .: {}
                  f:secretKeyRef:
                    .: {}
                    f:key: {}
                    f:name: {}
            f:image: {}
            f:imagePullPolicy: {}
            f:name: {}
            f:resources: {}
            f:terminationMessagePath: {}
            f:terminationMessagePolicy: {}
            f:volumeMounts:
              .: {}
              k:{"mountPath":"/data"}:
                .: {}
                f:mountPath: {}
                f:name: {}
              k:{"mountPath":"/readonly"}:
                .: {}
                f:mountPath: {}
                f:name: {}
                f:readOnly: {}
        f:restartPolicy: {}
        f:schedulerName: {}
        f:securityContext:
          .: {}
          f:fsGroup: {}
          f:runAsNonRoot: {}
          f:runAsUser: {}
        f:serviceAccount: {}
        f:serviceAccountName: {}
        f:terminationGracePeriodSeconds: {}
        f:tolerations: {}
        f:volumes:
          .: {}
          k:{"name":"config-volume"}:
            .: {}
            f:configMap:
              .: {}
              f:defaultMode: {}
              f:name: {}
            f:name: {}
          k:{"name":"data"}:
            .: {}
            f:emptyDir: {}
            f:name: {}
          k:{"name":"shared-socket"}:
            .: {}
            f:emptyDir: {}
            f:name: {}
    manager: kube-controller-manager
    operation: Update
    time: "2022-05-30T01:28:14Z"
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:status:
        f:conditions:
          k:{"type":"ContainersReady"}:
            .: {}
            f:lastProbeTime: {}
            f:lastTransitionTime: {}
            f:message: {}
            f:reason: {}
            f:status: {}
            f:type: {}
          k:{"type":"Initialized"}:
            .: {}
            f:lastProbeTime: {}
            f:lastTransitionTime: {}
            f:status: {}
            f:type: {}
          k:{"type":"Ready"}:
            .: {}
            f:lastProbeTime: {}
            f:lastTransitionTime: {}
            f:message: {}
            f:reason: {}
            f:status: {}
            f:type: {}
        f:containerStatuses: {}
        f:hostIP: {}
        f:initContainerStatuses: {}
        f:phase: {}
        f:podIP: {}
        f:podIPs:
          .: {}
          k:{"ip":"100.99.106.212"}:
            .: {}
            f:ip: {}
        f:startTime: {}
    manager: kubelet
    operation: Update
    time: "2022-05-30T04:01:56Z"
  name: redis-ha-haproxy-7d6d8885cc-rd7qd
  namespace: kubesphere-system
  ownerReferences:
  - apiVersion: apps/v1
    blockOwnerDeletion: true
    controller: true
    kind: ReplicaSet
    name: redis-ha-haproxy-7d6d8885cc
    uid: 71ceb856-446a-4c93-8dc1-0145d57f0ebd
  resourceVersion: "1387362"
  selfLink: /api/v1/namespaces/kubesphere-system/pods/redis-ha-haproxy-7d6d8885cc-rd7qd
  uid: b15f1834-f3d5-41e1-9d31-177fbe8c7bfc
spec:
  affinity:
    nodeAffinity:
      preferredDuringSchedulingIgnoredDuringExecution:
      - preference:
          matchExpressions:
          - key: node-role.kubernetes.io/master
            operator: In
            values:
            - ""
        weight: 100
    podAntiAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchLabels:
            app: redis-ha-haproxy
            release: ks-redis
        topologyKey: kubernetes.io/hostname
  containers:
  - image: haproxy:2.0.25-alpine
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 3
      httpGet:
        path: /healthz
        port: 8888
        scheme: HTTP
      initialDelaySeconds: 5
      periodSeconds: 3
      successThreshold: 1
      timeoutSeconds: 1
    name: haproxy
    ports:
    - containerPort: 6379
      name: redis
      protocol: TCP
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /usr/local/etc/haproxy
      name: data
    - mountPath: /run/haproxy
      name: shared-socket
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: redis-ha-haproxy-token-jx8zw
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  initContainers:
  - args:
    - /readonly/haproxy_init.sh
    command:
    - sh
    env:
    - name: AUTH
      valueFrom:
        secretKeyRef:
          key: auth
          name: redis-secret
    image: haproxy:2.0.25-alpine
    imagePullPolicy: IfNotPresent
    name: config-init
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /readonly
      name: config-volume
      readOnly: true
    - mountPath: /data
      name: data
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: redis-ha-haproxy-token-jx8zw
      readOnly: true
  nodeName: e1
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext:
    fsGroup: 1000
    runAsNonRoot: true
    runAsUser: 1000
  serviceAccount: redis-ha-haproxy
  serviceAccountName: redis-ha-haproxy
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoSchedule
    key: node-role.kubernetes.io/master
  - key: CriticalAddonsOnly
    operator: Exists
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 60
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 60
  volumes:
  - configMap:
      defaultMode: 420
      name: redis-ha-configmap
    name: config-volume
  - emptyDir: {}
    name: shared-socket
  - emptyDir: {}
    name: data
  - name: redis-ha-haproxy-token-jx8zw
    secret:
      defaultMode: 420
      secretName: redis-ha-haproxy-token-jx8zw
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2022-05-29T02:20:38Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2022-05-30T04:01:56Z"
    message: 'containers with unready status: [haproxy]'
    reason: ContainersNotReady
    status: "False"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2022-05-30T04:01:56Z"
    message: 'containers with unready status: [haproxy]'
    reason: ContainersNotReady
    status: "False"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2022-05-29T02:20:37Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: docker://2791692d1857ca33632ab497cd8aca5b6094750d091af4c7bdb12efc3b2ed383
    image: haproxy:2.0.25-alpine
    imageID: docker-pullable://haproxy@sha256:c227af474f83308a1ca187c9eac750ae04d6f4f83a63ec8ae793915ad5338419
    lastState:
      terminated:
        containerID: docker://2791692d1857ca33632ab497cd8aca5b6094750d091af4c7bdb12efc3b2ed383
        exitCode: 137
        finishedAt: "2022-05-30T04:01:53Z"
        reason: Error
        startedAt: "2022-05-30T04:01:38Z"
    name: haproxy
    ready: false
    restartCount: 518
    started: false
    state:
      waiting:
        message: back-off 5m0s restarting failed container=haproxy pod=redis-ha-haproxy-7d6d8885cc-rd7qd_kubesphere-system(b15f1834-f3d5-41e1-9d31-177fbe8c7bfc)
        reason: CrashLoopBackOff
  hostIP: 10.28.3.71
  initContainerStatuses:
  - containerID: docker://0e0fcdba1683b57c7572bc79f584dd26770595b61327debcaeccb84c8f82dd0c
    image: haproxy:2.0.25-alpine
    imageID: docker-pullable://haproxy@sha256:c227af474f83308a1ca187c9eac750ae04d6f4f83a63ec8ae793915ad5338419
    lastState: {}
    name: config-init
    ready: true
    restartCount: 0
    state:
      terminated:
        containerID: docker://0e0fcdba1683b57c7572bc79f584dd26770595b61327debcaeccb84c8f82dd0c
        exitCode: 0
        finishedAt: "2022-05-29T02:20:38Z"
        reason: Completed
        startedAt: "2022-05-29T02:20:38Z"
  phase: Running
  podIP: 100.99.106.212
  podIPs:
  - ip: 100.99.106.212
  qosClass: BestEffort
  startTime: "2022-05-29T02:20:37Z"
~~~

</details>

> Why `redis-ha-server-0` is in pending state?

let me have a look ...

~~~ test
  Warning  FailedScheduling  3h13m  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3h6m   default-scheduler  0/3 nodes are available: 1 node(s) had taint {node.kubernetes.io/unreachable: }, that the pod didn't tolerate, 2 node(s) didn't find available persistent volumes to bind.
  Warning  FailedScheduling  3h6m   default-scheduler  0/3 nodes are available: 1 node(s) had taint {node.kubernetes.io/unreachable: }, that the pod didn't tolerate, 2 node(s) didn't find available persistent volumes to bind.
  Warning  FailedScheduling  164m   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  144m   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  125m   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  115m   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  105m   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  85m    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  18m    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  13s    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
~~~

it says `Failed to bind volumes` a lot at Events !!

but I have a default sc ....

~~~ text
[root@e2 ~]# kubectl get sc
NAME                         PROVISIONER        RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
openebs-device               openebs.io/local   Delete          WaitForFirstConsumer   false                  4d17h
openebs-hostpath (default)   openebs.io/local   Delete          WaitForFirstConsumer   false                  4d17h
~~~

<details>

<summary>full</summary>

~~~~ text
[root@e2 ~]# kubectl describe pod redis-ha-server-0 -n kubesphere-system
Name:           redis-ha-server-0
Namespace:      kubesphere-system
Priority:       0
Node:           <none>
Labels:         app=redis-ha
                controller-revision-hash=redis-ha-server-66dbd66ff5
                release=ks-redis
                statefulset.kubernetes.io/pod-name=redis-ha-server-0
Annotations:    checksum/init-config: efc969316f5059d6fc477f70dff4788654fd0b0685a4e7c806e9f1518771c9de
Status:         Pending
IP:
IPs:            <none>
Controlled By:  StatefulSet/redis-ha-server
Init Containers:
  config-init:
    Image:      redis:5.0.14-alpine
    Port:       <none>
    Host Port:  <none>
    Command:
      sh
    Args:
      /readonly-config/init.sh
    Environment:
      SENTINEL_ID_0:  76570abc73c20d3c0e6c21105777ed9b0898cb75
      SENTINEL_ID_1:  0c5b5dae5039679890d11c4d6b6fb66a08625c08
      SENTINEL_ID_2:  0b174d8f2a622ce4e7f303c67ce788c35729251d
      AUTH:           <set to the key 'auth' in secret 'redis-secret'>  Optional: false
    Mounts:
      /data from data (rw)
      /readonly-config from config (ro)
      /var/run/secrets/kubernetes.io/serviceaccount from redis-ha-token-gl98v (ro)
Containers:
  redis:
    Image:      redis:5.0.14-alpine
    Port:       6379/TCP
    Host Port:  0/TCP
    Command:
      redis-server
    Args:
      /data/conf/redis.conf
    Liveness:  tcp-socket :6379 delay=15s timeout=1s period=10s #success=1 #failure=3
    Environment:
      AUTH:  <set to the key 'auth' in secret 'redis-secret'>  Optional: false
    Mounts:
      /data from data (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from redis-ha-token-gl98v (ro)
  sentinel:
    Image:      redis:5.0.14-alpine
    Port:       26379/TCP
    Host Port:  0/TCP
    Command:
      redis-sentinel
    Args:
      /data/conf/sentinel.conf
    Liveness:  tcp-socket :26379 delay=15s timeout=1s period=10s #success=1 #failure=3
    Environment:
      AUTH:  <set to the key 'auth' in secret 'redis-secret'>  Optional: false
    Mounts:
      /data from data (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from redis-ha-token-gl98v (ro)
Conditions:
  Type           Status
  PodScheduled   False
Volumes:
  data:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  data-redis-ha-server-0
    ReadOnly:   false
  config:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      redis-ha-configmap
    Optional:  false
  redis-ha-token-gl98v:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  redis-ha-token-gl98v
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     CriticalAddonsOnly op=Exists
                 node-role.kubernetes.io/master:NoSchedule
                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                 node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason            Age    From               Message
  ----     ------            ----   ----               -------
  Warning  FailedScheduling  4d16h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d16h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d16h  default-scheduler  0/3 nodes are available: 1 node(s) had taint {node.kubernetes.io/unreachable: }, that the pod didn't tolerate, 2 node(s) didn't find available persistent volumes to bind.
  Warning  FailedScheduling  4d15h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d15h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d15h  default-scheduler  0/3 nodes are available: 1 node(s) had taint {node.kubernetes.io/unreachable: }, that the pod didn't tolerate, 2 node(s) didn't find available persistent volumes to bind.
  Warning  FailedScheduling  4d14h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d14h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d13h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d12h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d12h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d12h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d11h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d11h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d11h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d10h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d10h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d9h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d9h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d7h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d7h   default-scheduler  0/3 nodes are available: 1 node(s) had taint {node.kubernetes.io/unreachable: }, that the pod didn't tolerate, 2 node(s) didn't find available persistent volumes to bind.
  Warning  FailedScheduling  4d7h   default-scheduler  0/3 nodes are available: 1 node(s) had taint {node.kubernetes.io/unreachable: }, that the pod didn't tolerate, 2 node(s) didn't find available persistent volumes to bind.
  Warning  FailedScheduling  4d7h   default-scheduler  0/3 nodes are available: 1 node(s) had taint {node.kubernetes.io/unreachable: }, that the pod didn't tolerate, 2 node(s) didn't find available persistent volumes to bind.
  Warning  FailedScheduling  4d6h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d5h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d2h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d2h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d1h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d1h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d1h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d     default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4d     default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d22h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d22h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d21h  default-scheduler  0/3 nodes are available: 1 node(s) had taint {node.kubernetes.io/unreachable: }, that the pod didn't tolerate, 2 node(s) didn't find available persistent volumes to bind.
  Warning  FailedScheduling  3d21h  default-scheduler  0/3 nodes are available: 1 node(s) had taint {node.kubernetes.io/unreachable: }, that the pod didn't tolerate, 2 node(s) didn't find available persistent volumes to bind.
  Warning  FailedScheduling  3d19h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d17h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d17h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d17h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d16h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d16h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d16h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d15h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d15h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d15h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d14h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d14h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d13h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d13h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d13h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d13h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d12h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d12h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d12h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d12h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d10h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d10h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d10h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d9h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d9h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d8h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d8h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d8h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d7h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d7h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d6h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d6h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d6h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d5h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d5h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d5h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d4h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d4h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d4h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d3h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d3h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d3h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d3h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d2h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d2h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d1h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d1h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d     default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3d     default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d23h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d23h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d22h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d22h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d22h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d22h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d21h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d21h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d21h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d20h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d20h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d20h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d20h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d19h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d19h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d19h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d19h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d18h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d18h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d18h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d17h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d17h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d16h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d16h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d15h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d15h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d14h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d14h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d14h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d14h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d13h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d13h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d12h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d12h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d12h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d12h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d12h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d11h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d10h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d10h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d10h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d10h  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d9h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d8h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d8h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d7h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d7h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d7h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d6h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d6h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d6h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d6h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d6h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d5h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d5h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d5h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d5h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d4h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d4h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d3h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d3h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d2h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d2h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d1h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d1h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d1h   default-scheduler  0/3 nodes are available: 1 node(s) had taint {node.kubernetes.io/unreachable: }, that the pod didn't tolerate, 2 node(s) didn't find available persistent volumes to bind.
  Warning  FailedScheduling  2d1h   default-scheduler  0/3 nodes are available: 1 node(s) had taint {node.kubernetes.io/unreachable: }, that the pod didn't tolerate, 2 node(s) didn't find available persistent volumes to bind.
  Warning  FailedScheduling  2d1h   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d     default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d     default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  2d     default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  47h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  47h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  47h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  46h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  46h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  45h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  44h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  43h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  43h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  43h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  43h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  43h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  42h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  42h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  42h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  41h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  41h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  41h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  41h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  40h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  40h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  40h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  40h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  39h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  39h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  39h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  38h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  38h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  38h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  37h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  37h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  36h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  36h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  36h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  35h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  35h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  35h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  34h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  34h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  33h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  33h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  32h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  32h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  32h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  31h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  31h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  30h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  29h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  29h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  29h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  29h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  28h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  28h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  28h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  28h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  27h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  27h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  27h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  27h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  26h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  26h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  26h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  25h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  25h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  25h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  25h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  24h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  24h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  24h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  23h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  23h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  22h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  22h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  21h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  21h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  21h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  21h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  21h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  20h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  20h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  19h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  19h    default-scheduler  0/3 nodes are available: 1 node(s) had taint {node.kubernetes.io/unreachable: }, that the pod didn't tolerate, 2 node(s) didn't find available persistent volumes to bind.
  Warning  FailedScheduling  19h    default-scheduler  0/3 nodes are available: 1 node(s) had taint {node.kubernetes.io/unreachable: }, that the pod didn't tolerate, 2 node(s) didn't find available persistent volumes to bind.
  Warning  FailedScheduling  18h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  18h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  17h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  17h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  16h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  16h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  15h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  14h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  14h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  14h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  13h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  13h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  13h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  13h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  12h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  12h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  12h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  11h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  11h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  11h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  11h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  10h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  10h    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  9h     default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  9h     default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  8h     default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  8h     default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  7h11m  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  6h51m  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  6h27m  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  5h51m  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  5h32m  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  5h1m   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4h23m  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  4h13m  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3h53m  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3h43m  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3h33m  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3h13m  default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  3h6m   default-scheduler  0/3 nodes are available: 1 node(s) had taint {node.kubernetes.io/unreachable: }, that the pod didn't tolerate, 2 node(s) didn't find available persistent volumes to bind.
  Warning  FailedScheduling  3h6m   default-scheduler  0/3 nodes are available: 1 node(s) had taint {node.kubernetes.io/unreachable: }, that the pod didn't tolerate, 2 node(s) didn't find available persistent volumes to bind.
  Warning  FailedScheduling  164m   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  144m   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  125m   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  115m   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  105m   default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  85m    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  18m    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
  Warning  FailedScheduling  13s    default-scheduler  error while running "VolumeBinding" prebind plugin for pod "redis-ha-server-0": Failed to bind volumes: timed out waiting for the condition
[root@e2 ~]# kubectl get sc
NAME                         PROVISIONER        RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
openebs-device               openebs.io/local   Delete          WaitForFirstConsumer   false                  4d17h
openebs-hostpath (default)   openebs.io/local   Delete          WaitForFirstConsumer   false                  4d17h
[root@e2 ~]# 
~~~~

</details>


