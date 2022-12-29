
[streamnative-site]: https://streamnative.io

[repo]: https://github.com/apache/pulsar.git
[site]: https://pulsar.apache.org

[streamnative-client-rs-repo]: https://github.com/streamnative/pulsar-rs.git
[streamnative-client-spark-repo]: https://github.com/streamnative/pulsar-spark.git

## intro

## deploy

see also: 

- [streamnative note](../streamnative-note#deploy)
  
  StreamNative Platform 是一个基于 Pulsar 的平台，该组织还制作了一系列的 Pulsar 相关的工具。  
  如果下面的部署方式不能满足你的需求，它应该是更好的选择。  
  


[docs-helm-start-2.10]: https://pulsar.apache.org/docs/2.10.x/getting-started-helm
[docs-helm-start-next]: https://pulsar.apache.org/docs/next/getting-started-helm

[docs-helm-overview-2.10]: https://pulsar.apache.org/docs/2.10.x/helm-overview
[docs-helm-overview-next]: https://pulsar.apache.org/docs/next/helm-overview

[docs-kube-2.10]: https://pulsar.apache.org/docs/2.10.x/deploy-kubernetes
[docs-kube-next]: https://pulsar.apache.org/docs/next/deploy-kubernetes

[docs-dcos-next]: https://pulsar.apache.org/docs/next/deploy-dcos

ref:

- [Run a standalone Pulsar cluster in Kubernetes | Apache Pulsar][docs-helm-start-2.10]
- [Apache Pulsar Helm Chart | Apache Pulsar][docs-helm-overview-2.10]

helm repo: 

~~~ sh
helm repo add -- apache https://pulsar.apache.org/charts
~~~

git clone:

~~~ sh
git clone -- https://github.com/apache/pulsar-helm-chart.git && cd pulsar-helm-chart
~~~

> Run the script `prepare_helm_release.sh` to create the secrets required for installing the Apache Pulsar Helm chart. The username `pulsar` and password `pulsar` are used for logging into the Grafana dashboard and Pulsar Manager.
> 
> > 
> > **Note**
> > 
> > When running the script, you can use `-n` to specify the Kubernetes namespace where the Pulsar Helm chart is installed, `-k` to define the Pulsar Helm release name, and `-c` to create the Kubernetes namespace. For more information about the script, run `./scripts/pulsar/prepare_helm_release.sh --help`.
> > 
> 

~~~ sh
./scripts/pulsar/prepare_helm_release.sh -n pulsar -k pulsar-mini -c
~~~

helm install: 

~~~ sh
helm install \
    --values examples/values-minikube.yaml \
    --namespace pulsar \
    -- pulsar-mini apache/pulsar
~~~

helm upgrade: 

~~~ sh
helm repo update

helm get values -- <pulsar-release-name> > pulsar.yaml
helm upgrade <pulsar-release-name> apache/pulsar -f pulsar.yaml
~~~
