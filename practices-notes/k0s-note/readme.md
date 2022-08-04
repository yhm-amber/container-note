
有名为 `k0s` 的一个单二进制工具，它能够输出默认的初始化 `yaml` 配置。

单节点安装很容易，多节点集群需要配置。并不是类似于 `k3s` 那样的一个节点一个节点地来。

离线文件完全来自镜像。（这里应该只是被容器运行时运行的镜像，并非集群镜像。）

还有个管理工具叫 `k0sctl` ，可以很轻松地用更加简洁的配置文件（也可以生成）来安装一个 Kubernetes 集群。

使用它需要先配好免密。（可参考[我这个笔记](../ssh-note#%E5%85%8D%E5%AF%86)）

高可用没有 `sealos` 简单。

外部运行时依赖见： https://docs.k0sproject.io/v1.23.8+k0s.0/external-runtime-deps/

## 离线包使用

其实就是，不管用啥手段，把离线包丢到 `/var/lib/k0s/images` 这个目录下就行。参[此](https://docs.k0sproject.io/v1.24.3+k0s.0/airgap-install/#2a-sync-the-bundle-file-with-the-airgapped-machine-locally)。

也可以[自制离线包](https://docs.k0sproject.io/v1.24.3+k0s.0/airgap-install/#1-create-your-own-image-bundle-optional)，如果你信不过[他们释放的那些](https://github.com/k0sproject/k0s/releases)的话。

> Copy the bundle only to the worker nodes. Controller nodes don't use it.
> 

## 正常的尝试

参：
- https://docs.k0sproject.io/v1.23.8+k0s.0/k0sctl-install/
- https://mritd.com/2021/07/29/test-the-k0s-cluster/

### install

譬如我需要 `10.101.1.71` `10.101.1.72` `10.101.1.73` 作为三个主节点，可以这样：

~~~ sh
k0sctl init --controller-count 3 -- 10.101.1.71 10.101.1.72 10.101.1.73 | k0sctl apply --config -
~~~

如果需要主节点也被调度，就这样：

~~~ sh
k0sctl init --controller-count 3 -- 10.101.1.71 10.101.1.72 10.101.1.73 |
    
    (
        tmp="$(cat -)" &&
        printf %s controller+worker |
            xargs -I controller -- echo "$tmp"
        : ) |
    
    k0sctl apply --config -
~~~


如果需要离线安装，我没有简洁的替换方法了，重定向成一个文件然后自己加一下吧。。。相关信息就加在 `Cluster.spec.hosts.[n].files.[n]` 节点下就好， `name` 字段需要是 `image-bundle` 。

也就是说，一是，这个地方也可以用来写一些别的文件的路径和名称信息什么的，一是，每个节点里都得写一遍这玩意儿。

所谓离线安装其实就是把一个 `bundle` 文件给放在所有目标节点的 `/var/lib/k0s/images/` 目录下面。可以从他们的 [github release](https://github.com/k0sproject/k0s/releases) 里找到这个文件，也可以参考[他们的离线文档](https://docs.k0sproject.io/v1.23.8+k0s.0/airgap-install/)自己打包。

### 问题

我是在 `openEuler 22.03 LTS` 上玩的。

失败了，错误很简单： `os support module not found` 。

详细内容：

<details>

<summary>
<code>/root/.cache/k0sctl/k0sctl.log</code>
</summary>

~~~ text
time="26 Jun 22 20:20 CST" level=info msg="###### New session ######"
time="26 Jun 22 20:20 CST" level=debug msg="upgrade check failed: failed to get the latest version information"
time="26 Jun 22 20:20 CST" level=debug msg="Loaded configuration:\napiVersion: k0sctl.k0sproject.io/v1beta1\nkind: Cluster\nmetadata:\n  name: k0s-cluster\nspec:\n  hosts:\n  - ssh:\n      address: 10.101.1.91\n      user: root\n      port: 22\n      keyPath: /root/.ssh/id_rsa\n    role: controller+worker\n  - ssh:\n      address: 10.101.1.92\n      user: root\n      port: 22\n      keyPath: /root/.ssh/id_rsa\n    role: controller+worker\n  - ssh:\n      address: 10.101.1.93\n      user: root\n      port: 22\n      keyPath: /root/.ssh/id_rsa\n    role: controller+worker\n  k0s:\n    version: 1.23.8+k0s.0\n    dynamicConfig: false\n    config:\n      apiVersion: k0s.k0sproject.io/v1beta1\n      kind: Cluster\n      metadata:\n        name: k0s\n      spec:\n        api:\n          k0sApiPort: 9443\n          port: 6443\n        installConfig:\n          users:\n            etcdUser: etcd\n            kineUser: kube-apiserver\n            konnectivityUser: konnectivity-server\n            kubeAPIserverUser: kube-apiserver\n            kubeSchedulerUser: kube-scheduler\n        konnectivity:\n          adminPort: 8133\n          agentPort: 8132\n        network:\n          kubeProxy:\n            disabled: false\n            mode: iptables\n          kuberouter:\n            autoMTU: true\n            mtu: 0\n            peerRouterASNs: \"\"\n            peerRouterIPs: \"\"\n          podCIDR: 10.244.0.0/16\n          provider: kuberouter\n          serviceCIDR: 10.96.0.0/12\n        podSecurityPolicy:\n          defaultPolicy: 00-k0s-privileged\n        storage:\n          type: etcd\n        telemetry:\n          enabled: true\n"
time="26 Jun 22 20:20 CST" level=debug msg="Preparing phase 'Connect to hosts'"
time="26 Jun 22 20:20 CST" level=info msg="\x1b[32m==> Running phase: Connect to hosts\x1b[0m"
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.91:22: executing `uname | grep -q Linux`"
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.93:22: executing `uname | grep -q Linux`"
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.92:22: executing `uname | grep -q Linux`"
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.91:22: executing `cat /etc/os-release || cat /usr/lib/os-release`"
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.91:22: NAME=\"openSUSE Leap\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.91:22: VERSION=\"15.2\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.91:22: ID=\"opensuse-leap\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.91:22: ID_LIKE=\"suse opensuse\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.91:22: VERSION_ID=\"15.2\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.91:22: PRETTY_NAME=\"openSUSE Leap 15.2\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.92:22: executing `cat /etc/os-release || cat /usr/lib/os-release`"
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.91:22: ANSI_COLOR=\"0;32\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.91:22: CPE_NAME=\"cpe:/o:opensuse:leap:15.2\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.91:22: BUG_REPORT_URL=\"https://bugs.opensuse.org\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.91:22: HOME_URL=\"https://www.opensuse.org/\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.91:22: executing `[ \"$(id -u)\" = 0 ]`"
time="26 Jun 22 20:20 CST" level=info msg="[ssh] 10.101.1.91:22: connected"
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.92:22: NAME=\"openSUSE Leap\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.92:22: VERSION=\"15.2\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.92:22: ID=\"opensuse-leap\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.92:22: ID_LIKE=\"suse opensuse\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.92:22: VERSION_ID=\"15.2\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.92:22: PRETTY_NAME=\"openSUSE Leap 15.2\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.92:22: ANSI_COLOR=\"0;32\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.92:22: CPE_NAME=\"cpe:/o:opensuse:leap:15.2\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.92:22: BUG_REPORT_URL=\"https://bugs.opensuse.org\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.92:22: HOME_URL=\"https://www.opensuse.org/\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.92:22: executing `[ \"$(id -u)\" = 0 ]`"
time="26 Jun 22 20:20 CST" level=info msg="[ssh] 10.101.1.92:22: connected"
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.93:22: executing `cat /etc/os-release || cat /usr/lib/os-release`"
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.93:22: NAME=\"openSUSE Leap\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.93:22: VERSION=\"15.2\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.93:22: ID=\"opensuse-leap\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.93:22: ID_LIKE=\"suse opensuse\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.93:22: VERSION_ID=\"15.2\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.93:22: PRETTY_NAME=\"openSUSE Leap 15.2\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.93:22: ANSI_COLOR=\"0;32\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.93:22: CPE_NAME=\"cpe:/o:opensuse:leap:15.2\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.93:22: BUG_REPORT_URL=\"https://bugs.opensuse.org\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.93:22: HOME_URL=\"https://www.opensuse.org/\""
time="26 Jun 22 20:20 CST" level=debug msg="[ssh] 10.101.1.93:22: executing `[ \"$(id -u)\" = 0 ]`"
time="26 Jun 22 20:20 CST" level=info msg="[ssh] 10.101.1.93:22: connected"
time="26 Jun 22 20:20 CST" level=debug msg="Preparing phase 'Detect host operating systems'"
time="26 Jun 22 20:20 CST" level=info msg="\x1b[32m==> Running phase: Detect host operating systems\x1b[0m"
time="26 Jun 22 20:20 CST" level=info msg="###### New session ######"
time="26 Jun 22 20:20 CST" level=error msg="apply failed - log file saved to /root/.cache/k0sctl/k0sctl.log"
time="26 Jun 22 20:20 CST" level=fatal msg="failed on 3 hosts:\n - [ssh] 10.101.1.91:22: os support module not found\n - [ssh] 10.101.1.92:22: os support module not found\n - [ssh] 10.101.1.93:22: os support module not found"
time="29 Jun 22 19:09 CST" level=info msg="###### New session ######"
time="29 Jun 22 19:09 CST" level=debug msg="upgrade check failed: failed to get the latest version information"
time="29 Jun 22 19:09 CST" level=debug msg="Loaded configuration:\napiVersion: k0sctl.k0sproject.io/v1beta1\nkind: Cluster\nmetadata:\n  name: k0s-cluster\nspec:\n  hosts:\n  - ssh:\n      address: 10.101.1.71\n      user: root\n      port: 22\n      keyPath: /root/.ssh/id_rsa\n    role: controller+worker\n  - ssh:\n      address: 10.101.1.72\n      user: root\n      port: 22\n      keyPath: /root/.ssh/id_rsa\n    role: controller+worker\n  - ssh:\n      address: 10.101.1.73\n      user: root\n      port: 22\n      keyPath: /root/.ssh/id_rsa\n    role: controller+worker\n  k0s:\n    version: \"\"\n    dynamicConfig: false\n"
time="29 Jun 22 19:10 CST" level=debug msg="Preparing phase 'Connect to hosts'"
time="29 Jun 22 19:10 CST" level=info msg="\x1b[32m==> Running phase: Connect to hosts\x1b[0m"
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.71:22: executing `uname | grep -q Linux`"
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.72:22: executing `uname | grep -q Linux`"
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.73:22: executing `uname | grep -q Linux`"
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.71:22: executing `cat /etc/os-release || cat /usr/lib/os-release`"
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.72:22: executing `cat /etc/os-release || cat /usr/lib/os-release`"
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.71:22: NAME=\"openEuler\""
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.71:22: VERSION=\"22.03 LTS\""
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.71:22: ID=\"openEuler\""
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.71:22: VERSION_ID=\"22.03\""
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.71:22: PRETTY_NAME=\"openEuler 22.03 LTS\""
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.71:22: ANSI_COLOR=\"0;31\""
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.71:22: "
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.71:22: executing `[ \"$(id -u)\" = 0 ]`"
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.73:22: executing `cat /etc/os-release || cat /usr/lib/os-release`"
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.72:22: NAME=\"openEuler\""
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.72:22: VERSION=\"22.03 LTS\""
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.72:22: ID=\"openEuler\""
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.72:22: VERSION_ID=\"22.03\""
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.72:22: PRETTY_NAME=\"openEuler 22.03 LTS\""
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.72:22: ANSI_COLOR=\"0;31\""
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.72:22: "
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.72:22: executing `[ \"$(id -u)\" = 0 ]`"
time="29 Jun 22 19:10 CST" level=info msg="[ssh] 10.101.1.71:22: connected"
time="29 Jun 22 19:10 CST" level=info msg="[ssh] 10.101.1.72:22: connected"
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.73:22: NAME=\"openEuler\""
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.73:22: VERSION=\"22.03 LTS\""
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.73:22: ID=\"openEuler\""
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.73:22: VERSION_ID=\"22.03\""
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.73:22: PRETTY_NAME=\"openEuler 22.03 LTS\""
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.73:22: ANSI_COLOR=\"0;31\""
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.73:22: "
time="29 Jun 22 19:10 CST" level=debug msg="[ssh] 10.101.1.73:22: executing `[ \"$(id -u)\" = 0 ]`"
time="29 Jun 22 19:10 CST" level=info msg="[ssh] 10.101.1.73:22: connected"
time="29 Jun 22 19:10 CST" level=debug msg="Preparing phase 'Detect host operating systems'"
time="29 Jun 22 19:10 CST" level=info msg="\x1b[32m==> Running phase: Detect host operating systems\x1b[0m"
time="29 Jun 22 19:10 CST" level=info msg="###### New session ######"
time="29 Jun 22 19:10 CST" level=error msg="apply failed - log file saved to /root/.cache/k0sctl/k0sctl.log"
time="29 Jun 22 19:10 CST" level=fatal msg="failed on 3 hosts:\n - [ssh] 10.101.1.71:22: os support module not found\n - [ssh] 10.101.1.72:22: os support module not found\n - [ssh] 10.101.1.73:22: os support module not found"
~~~

</details>

这个日志分别是对三个 `openSUSE Leap 15.2` 和三个 `openEuler 22.03 LTS` 试的。

## 基于 Liqo 的骚操作

如果单节点可以，我就试试能不能用 Liqo 联系起来一个去中心化的集群。

### 部署单机集群

离线包丢 `/var/lib/k0s/images` 下。

ref: https://docs.k0sproject.io/v1.24.3+k0s.0/install/

- 安装服务： `sudo k0s install controller --single`
- 清理服务： `sudo k0s reset`
- 启动： `sudo k0s start`
- 停止： `sudo k0s stop`
- 查看状态： `sudo k0s status`
- 使用 `kubectl` ： `sudo k0s kubectl get nodes`

更多用法见 ref 。

安装启动，并待状态正常、可以使用 `kubectl` 看到一些东西。在几个节点都做这事。

### 联系起来这几个节点

使用 [Liqo](https://liqo.io/) 。（[文档](https://docs.liqo.io/en/latest/)）

> Liqo supports two alternative peering approaches, each characterized by **different requirements in terms of network connectivity** (i.e., mutually reachable endpoints):
> 
> - [**Out-of-band control plane peering**](https://docs.liqo.io/en/latest/features/peering.html#featurespeeringoutofbandcontrolplane): it requires **three separated traffic flows** (hence, three exposed endpoints).
> - [**in-band control plane peering**](https://docs.liqo.io/en/latest/features/peering.html#featurespeeringinbandcontrolplane): it requires a **single endpoint**, as all control plane traffic is tunneled inside the cross-cluster VPN.
> 
> More details available in the [peering section](https://docs.liqo.io/en/latest/features/peering.html).
> 
> Note: The two peering approaches are **non-mutually exclusive**: a cluster can leverage different approaches toward different remote clusters, provided that the connectivity requirements are satisfied.
> 


> Liqo支持两种替代的对等互连方法，每种方法**在网络连接**（即相互访问的端点）**方面具有不同的要求**：
> 
> - [**带外控制平面对等互连**](https://docs.liqo.io/en/latest/features/peering.html#featurespeeringoutofbandcontrolplane)：它需要**三个独立的流量流**（也就是三个公开的终结点）。
> - [**带内控制平面对等互连**](https://docs.liqo.io/en/latest/features/peering.html#featurespeeringinbandcontrolplane)：它需要**单个终结点**，因为所有控制平面流量都在跨集群 VPN 内通过隧道传输。
>     
> 有关更多详细信息，请参阅[对等互连部分](https://docs.liqo.io/en/latest/features/peering.html)。
> 
> 注意：这两种对等互连方法是**非互斥的**：只要满足连接要求，群集就可以对不同的远程群集利用不同的方法。
> 







