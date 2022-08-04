
## 简介

ref:

- `https://docs.px.dev/about-pixie/what-is-pixie/`
- `https://docs.pixielabs.ai/about-pixie/what-is-pixie/`

## 云

可以用公网那个，自己注册账号然后登录： [`work.withpixie.ai`](https://work.withpixie.ai/auth/login) ，也可以[搞一个自托管](https://docs.px.dev/installing-pixie/install-guides/self-hosted-pixie/)。

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



