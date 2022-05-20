项目地址： [`labring/sealos`](https://github.com/labring/sealos.git) 

使用它能快速部署一个 Kubernetes 。

## 示例

### 机器

|地址|节点名|操作系统|
|----|------|---|
|`10.101.100.71`|`e1`|`openeuler  - 5.10.0-60.28.0.58.oe2203.x86_64`|
|`10.101.100.72`|`e2`|
|`10.101.100.73`|`e3`|

这仨我打算都用来做 Master 并同时允许往它们身上调度 Pod 。

像这样就可以了：

### 部署

有两种部署：

- 部署 `sealos` 这个单二进制
- 使用 `sealos` 部署 Kubernetes （这里选用版本 `v1.21.12` ）

### Sealos

下载单二进制文件 `sealos` 到 `PATH` 目录下，然后就没有然后了，接下来就可以用 `sealos` 命令了。

下载地址见项目 [Releases](https://github.com/labring/sealos/releases) 页面。

这个页面还给出了另外一种途径：拉取 `fanux/sealos` 镜像（ `docker.io/fanux/sealos:latest` ）。但我没找到这个镜像的使用说明。

### Kubernetes

你需要给 `sealos` 传的参数，只有必要的信息。

~~~ sh
: 把你的密码存入一个变量
read xx # 回车后输入你这多台机器的密码然后再回车结束输入

: 再执行这一条命令就能按照你的参数部署 Kubernetes 了
sealos init --passwd "$xx" --master 10.101.100.71 --master 10.101.100.72 --master 10.101.100.73 --pkg-url https://sealyun.oss-cn-xx.xxx.com/e1d1aaab0831a5153dfc03686d0d6b17-v1.21.12/kube1.21.12.tar.gz --version v1.21.12
~~~

密码、地址、离线包、版本号。

离线包可以下下来填路径，也可以填一个网络路径。

示例代码的网络路径不可用，可用的路径请通过[官网](https://sealyun.com)获取。

<details>
<summary>输出结果</summary>
~~~ text

~~~
</details>

删除：

~~~ sh
sealos clean --all
~~~

<details>
<summary>输出结果</summary>
~~~ text

~~~
</details>


