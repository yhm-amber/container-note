
## List

当你一口气看很多 `Namespace` 的资源定义的时候，比如用 `kubectl get ns -o yaml -- ns1 ns2 ns3` 的话，你会发现，你得到的并不是基于 `Yaml` 语言的分隔符（即 `---` 标识开头以及 `...` 标识结尾）而给出的多个资源定义，你得到的会是一个 `List` 类型（ `Kind` ）的 Kubernetes 资源。

简洁的类似于这样：

~~~ yaml
apiVersion: v1
items:
- apiVersion: v1
  kind: Namespace
  metadata:
    name: ns1
- apiVersion: v1
  kind: Namespace
  metadata:
    name: ns2
- apiVersion: v1
  kind: Namespace
  metadata:
    name: ns3
kind: List
~~~

上面是简化掉不必要信息后的资源定义。

如果应用它的话，效果同应用多个资源定义是一样的。

就是说， `List` 类型可以帮我们组织我们的资源。

（唯一不太舒服的就是要靠缩进来表达层次。没办法， Kubernetes 现在支持的资源定义的文本表达格式只有 `Json` 和 `Yaml` 两种， `Yaml` 当然也是先被（应该是 `kubectl` ）按照其**自有**规则转换成 `Json` 然后提交的。因为，当你使用一些 `Yaml` 语法时，是有可能不能被 Kubernetes 组件（应该是 `kubectl` ）所解析的，而此时的报错中就会告诉你，错误原因就是转换 `Json` 失败。）

那么， `List` 可以嵌套吗？像这样：

~~~ yaml
kind: List
items:
- kind: Namespace
  metadata:
    name: ns1
  apiVersion: v1
- kind: List
  items:
  - kind: Namespace
    apiVersion: v1
    metadata:
      name: ns2
  apiVersion: v1
- kind: List
  items:
  - kind: Namespace
    metadata:
      name: ns3
    apiVersion: v1
  apiVersion: v1
apiVersion: v1
~~~

不能。我也试了试更简单的，只要有 `List` 类型的嵌套就不能。

报错的理由是 `error: *unstructured.Unstructured is not a list: no Items field in this object` 。

这里是一些关于 `List` 类型的讨论：

- ref: https://github.com/kubernetes/kubectl/issues/837
  
  这里有提到说， `List` 并非是一种资源类型。
  
  我觉得这就挺可惜的，应该把它设计成为一种资源类型。



