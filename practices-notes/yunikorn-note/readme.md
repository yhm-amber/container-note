
[blog-intro]: https://blog.cloudera.com/yunikorn-a-universal-resources-scheduler
[site]: https://yunikorn.apache.org

[repo-scheduler-core]: https://github.com/apache/yunikorn-core.git
[repo-scheduler-interface]: https://github.com/apache/yunikorn-scheduler-interface.git
[repo-kube-shim]: https://github.com/apache/yunikorn-k8shim.git
[repo-web-uiapp]: https://github.com/apache/yunikorn-web.git
[repo-site]: https://github.com/apache/yunikorn-site.git
[repo-release]: https://github.com/apache/yunikorn-release.git

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

- `scheduler`
- `web-server`
- `admission-controller`

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

