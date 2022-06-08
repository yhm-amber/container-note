ref: https://artifacthub.io/packages/helm/ygqygq2/mysql


~~~ sh
helm repo add -- ygqygq2 https://ygqygq2.github.io/charts
helm pull --untardir ygqygq2 --untar -- ygqygq2/mysql
cd ygqygq2/mysql && helm dependency build &&
helm install --namespace mysql --create-namespace -- mysql .
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
LAST DEPLOYED: Wed Jun  8 15:45:14 2022
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
      helm upgrade mysql bitnami/mysql --set root.password=$ROOT_PASSWORD
~~~

</details>


