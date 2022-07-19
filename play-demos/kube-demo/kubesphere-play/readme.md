
## workspace

也就是“企业空间”，其实我觉得叫“工作空间”更舒服。

项目（命名空间）与一个工作空间关联，在一个工作空间麾下。

在安装 `kubesphere` 过后，基于 `yaml` 的关联就是这样的：

~~~~ yaml
apiVersion: v1
kind: Namespace
metadata:
  labels:
    kubesphere.io/namespace: ownerReferences
    kubesphere.io/workspace: dev-yhm
  name: dev-someapp-yhm
~~~~

即在 `ns.metadata.labels` 添加一条 `kubesphere.io/workspace: dev-yhm` ，即可让 `dev-someapp-yhm` 这个 `Namespace` 与 `dev-yhm` 这个 `Workspace` 关联。

关联后，从界面上即可看到，命名空间（项目） `dev-someapp-yhm` 将会以 `dev-yhm` 的所属物的形式存在。

创建（或者应用）这样的命名空间后，再用 `kubectl get ns -o yaml -- ownerReferences` 查看的话，会发现，和 `workspace` 有关的坐标由多了，多了个 `ns.metadata.ownerReferences` ，在里面可以看到，相应工作似乎是由控制器（ `controller` ）完成的（我只是看样子猜不一定对）。
