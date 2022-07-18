
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

关于探针的笔记： [`../kubernetes-note#探针`](../kubernetes-note#探针) 。

