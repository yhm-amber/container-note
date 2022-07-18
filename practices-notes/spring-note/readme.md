
## 探针

这个是对 Kubernetes 的 Probe （探针）的支持。

ref: https://spring.io/blog/2020/03/25/liveness-and-readiness-probes-with-spring-boot  

> Actuator will gather the "Liveness" and "Readiness" information from the `ApplicationAvailability` and use that information in dedicated Health Indicators: `LivenessStateHealthIndicator` and `ReadinessStateHealthIndicator`. These indicators will be shown on the global health endpoint ("/actuator/health"). They will also be exposed as separate HTTP Probes using Health Groups: `"/actuator/health/liveness"` and `"/actuator/health/readiness"`.
> 

ref: https://github.com/alexandreroman/spring-k8s-probes-demo  

> 您可以使用 [Spring Boot Actuator](https://docs.spring.io/spring-boot/docs/current/reference/html/production-ready-features.html#production-ready) 轻松创建就绪度和活动度探头。您无需编写任何源代码。
> 
> 确保已添加 Spring Boot Actuator 依赖项：
> 
> ~~~ xml
> <dependency>
>     <groupId>org.springframework.boot</groupId>
>     <artifactId>spring-boot-starter-actuator</artifactId>
> </dependency>
> ~~~
> 
> 然后在您的 `application.properties` (or `yaml`) 中，创建两个运行状况检查组：
> 
> ~~~ properties
> management.endpoint.health.group.readiness.include=*
> management.endpoint.health.group.readiness.show-details=always
> 
> management.endpoint.health.group.liveness.include=ping
> management.endpoint.health.group.liveness.show-details=never
> ~~~
> 
> 在 `readiness` 组，包括所有现有的运行状况指示器（ health indicators ），以及详细信息。例如，如果您使用 Spring Data JPA ，将自动为您添加一个数据库指标，并且此指标将包含在此探测器中。
> 
> 仅当所有运行状况指示器（ health indicators ）都已启动时， `readiness` 探针（ probe ）才会只是返回一个 `200 OK` 状态。当你的应用部署到 Kubernetes 时，在你准备好处理传入的请求之前，你不希望提供流量：你需要确保外部服务（如数据库）可用。这正是这个探针（ probe ）在这里要为你做到的。
> 
> 至于 `liveness` 探针（ probe ）就非常简单了：它的要点就在于验证你的应用“活着”。也就是说，该探针（ probe ）需要做的，仅仅只是在不经过任何业务逻辑的情况下返回一个 `200 OK` 就行了，这就能证明应用“活着”。我们希望这个探针能够尽可能地快且简单，毕竟它还要经常地被 Kubernetes 调用（一般是一秒一次的周期）。
> 
> 如果用上了 Spring Boot Actuator ，这些探针（ probe ）就已经在下面这些路径上被准备好了：
> 
> - `readiness` 探针： `/actuator/health/readiness`
> - `liveness` 探针： `/actuator/health/liveness`
> 

关于探针：

ref: https://www.wqblogs.com/2019/10/03/Liveness,%20Readiness%E4%B8%8EStartup%20Probes/  

> - livenessProbe：健康状态检查，周期性检查服务是否存活，检查结果失败，将重启容器。
> - readinessProbe：可用性检查，周期性检查服务是否可用，不可用将从 service 的 endpoints 中移除。
> - startupProbe：启动探针，首次初始化时需要额外启动时间的应用程序，超过设定的启动时间，将被杀死。
> 
> kubelet 使用活跃度探头知道什么时候重新启动的容器。例如，活动性探针可能会陷入僵局，而应用程序正在运行，但无法取得进展。在这种状态下重新启动容器可以帮助使应用程序尽管存在错误也更可用。
> 
> kubelet 使用就绪性探测器来了解何时 Container 准备开始接受流量。当 Pod 的所有容器都准备就绪时，即视为准备就绪。此信号的一种用法是控制将哪些 Pod 用作服务的后端。当 Pod 尚未就绪时，会将其从服务负载平衡器中删除。
> 
> kubelet 使用启动探针来了解何时启动 Container 应用程序。如果配置了这样的探针，它将禁用活动性和就绪性检查，直到成功为止，以确保这些探针不会干扰应用程序的启动。这可用于对启动缓慢的容器进行活动检查，避免它们在启动和运行之前被 kubelet 杀死。
> 

