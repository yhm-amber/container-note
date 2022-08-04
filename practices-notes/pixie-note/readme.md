
## 简介

ref:

- `https://docs.px.dev/about-pixie/what-is-pixie/`
- `https://docs.pixielabs.ai/about-pixie/what-is-pixie/`

## 云

可以用公网那个，自己注册账号然后登录： [`work.withpixie.ai`](https://work.withpixie.ai/auth/login) ，也可以[搞一个自托管](https://docs.px.dev/installing-pixie/install-guides/self-hosted-pixie/)。

<details>

<summary>（其中 <code>kustomize</code> 部分会创建的资源）</summary>

~~~ test
[root@node1 pixie]# kustomize build k8s/cloud_deps/base/elastic/operator | kubectl apply -f -
namespace/elastic-system created
customresourcedefinition.apiextensions.k8s.io/agents.agent.k8s.elastic.co created
customresourcedefinition.apiextensions.k8s.io/apmservers.apm.k8s.elastic.co created
customresourcedefinition.apiextensions.k8s.io/beats.beat.k8s.elastic.co created
customresourcedefinition.apiextensions.k8s.io/elasticmapsservers.maps.k8s.elastic.co created
customresourcedefinition.apiextensions.k8s.io/elasticsearches.elasticsearch.k8s.elastic.co created
customresourcedefinition.apiextensions.k8s.io/enterprisesearches.enterprisesearch.k8s.elastic.co created
customresourcedefinition.apiextensions.k8s.io/kibanas.kibana.k8s.elastic.co created
serviceaccount/elastic-operator created
clusterrole.rbac.authorization.k8s.io/elastic-operator created
clusterrole.rbac.authorization.k8s.io/elastic-operator-edit created
clusterrole.rbac.authorization.k8s.io/elastic-operator-view created
clusterrolebinding.rbac.authorization.k8s.io/elastic-operator created
configmap/elastic-operator created
secret/elastic-webhook-server-cert created
service/elastic-webhook-server created
statefulset.apps/elastic-operator created
validatingwebhookconfiguration.admissionregistration.k8s.io/elastic-webhook.k8s.elastic.co created
[root@node1 pixie]# kustomize build k8s/cloud_deps/public | kubectl apply -f -
I0804 17:46:46.993875   20122 request.go:645] Throttling request took 1.174609694s, request: GET:https://apiserver.cluster.local:6443/apis/tenant.kubesphere.io/v1alpha1?timeout=32s
serviceaccount/nats created
serviceaccount/nats-server created
serviceaccount/stan created
clusterrole.rbac.authorization.k8s.io/plc:nats-server created
clusterrole.rbac.authorization.k8s.io/plc:stan created
clusterrolebinding.rbac.authorization.k8s.io/plc:nats-server-binding created
clusterrolebinding.rbac.authorization.k8s.io/plc:stan-binding created
configmap/nats-config created
configmap/pl-announcement-config created
configmap/pl-auth-connector-config created
configmap/pl-errors-config created
configmap/pl-ld-config created
configmap/pl-oauth-config created
configmap/pl-sentry-dsn-config created
configmap/segment-config created
configmap/stan-config created
service/pl-nats created
service/pl-stan created
service/postgres created
persistentvolumeclaim/postgres-pv-claim created
deployment.apps/postgres created
statefulset.apps/pl-nats created
statefulset.apps/pl-stan created
poddisruptionbudget.policy/pl-stan-pdb created
elasticsearch.elasticsearch.k8s.elastic.co/pl-elastic created
[root@node1 pixie]# kustomize build k8s/cloud/public/ | kubectl apply -f -
role.rbac.authorization.k8s.io/pl-kuberesolver-role created
rolebinding.rbac.authorization.k8s.io/pl-kuberesolver-role-binding created
configmap/hydra-config created
configmap/kratos-config created
configmap/pl-analytics-config created
configmap/pl-artifact-config created
configmap/pl-bq-config created
configmap/pl-contact-config created
configmap/pl-db-config created
configmap/pl-domain-config created
configmap/pl-indexer-config created
configmap/pl-oauth-config unchanged
configmap/pl-ory-service-config created
configmap/pl-script-bundles-config created
configmap/pl-scriptmgr-config created
configmap/pl-service-config created
configmap/pl-support-access-config created
configmap/pl-tls-config created
configmap/proxy-envoy-config created
service/api-service created
service/artifact-tracker-service created
service/auth-service created
service/cloud-proxy-service created
service/config-manager-service created
service/cron-script-service created
service/hydra created
service/kratos created
service/plugin-service created
service/profile-service created
service/project-manager-service created
service/scriptmgr-service created
service/vzconn-service created
service/vzmgr-service created
deployment.apps/api-server created
deployment.apps/artifact-tracker-server created
deployment.apps/auth-server created
deployment.apps/cloud-proxy created
deployment.apps/config-manager-server created
deployment.apps/cron-script-server created
deployment.apps/hydra created
deployment.apps/indexer-server created
deployment.apps/kratos created
deployment.apps/metrics-server created
deployment.apps/plugin-server created
deployment.apps/profile-server created
deployment.apps/project-manager-server created
deployment.apps/scriptmgr-server created
deployment.apps/vzconn-server created
deployment.apps/vzmgr-server created
job.batch/create-admin-job created
job.batch/create-hydra-client-job created
job.batch/plugin-db-updater-job created
[root@node1 pixie]# 
~~~

