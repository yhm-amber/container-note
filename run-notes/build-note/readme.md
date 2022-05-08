如果需要没有基础镜像，也就是说……要制作基础景象，需要 `FROM` 一个空的东西，则需要：

~~~ Dockerfile
FROM scratch
...
~~~

容器文件或者封口器的集群文件都是这么写。

（感谢 [`sealerio/sealer`](https://github.com/sealerio/sealer) 的作者 [`fanux`](https://github.com/fanux) 给予的提示。）

我不知道为什么是 `scratch` 这个单词，我不知道这和那个同名的幼儿编程软件是不是有什么关系……

更多见： https://codeburst.io/docker-from-scratch-2a84552470c8
