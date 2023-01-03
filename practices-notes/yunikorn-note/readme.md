## architect

[pic-architecture-blog]: https://clouderablog.wpenginepowered.com/wp-content/uploads/2019/07/YuniKorn-Architecture-Chart.jpg
[pic-architecture-docs]: https://yunikorn.apache.org/assets/images/architecture-333225e01d82300eb9ee34e76cf34697.png

[pic-architecture]: ./YuniKorn-Architecture-Chart_2019-07.jpg

![YuniKorn Architecture][pic-architecture]


git repo: 

- [`yunikorn-core.git`][repo-scheduler-core]: 
  > Apache YuniKorn 是一种用于容器编排器系统的轻量级通用资源调度程序。 YuniKorn 的架构设计还允许添加不同的 shim 层并采用不同的 ResourceManager 实现，包括 Apache Hadoop YARN 或任何其他系统。 
- [`yunikorn-scheduler-interface.git`][repo-scheduler-interface]: 
  > YuniKorn Scheduler Interface 为 `yunikorn-core` 和资源管理系统之间的通信定义了 protobuf 接口。 
- [`yunikorn-k8shim.git`][repo-kube-shim]: 
  > YuniKorn scheduler shim for kubernetes 是一个定制的 k8s 调度器，它可以部署在 K8s 集群中并作为调度器工作。所有实际的调度逻辑在 `yunikorn-core` 里封装，本层为使之成为 Kubernetes 调度器的实现。
- [`yunikorn-web.git`][repo-web-uiapp]: 
  > YuniKorn web 在调度程序之上提供了一个 web 界面。它提供了对当前和历史调度程序状态的洞察。页面的具体内容取决于 `yunikorn-core` ，它封装了所有实际的调度逻辑。
- [`yunikorn-site.git`][repo-site]: 
  > Site 的代码，可以构建和更新 Apache YuniKorn 网站。
- [`yunikorn-release.git`][repo-release]: 
  > 这里提供生成 Apache YuniKorn 发布工件所需的说明和工具。

[repo-scheduler-core]: https://github.com/apache/yunikorn-core.git
[repo-scheduler-interface]: https://github.com/apache/yunikorn-scheduler-interface.git
[repo-kube-shim]: https://github.com/apache/yunikorn-k8shim.git
[repo-web-uiapp]: https://github.com/apache/yunikorn-web.git
[repo-site]: https://github.com/apache/yunikorn-site.git
[repo-release]: https://github.com/apache/yunikorn-release.git


## using

[blog-intro]: https://blog.cloudera.com/yunikorn-a-universal-resources-scheduler
[docs-feature-zh]: https://yunikorn.apache.org/zh-cn/docs/get_started/core_features

[site]: https://yunikorn.apache.org


[docs]: https://yunikorn.apache.org/docs
[docs-zh]: https://yunikorn.apache.org/zh-cn/docs


### install

repo: 

~~~ sh
helm repo add -- yunikorn https://apache.github.io/yunikorn-release
~~~

simple: 

~~~ sh
helm repo update
helm install --namespace yunikorn --create-namespace -- yunikorn yunikorn/yunikorn
~~~

will install these by default: 

- `scheduler` (调度器)
- `web-server` (页面服务器)
- `admission-controller` (准入控制器)

其中：

- 当 `admission-controller` 一旦安装，它将把所有集群流量路由到 YuniKorn ，资源调度从而就会委托给 YuniKorn 。
  
  > When `admission-controller` is installed, it simply routes all traffic to YuniKorn. That means the resource scheduling is delegated to YuniKorn.
  > 
  
  用 `--set` flag 或者 `values` 配置覆盖把 `embedAdmissionController` 标志设置为 `false` 可以禁止该情况发生。
  
- YuniKorn 调度器也可以以 Kubernetes 的调度器插件的方式部署。把 `enableSchedulerPlugin` 标志设为 `true` 即可。
  
  > This will deploy an alternate Docker image which contains YuniKorn compiled together with the default scheduler. This new mode offers better compatibility with the default Kubernetes scheduler and is suitable for use with the admission controller delegating all scheduling to YuniKorn. Because this mode is still very new, it is not enabled by default.
  > 
  > 这种方式将会部署一个包含与默认调度器一起编译的 YuniKorn 备用 Docker 镜像。这种新模式借助默认的 Kubernetes 调度器提供了更好的兼容性，且适合同 (将所有调度委托给 YuniKorn 的) `admission-controller` 协同使用。该模式还很新，因而默认不开启。
  > 
  

more see: [Deployment Modes | Apache YuniKorn][docs-modes]

> YuniKorn can be deployed in two different modes: standard and plugin. In standard mode, YuniKorn runs as a customized Kubernetes scheduler. In plugin mode, YuniKorn is implemented as a set of plugins on top of the default Kubernetes scheduling framework.
> 
> YuniKorn 可以以两种不同的模式部署：标准模式和插件模式。在标准模式下， YuniKorn 作为自定义的 Kubernetes 调度程序运行。在插件模式下， YuniKorn 被实现为默认的 Kubernetes 调度框架之上的一组插件。 
> 

[docs-modes]: https://yunikorn.apache.org/docs/user_guide/deployment_modes

建议不论哪种情况下都运行准入控制器，这能确保集群里只有一个实际在工作的调度器。此时，始终都会运行的原来的调度器会被 (除了 YuniKorn 自身以外的) 所有 Pod 绕过——它只会调度 YuniKorn 的 Pod 。

- 如果你希望你所有的 Pod 都用 YuniKorn 调度，用一般模式 (不是插件的那个) 就行了。它稳定、高效且性能非常好。
- 如果你需要同一个集群里有多个 (可能不仅仅是 Kubernetes 自带的那个) 调度器一起工作，那就要用插件模式。但它目前没有前者的成熟度。

### web ui

~~~ sh
kubectl -n yunikorn port-forward -- svc/yunikorn-service 9889:9889
~~~

容器内应用默认监听 `9889` Port ，上面的命令可以让执行它的节点的 `9889` Port 被访问时，该访问会被转发为对容器内 `9889` Port 的访问。

> YuniKorn UI 提供了集群资源容量、利用率和所有应用信息的集中视图。
> 

## intro

ref: 

- [特征 | Apache YuniKorn][docs-feature-zh]
- [YuniKorn: a universal resources scheduler | Cloudera Blog][blog-intro]

