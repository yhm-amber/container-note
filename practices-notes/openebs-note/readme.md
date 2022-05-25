
## 安装

ref: https://openebs.io/docs/user-guides/quickstart

有俩途径：

- use `helm`
- use `kubectl`

选一个就好。

### use `helm`

~~~ sh
helm repo add -- openebs https://openebs.github.io/charts
# helm repo update
helm install --namespace openebs --create-namespace -- openebs openebs/openebs
~~~

out:

<pre>NAME: openebs
LAST DEPLOYED: Wed May 25 18:28:10 2022
NAMESPACE: openebs
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Successfully installed OpenEBS.

Check the status by running: kubectl get pods -n openebs

The default values will install NDM and enable OpenEBS hostpath and device
storage engines along with their default StorageClasses. Use `kubectl get sc`
to see the list of installed OpenEBS StorageClasses.

**Note**: If you are upgrading from the older helm chart that was using cStor
and Jiva (non-csi) volumes, you will have to run the following command to include
the older provisioners:

helm upgrade openebs openebs/openebs \
	--namespace openebs \
	--set legacy.enabled=true \
	--reuse-values

For other engines, you will need to perform a few more additional steps to
enable the engine, configure the engines (e.g. creating pools) and create 
StorageClasses. 

For example, cStor can be enabled using commands like:

helm upgrade openebs openebs/openebs \
	--namespace openebs \
	--set cstor.enabled=true \
	--reuse-values

For more information, 
- view the online documentation at https://openebs.io/docs or
- connect with an active community on Kubernetes slack #openebs channel.
</pre>

### use `kubectl`

~~~ sh
kubectl apply -f https://openebs.github.io/charts/openebs-operator.yaml
~~~

## 配置默认

需要配置存储类 `openebs-hostpath` 为默认。

ref: https://kubernetes.io/zh/docs/tasks/administer-cluster/change-default-storage-class/

设为默认：

~~~ sh
kubectl patch storageclass -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}' -- openebs-hostpath
~~~

验证：

~~~ sh
kubectl get storageclass
~~~

可以看到在 `openebs-hostpath` 后面有 `(default)` 就是成了。

*上面的 `storageclass` 可简写为 `sc` 。*



## rec

<pre>[root@e1 ~]# kubectl get sc
No resources found
[root@e1 ~]# helm install --namespace openebs --create-namespace -- openebs openebs/openebs
NAME: openebs
LAST DEPLOYED: Wed May 25 18:28:10 2022
NAMESPACE: openebs
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Successfully installed OpenEBS.

Check the status by running: kubectl get pods -n openebs

The default values will install NDM and enable OpenEBS hostpath and device
storage engines along with their default StorageClasses. Use `kubectl get sc`
to see the list of installed OpenEBS StorageClasses.

**Note**: If you are upgrading from the older helm chart that was using cStor
and Jiva (non-csi) volumes, you will have to run the following command to include
the older provisioners:

helm upgrade openebs openebs/openebs \
	--namespace openebs \
	--set legacy.enabled=true \
	--reuse-values

For other engines, you will need to perform a few more additional steps to
enable the engine, configure the engines (e.g. creating pools) and create 
StorageClasses. 

For example, cStor can be enabled using commands like:

helm upgrade openebs openebs/openebs \
	--namespace openebs \
	--set cstor.enabled=true \
	--reuse-values

For more information, 
- view the online documentation at https://openebs.io/docs or
- connect with an active community on Kubernetes slack #openebs channel.
[root@e1 ~]# kubectl get sc
NAME               PROVISIONER        RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
openebs-device     openebs.io/local   Delete          WaitForFirstConsumer   false                  5s
openebs-hostpath   openebs.io/local   Delete          WaitForFirstConsumer   false                  5s
[root@e1 ~]# kubectl patch storageclass -p &apos;{&quot;metadata&quot;: {&quot;annotations&quot;:{&quot;storageclass.kubernetes.io/is-default-class&quot;:&quot;true&quot;}}}&apos; -- openebs-hostpath
storageclass.storage.k8s.io/openebs-hostpath patched
[root@e1 ~]# kubectl get sc
NAME                         PROVISIONER        RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
openebs-device               openebs.io/local   Delete          WaitForFirstConsumer   false                  28s
openebs-hostpath (default)   openebs.io/local   Delete          WaitForFirstConsumer   false                  28s
[root@e1 ~]# </pre>


