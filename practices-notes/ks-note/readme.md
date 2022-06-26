
有名为 `k0s` 的一个单二进制工具，它能够输出默认的初始化 `yaml` 配置。

单节点安装很容易，多节点集群需要配置。并不是类似于 `k3s` 那样的一个节点一个节点地来。

离线文件完全来自镜像。（这有点像 `sealos` ）

还有个管理工具叫 `k0sctl` ，可以很轻松地用更加简洁的配置文件（也可以生成）来安装一个 Kubernetes 集群。（这也有点像 `sealos` ）

使用它需要先配好免密。（可参考[我这个笔记](../ssh-note#%E5%85%8D%E5%AF%86)）

高可用没有 `sealos` 简单。

外部运行时依赖见： https://docs.k0sproject.io/v1.23.8+k0s.0/external-runtime-deps/

## install

参：
- https://docs.k0sproject.io/v1.23.8+k0s.0/k0sctl-install/
- https://mritd.com/2021/07/29/test-the-k0s-cluster/

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

总的来说，确实和 `sealos` 的复杂度差不多（这里我就全当大家都懂 Linux SHell 。。。）

如果需要离线安装，我没有简洁的替换方法了，重定向成一个文件然后自己加一下吧。。。相关信息就加在 `Cluster.spec.hosts.[n].files.[n]` 节点下就好， `name` 字段需要是 `image-bundle` 。

也就是说，一是，这个地方也可以用来写一些别的文件的路径和名称信息什么的，一是，每个节点里都得写一遍这玩意儿。

所谓离线安装其实就是把一个 `bundle` 文件给放在所有目标节点的 `/var/lib/k0s/images/` 目录下面。可以从他们的 [github release](https://github.com/k0sproject/k0s/releases) 里找到这个文件，也可以参考[他们的离线文档](https://docs.k0sproject.io/v1.23.8+k0s.0/airgap-install/)自己打包。






