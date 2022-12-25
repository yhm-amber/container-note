
### spark

~~~~ bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install --create-namespace --namespace spark-bitnami -- spark-bitnami bitnami/spark
~~~~

out:

~~~~
NAME: spark-bitnami
LAST DEPLOYED: Tue Nov  9 14:32:28 2021
NAMESPACE: spark-bitnami
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: spark
CHART VERSION: 5.7.9
APP VERSION: 3.2.0

** Please be patient while the chart is being deployed **

1. Get the Spark master WebUI URL by running these commands:

  kubectl port-forward --namespace spark-bitnami svc/spark-bitnami-master-svc 80:80
  echo "Visit http://127.0.0.1:80 to use your application"

2. Submit an application to the cluster:

  To submit an application to the cluster the spark-submit script must be used. That script can be
  obtained at https://github.com/apache/spark/tree/master/bin. Also you can use kubectl run.

  export EXAMPLE_JAR=$(kubectl exec -ti --namespace spark-bitnami spark-bitnami-worker-0 -- find examples/jars/ -name 'spark-example*\.jar' | tr -d '\r')

  kubectl exec -ti --namespace spark-bitnami spark-bitnami-worker-0 -- spark-submit --master spark://spark-bitnami-master-svc:7077 \
    --class org.apache.spark.examples.SparkPi \
    $EXAMPLE_JAR 5

** IMPORTANT: When submit an application from outside the cluster service type should be set to the NodePort or LoadBalancer. **

** IMPORTANT: When submit an application the --master parameter should be set to the service IP, if not, the application will not resolve the master. **
~~~~


### ...


