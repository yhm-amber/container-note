
Docker 公司出的 Hub 镜像方案。

see: https://docs.docker.com/registry/

## by [`twuni`](https://github.com/twuni)

ref: https://github.com/twuni/docker-registry.helm

## by [`stille`](https://www.ioiox.com/stille.html)

ref: https://www.ioiox.com/archives/127.html


- 镜像： `registry` `docker.io/library/registry`
- 镜像内数据目录： `/var/lib/registry`
- 镜像内进程默认监听端口： `5000`

启动单机的服务 (`-d`) ，容器名为 `registryd` ，容器内监听端口映射为节点的 `5080` ，指定 `registry-1.docker.io` 为上游仓库（默认应该是用 `docker.io` 了吧）：

~~~ sh
docker run -d --restart always \
    --name registryd -p 5080:5000 \
    -v /data/registry:/var/lib/registry \
    -e REGISTRY_PROXY_REMOTEURL=https://registry-1.docker.io \
    -- registry:2
~~~

这里使用了容器外的 `/data/registry` 目录作为数据目录的映射。对此，也可使用 `volume` 或者分布式存储在本机目录的挂在位置来取得可靠的存储（如 JuiceFS 可以做到这种事）。

然后就可以以 `该节点地址(IP/HOST):端口(5080)` 的形式使用该本地仓库服务了。也可以把它反向代理为域名使用。

另外，由于它的存储依赖于外部、本身只是个无状态的服务，因此可以作为 `Deployment` 资源在 Kubernetes 上部署，那么反向代理能力也已经由 Kubernetes 的 `Service` 资源提供了。
