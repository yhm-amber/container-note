
Docker 公司出的 Hub 镜像方案。

see:

- https://docs.docker.com/registry/
- https://github.com/distribution/distribution.git

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

## 在线代理

### 镜像配置

ref: https://mirrors.ustc.edu.cn/help/dockerhub.html  
ref: https://mirrors.sjtug.sjtu.edu.cn/docs/docker-registry  
ref: https://www.ioiox.com/archives/38.html  


对 `/etc/docker` 下的 `daemon.json` 的 `.registry-mirrors` 字段做如下配置：

~~~ json
{
  "registry-mirrors": ["https://registry.docker-cn.com"]
}
~~~

配置更多候选：

~~~ json
{
  "registry-mirrors": [
    "https://registry.docker-cn.com",
    
    "https://docker.mirrors.ustc.edu.cn",
    "https://docker.mirrors.sjtug.sjtu.edu.cn",
    
    "https://hub-mirror.c.163.com",
    "https://mirror.baidubce.com",
    "https://reg-mirror.qiniu.com",
    "https://dockerhub.azk8s.cn",
    
    "https://dockerproxy.com"
  ]
}
~~~

生效需重载重启：

~~~ sh
sudo systemctl daemon-reload &&
sudo systemctl restart docker &&
:;
~~~

### 几个不同仓库的代理

ref: https://dockerproxy.com/docs  
ref: https://dockerproxy.com  

来自 `dockerproxy.com` 提供的代理：

| 仓库 | 代理使用 | 示例 |
| --- | --- | --- |
| Docker Hub | `docker.io`  <--  `dockerproxy.com` | 如对 `docker.io/nnn/mmm:tt` 可用 `dockerproxy.com/nnn/mmm:tt` 代替（根镜像即 `nnn` 处为 `library` 的镜像） |
| GitHub Container Registry | `ghcr.io`  <--  `ghcr.dockerproxy.com` | 如对 `ghcr.io/nnn/mmm:tt` 可用 `ghcr.dockerproxy.com/nnn/mmm:tt` 代替 |
| Google Container Registry | `gcr.io`  <--  `gcr.dockerproxy.com` | 如对 `gcr.io/nnn/mmm:tt` 可用 `gcr.dockerproxy.com/nnn/mmm:tt` 代替 |
| Google Kubernetes | `k8s.gcr.io`  <--  `k8s.dockerproxy.com` | 如对 `k8s.gcr.io/nnn/mmm:tt` 可用 `k8s.dockerproxy.com/nnn/mmm:tt` 代替（根镜像即没有 `nnn` 部分的镜像） |
| Quay.io | `quay.io`  <--  `quay.dockerproxy.com` | 如对 `quay.io/nnn/mmm:tt` 可用 `quay.dockerproxy.com/nnn/mmm:tt` 代替 |

