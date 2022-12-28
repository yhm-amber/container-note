
[streamnative-site]: https://streamnative.io

[repo]: https://github.com/apache/pulsar.git
[site]: https://pulsar.apache.org

[streamnative-client-rs-repo]: https://github.com/streamnative/pulsar-rs.git
[streamnative-client-spark-repo]: https://github.com/streamnative/pulsar-spark.git

## intro

## deploy

[docs-helm-2.10]: https://pulsar.apache.org/docs/2.10.x/helm-overview
[docs-kube-2.10]: https://pulsar.apache.org/docs/2.10.x/deploy-kubernetes
[docs-helm-next]: https://pulsar.apache.org/docs/next/helm-overview
[docs-kube-next]: https://pulsar.apache.org/docs/next/deploy-kubernetes
[docs-dcos-next]: https://pulsar.apache.org/docs/next/deploy-dcos

ref: [Apache Pulsar Helm Chart | Apache Pulsar][docs-helm-2.10]

~~~ sh
helm repo add -- apache https://pulsar.apache.org/charts
~~~

~~~ sh
helm repo update

helm get values <pulsar-release-name> > pulsar.yaml
helm upgrade <pulsar-release-name> apache/pulsar -f pulsar.yaml
~~~