</details>

不过，我发现很多 `pixie` 的资源需要来自 `gcr.io` 的镜像，譬如 `gcr.io/pixie-oss/pixie-prod/cloud/auth_server_image:latest` 。

所以还是省省吧。 `apply` 改 `delete` 先删了得了，办法以后再说。

## 基于 Helm 安装

ref: https://docs.pixielabs.ai/installing-pixie/install-schemes/helm/

部署 Pixie 可以通过 `px` 命令，也可以通过 Helm ，后者需要用 `px` 命令生成一个密钥： `px deploy-key create` ，或者在 UI 界面创建如果你已经有了的话。

命令从释放页面选择合适的下载即可。

该命令还支持容器化的部署和运行：

~~~ sh
alias px="docker run -i --rm -v ${HOME}/.pixie:${HOME}/.pixie -- pixielabs/px"
# ref: https://docs.px.dev/installing-pixie/install-schemes/cli/#1.-install-the-pixie-cli-using-docker
# text on: fedora 36 server, podman.
# use need: mkdir -p -- ${HOME}/.pixie
~~~

仓库地址是 `https://pixie-operator-charts.storage.googleapis.com` ，将其添加为名称 `pixie-operator` ：

~~~ sh
helm repo add -- pixie-operator https://pixie-operator-charts.storage.googleapis.com
~~~

然后就可以将图标 `pixie-operator/pixie-operator-chart` 安装为应用 `pixie` 到你希望的名称空间（默认的建议应该是名为 `pl` 的命名空间）。

你可能需要用 `--set` 或者在 `values.yaml` 增加的配置有：

- `deployKey` 这个是**必需**的，值是之前生成的密钥。
- `clusterName` 集群名称，可能是必须吧我没试过，给个名字吧就。
- `deployOLM` 根据情况设置或不设置；默认应该是 `true` ——即会一起帮你把 `olm` 也给安了，而如果显式地设置为 `false` 就是让它不做这事儿（这应该是仅当本集群已被部署过 `olm` 时才要用到的）。
- `pemMemoryLimit` 这个可以设置可以不设置，设置譬如 `1Gi` 就是把它的内存消耗限制在 `1 GiByte` 的大小。

更多选项见[此](https://docs.px.dev/reference/admin/deploy-options/)。

示例：

~~~ sh
helm install --set clusterName=epe,pemMemoryLimit=1Gi,deployKey=xxx -n pl --create-namespace -- pixie pixie-operator/pixie-operator-chart
~~~



