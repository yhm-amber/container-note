
ref: https://olm.operatorframework.io/docs/getting-started/  

~~~ sh
operator-sdk olm install
~~~

需要先有 `operator-sdk` ……这东西应该是正在跟 `kubebuilder` 合并，但是看官网的话好像安装起来还是就安它自己： https://sdk.operatorframework.io/docs/installation/ 

取得 `operator-sdk` 命令，大体就是下了个二进制然后加执行权限后挪到 `PATH` 路径下。

用它安装 `olm` 的时候，因为是从 github 下载 release 所以可能会联网失败。我这里有个比较笨的解决办法：

~~~ sh
while ! operator-sdk olm install ; do echo :::: $((++x)) ; done
~~~

就是失败自动重试。看了眼[帮助文档](https://sdk.operatorframework.io/docs/cli/operator-sdk_olm_install/)，没找到 Airgap 安装的途径。

