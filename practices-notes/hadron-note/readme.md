[src/gh]: https://github.com/hadron-project/hadron.git "(Languages: Rust 98.7%, Dockerfile 1.1%, Other 0.2%) The Kubernetes native and CloudEvents native distributed event streaming, event orchestration & messaging platform"
[guide/ghio]: https://hadron-project.github.io/hadron

[🍳 src][src/gh] | [🍌 guide][guide/ghio]

pkgs: 

- [hadron/hadron-operator](https://github.com/orgs/hadron-project/packages/container/package/hadron%2Fhadron-operator) : `pull ghcr.io/hadron-project/hadron/hadron-operator:latest`
- [charts/hadron-operator](https://github.com/orgs/hadron-project/packages/container/package/charts%2Fhadron-operator) : `pull ghcr.io/hadron-project/charts/hadron-operator:artifacthub.io`
- [hadron/hadron-stream](https://github.com/hadron-project/hadron/pkgs/container/hadron%2Fhadron-stream) : `pull ghcr.io/hadron-project/hadron/hadron-stream:latest`
- [hadron/pipeline-txp](https://github.com/hadron-project/hadron/pkgs/container/hadron%2Fpipeline-txp) : `pull ghcr.io/hadron-project/hadron/pipeline-txp:latest`
- [hadron/stream-txp](https://github.com/hadron-project/hadron/pkgs/container/hadron%2Fstream-txp) : `pull ghcr.io/hadron-project/hadron/stream-txp:latest`
- [hadron/hadron-cli](https://github.com/hadron-project/hadron/pkgs/container/hadron%2Fhadron-cli) : `pull ghcr.io/hadron-project/hadron/hadron-cli:latest`

### Install

Needed: [cert manager](../cert-manager-note) installed.

~~~ sh
helm repo add jetstack https://charts.jetstack.io
helm upgrade cert-manager jetstack/cert-manager --install --set installCRDs=true
~~~

Operator install: 

~~~ sh
# Helm >= v3.7.0 is required for OCI usage.
helm install -- hadron-operator oci://ghcr.io/hadron-project/charts/hadron-operator
~~~

### Create

Apply this to Create a instance of `Stream` : 

~~~ yml
apiVersion: hadron.rs/v1beta1
kind: Stream
metadata:
  name: events
spec:
  partitions: 3
  ttl: 0
  image: ghcr.io/hadron-project/hadron/hadron-stream:latest
  pvcVolumeSize: "5Gi"
~~~

> See the [Stream Reference](https://hadron-project.github.io/hadron/reference/streams.html)
>  for more details
> 

> 这会创建一个同名的 Kubernetes StatefulSet 以及一些 Kubernetes 服务。
> 

Apply this to Create a instance of `Token` : 

~~~ yml
apiVersion: hadron.rs/v1beta1
kind: Token
metadata:
  name: hadron-full-access
spec:
  all: true
~~~

> See the [Token Reference](https://hadron-project.github.io/hadron/reference/tokens.html)
>  for more details
> 

> 这会在具有相同名称的同一命名空间中
> 创建 Kubernetes Secret 。生成的 Secret 可以
> 被安装并用作应用程序部署等的环境变量，也
> 可以被 Hadron CLI 用于集群访问。
> 

### Access

> 现在我们已经定义了一个 Stream 和一个 Token 以
> 允许我们访问该 Stream ，我们准备开始发布和使用数据。 
> 

连接: 

~~~ sh
: 获取 Token 生成的 Secret (实际的 JWT) 的副本
HADRON_TOKEN=$(kubectl get secret -- hadron-full-access -o jsonpath='{.data.token}' | base64 --decode)

: 运行 CLI
kubectl run hadron-cli --rm -it \
    --env=HADRON_TOKEN=${HADRON_TOKEN} \
    --env=HADRON_URL='http://events.default.svc.cluster.local:7000' \
    --image ghcr.io/hadron-project/hadron/hadron-cli:latest

: 这会运行一个临时 pod —— 它将在断开连接时从 Kubernetes 集群中删除。
: 一旦 pod 会话启动，您应该会看到显示的 CLI 帮助文本，然后您应该可以访问 shell 提示符。 
~~~

使用: 

~~~ sh
: 在连接成功后将取得提示符，
: 此时便可使用 CLI 与 Stream 实例交互。

: 发布简单事件 :
hadron stream pub --subject demo --type example.event '{"demo": "live"}'

: 这会将一个简单的事件发布为 JSON blob 。
; 还完全支持发布二进制事件，例如 protobuf 。

: 创建一个消费者来读取这个事件 :
hadron stream sub --group demo --start-beginning
~~~

上面的示例会输出类似如下内容: 

~~~
INFO hadron_cli::cmd::stream::sub: handling subscription delivery id=1 source=/example.hadron.rs/events/2 specversion=1.0 type=example.event subject=demo optattrs={} data='{"demo": "live"}'
~~~

更多内容见 [Wrapping Up](https://hadron-project.github.io/hadron/overview/quick-start.html#wrapping-up) 。
