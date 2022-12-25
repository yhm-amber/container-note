
### flink

`https://artifacthub.io/packages/helm/riskfocus/flink`

#### install

~~~~ bash
# 1.11.2
helm repo add riskfocus https://riskfocus.github.io/helm-charts-public
helm repo update
helm install --create-namespace --namespace flink--riskfocus--ns \
        --set jobmanager.statefulset=true,jobmanager.persistent.enabled=true,jobmanager.persistent.storageClass=local-hostpath \
        --set taskmanager.statefulset=true,taskmanager.persistent.enabled=true,taskmanager.persistent.storageClass=local-hostpath \
        -- flink--riskfocus--app riskfocus/flink
        #--set zookeeper.enabled=true,jobmanager.replicaCount=2,jobmanager.highAvailability.enabled=true,jobmanager.highAvailability.storageDir=s3://MY_BUCKET/flink/jobmanager \
~~~~

out:

~~~~ stdout
NAME: flink--riskfocus--app
LAST DEPLOYED: Mon Nov 15 18:17:07 2021
NAMESPACE: flink--riskfocus--ns
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace flink--riskfocus--ns -l "app.kubernetes.io/name=flink,app.kubernetes.io/instance=flink--riskfocus--app" -o jsonpath="{.items[0].metadata.name}")
  echo "Visit http://127.0.0.1:8081 to use your application"
  kubectl port-forward $POD_NAME 8081:8081
~~~~

#### check

~~~~ bash
kubectl get pods -n flink--riskfocus--ns
~~~~

out:

~~~~ stdout
NAME                                  READY   STATUS              RESTARTS   AGE
flink--riskfocus--app-jobmanager-0    0/1     Running             0          11s
flink--riskfocus--app-taskmanager-0   0/1     ContainerCreating   0          11s
flink--riskfocus--app-taskmanager-1   1/1     Running             0          11s
flink--riskfocus--app-taskmanager-2   1/1     Running             0          11s
flink--riskfocus--app-taskmanager-3   1/1     Running             0          11s
~~~~

#### usage

~~~ sh
kubectl port-forward --address 0.0.0.0 -n flink--riskfocus--ns -- $(kubectl get pods --namespace flink--riskfocus--ns -l "app.kubernetes.io/name=flink,app.kubernetes.io/instance=flink--riskfocus--app" -o jsonpath="{.items[0].metadata.name}") 8081:8081
~~~

#### uninstall

~~~~ bash
# see name
helm ls -A
helm uninstall -n flink--riskfocus--ns -- flink--riskfocus--app
~~~~



