如果需要没有基础镜像，也就是说……要制作基础镜像，需要 `FROM` 一个空的东西，则需要：

~~~ Dockerfile
FROM scratch
...
~~~

容器文件或者封口器的集群文件都是这么写。

（感谢 [`sealerio/sealer`](https://github.com/sealerio/sealer) 的作者 [`fanux`](https://github.com/fanux) 给予的提示。）

我不知道为什么是 `scratch` 这个单词，我不知道这和那个同名的幼儿编程软件是不是有什么关系……

这个是它的 `dockerhub` 页面： https://hub.docker.com/_/scratch/

*里面大体意思说，虽然在人家 Hub 里有这么个镜像存储库，但它不可被拉取运行或者改名。*

*这个镜像是 `docker` 在自己 Hub 里的一个保留镜像，保留就是占位的意思——不理解的话就想想「保留字」是什么含义来着😃。*

*总之，你不能用这个镜像，你也不能把别的镜像叫这个名字，你不能运行它，但你可以在 `Dockerfile` 里头写 `FROM scratch` ——然后人家就知道你现在不是要**使用基础镜像**而是要**构建基础镜像**了。*

更多见： https://codeburst.io/docker-from-scratch-2a84552470c8
