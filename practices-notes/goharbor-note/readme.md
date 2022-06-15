

# Helm install

ref: [`https://goharbor.io/docs/2.5.0/install-config/harbor-ha-helm`](https://goharbor.io/docs/2.5.0/install-config/harbor-ha-helm)  
ref: [`https://artifacthub.io/packages/helm/harbor/harbor`](https://artifacthub.io/packages/helm/harbor/harbor)  

上面两个 ref ，一个是官网的 helm 步骤，一个是 artifacthub.io 的该 chart 的页面。

它的步骤是离线安装 `helm chart` 的步骤：

~~~~ sh
: :: add repo :: :
helm repo add harbor https://helm.goharbor.io

: :: download chart :: :
helm fetch harbor/harbor --untar

: :: settings :: :
# change values.yaml
# or use --set during helm install

: :: then install by helm3 :: :
helm install my-release .
~~~~

不过，我是这样（在线）安的：

~~~ sh
helm repo add -- harbor https://helm.goharbor.io
helm install -- hub harbor/harbor
~~~

out:

~~~~ text
NAME: hub
LAST DEPLOYED: Mon Jun  6 18:14:12 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Please wait for several minutes for Harbor deployment to complete.
Then you should be able to visit the Harbor portal at https://core.harbor.domain
For more details, please visit https://github.com/goharbor/harbor
~~~~

看起来，之后访问那个地址就可以了。

但是我从集群外部真的能访问这个域名解析出来的 IP 地址吗？回头试试吧。

——很可惜，不能。

根据其 `values.yaml` 中的提示，我又加了这样两个设置来安装：

~~~ properties
expose.type=clusterIP
expose.tls.enabled=false
~~~

这样的话，它会自行部署一个 Nginx 对所有服务来代理，而不是使用 Ingress 了，那么我只需要把这个负载对应的 SVC 给变成 NodePort 就好了。

增加上述 `--set` 并不会影响 `helm` 部署时在命令行上的输出。

**但这样仍然存在问题：即便用户名密码输入正确，它也提示错误。**

对此：

- 技术交流群里一个朋友帮我找到了[一个 nodeport 模式的示例](https://kubesphere.com.cn/docs/application-store/built-in-apps/harbor-app/#%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98)。
- 同样的解决思路在[这里](https://github.com/goharbor/harbor-helm/issues/75#issuecomment-940080379)也被暗示过。

根据示例，我找到对应配置在 `values.yaml` 中的位置，我发现在 `expose.tls.auto.commonName` 附近有这样的注释：

~~~ yaml
      # The common name used to generate the certificate, it's necessary
      # when the type isn't "ingress"
~~~

这里是测试可用的配置（假设我要通过 `10.101.100.81` 用 nodeport 访问它）：

~~~ properties
expose.type=nodePort
expose.tls.enabled=false
expose.nodePort.ports.http.nodePort=30002
expose.tls.commonName="10.101.100.81"
externalURL="http://10.101.100.81:30002"
harborAdminPassword="Harbor12345"
secretKey="not-a-secure-key"
~~~

给它们用逗号分隔并加在 `--set` 后就好。

<details>

<summary>（譬如在 SHell 执行以下这个就能把你的代码打出来）</summary>

~~~~ sh
harbor_helm_props='
expose.type=nodePort
expose.tls.enabled=false
expose.nodePort.ports.http.nodePort=30002
expose.tls.commonName="{}"
externalURL="http://{}:30002"
harborAdminPassword="Harbor12345"
secretKey="not-a-secure-key"
' &&

printf %s 10.101.100.81 | xargs -0I {} -- echo "$harbor_helm_props" | (xargs -- echo | tr -- ' ' ,)
~~~~

</details>

这是我的命令：

~~~ sh
helm install -n hub --create-namespace --set expose.type=nodePort,expose.tls.enabled=false,expose.nodePort.ports.http.nodePort=30002,expose.tls.commonName=10.101.100.81,externalURL=http://10.101.100.81:30002,harborAdminPassword=Harbor12345,secretKey=not-a-secure-key -- hub-harbor harbor/harbor
~~~

out:

~~~ text
NAME: hub-harbor
LAST DEPLOYED: Wed Jun 15 11:15:57 2022
NAMESPACE: hub
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Please wait for several minutes for Harbor deployment to complete.
Then you should be able to visit the Harbor portal at http://10.101.100.81:30002
For more details, please visit https://github.com/goharbor/harbor
~~~

## uninstall

上面最后的示例卸载：

~~~ sh
helm uninstall hub-harbor -n hub
~~~

out:

~~~ text
These resources were kept due to the resource policy:
[PersistentVolumeClaim] hub-harbor-chartmuseum
[PersistentVolumeClaim] hub-harbor-jobservice
[PersistentVolumeClaim] hub-harbor-registry

release "hub-harbor" uninstalled
~~~

想要完全重装的话记得把卷也删了。

## more 😎

在 `helm` 的提示信息中的 `Then you should be able to visit the Harbor portal at` 后的地址，完全取决于你在 `values.yaml` 里的 `externalURL` 处配了啥。

——如果把 `expose.tls.commonName` 写成 `".*"` 并把 `externalURL` 写成 `"http://.*"` 的话，这个完成安装后的提示信息也会跟着变。**而且这样一来你就可以通过任何只要能访问到这个 Harbor 的地址完成登录了！！**

对于配置 `expose.tls.auto.commonName` ，它需要再有一个 `expose.tls.certSource=auto` 才能有配置 `expose.tls.commonName` 的效果。

总的来说，你可能会用到这样的一个工具：

<details>

<summary>代码</summary>

~~~~ sh
goharbor_simple_helmer ()
{
    : demo
    : goharbor_simple_helmer harbor/harbor hub-harbor hub 30002 '.*' '.*' 'adminadmin'
    
    
    : :;
    
    local appchart="$1" && shift 1 &&
    local appname="$1" && shift 1 &&
    local appns="$1" && shift 1 &&
    local port="$1" && shift 1 &&
    local exname="$1" && shift 1 &&
    local export="$1" && shift 1 &&
    local pass="$1" && shift 1 &&
    
    (test ! -z "$appchart" && test ! -z "$appname") || { echo 至少要有前两个参数 ; return 2 ; } ;
    
    :;
    
    local prop_tmep='
        
        expose.type=nodePort
        expose.tls.enabled=false
        expose.nodePort.ports.http.nodePort='"${port:-30002}"'
        expose.tls.commonName="{}"
        externalURL="http://{}:'"${export:-${port:-30002}}"'"
        harborAdminPassword="'"${pass:-Harbor12345}"'"
        secretKey="not-a-secure-key" ' &&
    
    local prop_sets="$(
        
        printf %s "${exname:-.*}" |
            xargs -0I {} -- echo "${PROP_TEMP:-$prop_tmep}" |
            
            xargs -- echo | tr -- ' ' , )" &&
    
    echo helm install -n "${appns:-default}" --create-namespace --set "'${PROR_SETS:-$prop_sets}'" -- "$appname" "$appchart" &&
    
    :;
} ;
~~~~

</details>

~~~ sh
goharbor_simple_helmer harbor/harbor hub-harbor hub 30002 '.*' '.*' 'adminadmin'
~~~

得到：

~~~ text
helm install -n hub --create-namespace --set 'expose.type=nodePort,expose.tls.enabled=false,expose.nodePort.ports.http.nodePort=30002,expose.tls.commonName=.*,externalURL=http://.*:.*,harborAdminPassword=adminadmin,secretKey=not-a-secure-key' -- hub-harbor harbor/harbor
~~~

那么

~~~ sh
eval "$(goharbor_simple_helmer harbor/harbor hub-harbor hub 30002 '.*' '.*' 'adminadmin')"
~~~

就能得到：

~~~ text
NAME: hub-harbor
LAST DEPLOYED: Wed Jun 15 12:28:22 2022
NAMESPACE: hub
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Please wait for several minutes for Harbor deployment to complete.
Then you should be able to visit the Harbor portal at http://.*:.*
For more details, please visit https://github.com/goharbor/harbor
~~~

😎😎

# Operator install

Harbor 支持使用 Operator 创建实例。

Operator 支持 Helm 部署。

ref: 

- https://github.com/goharbor/harbor-operator/pkgs/container/harbor-operator
- https://github.com/goharbor/harbor-operator/blob/master/docs/installation/kustomization-all-in-one.md
- https://github.com/goharbor/harbor-operator/blob/master/docs/installation/by-helm-chart.md
- https://github.com/goharbor/harbor-operator/tree/master/charts/harbor-operator

需要：

- `Kubernetes` 。
- [`cert-manager`](../cert-manager-note) 。
- Ingress controller ，如默认的 [Nginx Ingress](../ingress-note#kubernetes-default-nginx-ingress) 。
- `kubectl` 。
- `helm` (v3) 。

安装：略，见上面参考的那些链接。

从版本号看来，用 operator 创建实例的这个途径，并不像用 helm 直接安装那样被积极维护。

