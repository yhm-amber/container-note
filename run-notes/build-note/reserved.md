## `scratch`

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

*这个镜像是 `docker` 在自己 Hub 里的一个保留（ reserved ）镜像，保留就是占位的意思——不理解的话就想想「保留字」是什么含义来着😃。*

*总之，你不能用这个镜像，你也不能把别的镜像叫这个名字，你不能运行它，但你可以在 `Dockerfile` 里头写 `FROM scratch` ——然后人家就知道你现在不是要**使用基础镜像**而是要**构建基础镜像**了。*

*强调它是个保留名称的目的就是在于强调，如果写 `FROM scratch` 在容器文件里，并不会导致真的拉取一个空镜像。那个镜像不能被拉取，而这是个特殊的名称，可以触发 `docker` 这样的容器应用做特殊的不同以往的事情。**它并不会拉取镜像并且那个镜像也不能被拉取**，这就是说它是 reserved name 而不是 some normal name 的意思，而且也正是通过如此，才有了基础镜像和非基础镜像的区别，不然如果 `scratch` 真的可以被拉去被运行就像别的镜像一样的话，那么，全 Docker 世界的基础镜像，不就只能有 `scratch` 它自己了嘛……😃*

更多见： https://codeburst.io/docker-from-scratch-2a84552470c8
