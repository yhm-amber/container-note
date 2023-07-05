# 问题提出

**哪个命令或者组件**

eg. `sealos init` or `kubelet`

**描述这个缺陷**

我在 openeuler 22.03 LTS 使用 `sealos init` 完成了安装，但节点一直 `NotReady` ，看 `journalctl` 日志是 `cni plugin not initialized` 。

**重现步骤（如果有需要可以附加图片）**

操作系统：openeuler 22.03 LTS
处理器架构： x86_64
机器：虚拟机： 16CPU 40960MiB 256G存储

主动安装过的软件： `cockpit` `screen` `git` `cargo` `linuxbrew` 

`sealos` 版本：

~~~ text
Version: 3.3.9-rc.11
Last Commit: 49e79d2
Build Date: 2022-02-17T06:17:34Z
~~~

`sealos` 使用：

~~~ sh
sealos init --passwd "$x" --master 10.101.100.71 --master 10.101.100.72 --master 10.101.100.73 --pkg-url kube-v1.21.12.tar.gz --version v1.21.12
~~~

**测试结果**

安装是成功的，但节点 `NotReady` 。

这是我看到的：

<pre><font color="#55FFFF"><b>17:06:32 [INFO] [ssh.go:65] [10.101.100.72:22] [check-etcd] Checking that the etcd cluster is healthy</b></font>
<font color="#55FFFF"><b>17:06:32 [INFO] [ssh.go:65] [10.101.100.72:22] [kubelet-start] Writing kubelet configuration to file &quot;/var/lib/kubelet/config.yaml&quot;</b></font>
<font color="#55FFFF"><b>17:06:32 [INFO] [ssh.go:65] [10.101.100.72:22] [kubelet-start] Writing kubelet environment file with flags to file &quot;/var/lib/kubelet/kubeadm-flags.env&quot;</b></font>
<font color="#55FFFF"><b>17:06:32 [INFO] [ssh.go:65] [10.101.100.72:22] [kubelet-start] Starting the kubelet</b></font>
<font color="#55FFFF"><b>17:06:33 [INFO] [ssh.go:65] [10.101.100.72:22] [kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...</b></font>
<font color="#55FFFF"><b>17:06:44 [INFO] [ssh.go:65] [10.101.100.73:22] [etcd] Announced new etcd member joining to the existing etcd cluster</b></font>
<font color="#55FFFF"><b>17:06:44 [INFO] [ssh.go:65] [10.101.100.73:22] [etcd] Creating static Pod manifest for &quot;etcd&quot;</b></font>
<font color="#55FFFF"><b>17:06:44 [INFO] [ssh.go:65] [10.101.100.73:22] [etcd] Waiting for the new etcd member to join the cluster. This can take up to 40s</b></font>
<font color="#55FFFF"><b>17:06:53 [INFO] [ssh.go:65] [10.101.100.73:22] [upload-config] Storing the configuration used in ConfigMap &quot;kubeadm-config&quot; in the &quot;kube-system&quot; Namespace</b></font>
<font color="#55FFFF"><b>17:07:00 [INFO] [ssh.go:65] [10.101.100.73:22] [mark-control-plane] Marking the node e3 as control-plane by adding the labels: [node-role.kubernetes.io/master(deprecated) node-role.kubernetes.io/control-plane node.kubernetes.io/exclude-from-external-load-balancers]</b></font>
<font color="#55FFFF"><b>17:07:00 [INFO] [ssh.go:65] [10.101.100.73:22] [mark-control-plane] Marking the node e3 as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]</b></font>
<font color="#55FFFF"><b>17:07:00 [INFO] [ssh.go:65] [10.101.100.72:22] [etcd] Announced new etcd member joining to the existing etcd cluster</b></font>
<font color="#55FFFF"><b>17:07:00 [INFO] [ssh.go:65] [10.101.100.72:22] [etcd] Creating static Pod manifest for &quot;etcd&quot;</b></font>
<font color="#55FFFF"><b>17:07:00 [INFO] [ssh.go:65] [10.101.100.72:22] [etcd] Waiting for the new etcd member to join the cluster. This can take up to 40s</b></font>
<font color="#55FFFF"><b>17:07:01 [INFO] [ssh.go:65] [10.101.100.73:22] </b></font>
<font color="#55FFFF"><b>17:07:01 [INFO] [ssh.go:65] [10.101.100.73:22] This node has joined the cluster and a new control plane instance was created:</b></font>
<font color="#55FFFF"><b>17:07:01 [INFO] [ssh.go:65] [10.101.100.73:22] </b></font>
<font color="#55FFFF"><b>17:07:01 [INFO] [ssh.go:65] [10.101.100.73:22] * Certificate signing request was sent to apiserver and approval was received.</b></font>
<font color="#55FFFF"><b>17:07:01 [INFO] [ssh.go:65] [10.101.100.73:22] * The Kubelet was informed of the new secure connection details.</b></font>
<font color="#55FFFF"><b>17:07:01 [INFO] [ssh.go:65] [10.101.100.73:22] * Control plane (master) label and taint were applied to the new node.</b></font>
<font color="#55FFFF"><b>17:07:01 [INFO] [ssh.go:65] [10.101.100.73:22] * The Kubernetes control plane instances scaled up.</b></font>
<font color="#55FFFF"><b>17:07:01 [INFO] [ssh.go:65] [10.101.100.73:22] * A new etcd member was added to the local/stacked etcd cluster.</b></font>
<font color="#55FFFF"><b>17:07:01 [INFO] [ssh.go:65] [10.101.100.73:22] </b></font>
<font color="#55FFFF"><b>17:07:01 [INFO] [ssh.go:65] [10.101.100.73:22] To start administering your cluster from this node, you need to run the following as a regular user:</b></font>
<font color="#55FFFF"><b>17:07:01 [INFO] [ssh.go:65] [10.101.100.73:22] </b></font>
<font color="#55FFFF"><b>17:07:01 [INFO] [ssh.go:65] [10.101.100.73:22] </b></font>	<font color="#55FFFF"><b>mkdir -p $HOME/.kube</b></font>
<font color="#55FFFF"><b>17:07:01 [INFO] [ssh.go:65] [10.101.100.73:22] </b></font>	<font color="#55FFFF"><b>sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config</b></font>
<font color="#55FFFF"><b>17:07:01 [INFO] [ssh.go:65] [10.101.100.73:22] </b></font>	<font color="#55FFFF"><b>sudo chown $(id -u):$(id -g) $HOME/.kube/config</b></font>
<font color="#55FFFF"><b>17:07:01 [INFO] [ssh.go:65] [10.101.100.73:22] </b></font>
<font color="#55FFFF"><b>17:07:01 [INFO] [ssh.go:65] [10.101.100.73:22] Run &apos;kubectl get nodes&apos; to see this node join the cluster.</b></font>
<font color="#55FFFF"><b>17:07:01 [INFO] [ssh.go:65] [10.101.100.73:22] </b></font>
<font color="#55FF55"><b>17:07:01 [DEBG] [ssh.go:72] [10.101.100.73:22] sed &quot;s/10.101.100.71 apiserver.cluster.local/10.101.100.73 apiserver.cluster.local/g&quot; -i /etc/hosts</b></font>
<font color="#55FF55"><b>17:07:01 [DEBG] [ssh.go:72] [10.101.100.73:22] rm -rf .kube/config &amp;&amp; mkdir -p /root/.kube &amp;&amp; cp /etc/kubernetes/admin.conf /root/.kube/config &amp;&amp; chmod 600 /root/.kube/config</b></font>
<font color="#55FF55"><b>17:07:02 [DEBG] [ssh.go:72] [10.101.100.73:22] rm -rf /root/kube || :</b></font>
<font color="#55FFFF"><b>17:07:03 [INFO] [ssh.go:65] [10.101.100.72:22] [upload-config] Storing the configuration used in ConfigMap &quot;kubeadm-config&quot; in the &quot;kube-system&quot; Namespace</b></font>
<font color="#55FFFF"><b>17:07:03 [INFO] [ssh.go:65] [10.101.100.72:22] [mark-control-plane] Marking the node e2 as control-plane by adding the labels: [node-role.kubernetes.io/master(deprecated) node-role.kubernetes.io/control-plane node.kubernetes.io/exclude-from-external-load-balancers]</b></font>
<font color="#55FFFF"><b>17:07:03 [INFO] [ssh.go:65] [10.101.100.72:22] [mark-control-plane] Marking the node e2 as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]</b></font>
<font color="#55FFFF"><b>17:07:03 [INFO] [ssh.go:65] [10.101.100.72:22] </b></font>
<font color="#55FFFF"><b>17:07:03 [INFO] [ssh.go:65] [10.101.100.72:22] This node has joined the cluster and a new control plane instance was created:</b></font>
<font color="#55FFFF"><b>17:07:03 [INFO] [ssh.go:65] [10.101.100.72:22] </b></font>
<font color="#55FFFF"><b>17:07:03 [INFO] [ssh.go:65] [10.101.100.72:22] * Certificate signing request was sent to apiserver and approval was received.</b></font>
<font color="#55FFFF"><b>17:07:03 [INFO] [ssh.go:65] [10.101.100.72:22] * The Kubelet was informed of the new secure connection details.</b></font>
<font color="#55FFFF"><b>17:07:03 [INFO] [ssh.go:65] [10.101.100.72:22] * Control plane (master) label and taint were applied to the new node.</b></font>
<font color="#55FFFF"><b>17:07:03 [INFO] [ssh.go:65] [10.101.100.72:22] * The Kubernetes control plane instances scaled up.</b></font>
<font color="#55FFFF"><b>17:07:03 [INFO] [ssh.go:65] [10.101.100.72:22] * A new etcd member was added to the local/stacked etcd cluster.</b></font>
<font color="#55FFFF"><b>17:07:03 [INFO] [ssh.go:65] [10.101.100.72:22] </b></font>
<font color="#55FFFF"><b>17:07:03 [INFO] [ssh.go:65] [10.101.100.72:22] To start administering your cluster from this node, you need to run the following as a regular user:</b></font>
<font color="#55FFFF"><b>17:07:03 [INFO] [ssh.go:65] [10.101.100.72:22] </b></font>
<font color="#55FFFF"><b>17:07:03 [INFO] [ssh.go:65] [10.101.100.72:22] </b></font>	<font color="#55FFFF"><b>mkdir -p $HOME/.kube</b></font>
<font color="#55FFFF"><b>17:07:03 [INFO] [ssh.go:65] [10.101.100.72:22] </b></font>	<font color="#55FFFF"><b>sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config</b></font>
<font color="#55FFFF"><b>17:07:03 [INFO] [ssh.go:65] [10.101.100.72:22] </b></font>	<font color="#55FFFF"><b>sudo chown $(id -u):$(id -g) $HOME/.kube/config</b></font>
<font color="#55FFFF"><b>17:07:03 [INFO] [ssh.go:65] [10.101.100.72:22] </b></font>
<font color="#55FFFF"><b>17:07:03 [INFO] [ssh.go:65] [10.101.100.72:22] Run &apos;kubectl get nodes&apos; to see this node join the cluster.</b></font>
<font color="#55FFFF"><b>17:07:03 [INFO] [ssh.go:65] [10.101.100.72:22] </b></font>
<font color="#55FF55"><b>17:07:03 [DEBG] [ssh.go:72] [10.101.100.72:22] sed &quot;s/10.101.100.71 apiserver.cluster.local/10.101.100.72 apiserver.cluster.local/g&quot; -i /etc/hosts</b></font>
<font color="#55FF55"><b>17:07:04 [DEBG] [ssh.go:72] [10.101.100.72:22] rm -rf .kube/config &amp;&amp; mkdir -p /root/.kube &amp;&amp; cp /etc/kubernetes/admin.conf /root/.kube/config &amp;&amp; chmod 600 /root/.kube/config</b></font>
<font color="#55FF55"><b>17:07:04 [DEBG] [ssh.go:72] [10.101.100.72:22] rm -rf /root/kube || :</b></font>
<font color="#55FF55"><b>17:07:05 [DEBG] [print.go:35] ==&gt;SendPackage==&gt;KubeadmConfigInstall==&gt;InstallMaster0==&gt;JoinMasters</b></font>
<font color="#55FFFF"><b>17:07:05 [INFO] [print.go:39] sealos install success.</b></font>
<font color="#55FFFF"><b>17:07:05 [INFO] [init.go:96] </b></font>
<font color="#55FFFF"><b>      ___           ___           ___           ___       ___           ___     </b></font>
<font color="#55FFFF"><b>     /\  \         /\  \         /\  \         /\__\     /\  \         /\  \    </b></font>
<font color="#55FFFF"><b>    /::\  \       /::\  \       /::\  \       /:/  /    /::\  \       /::\  \   </b></font>
<font color="#55FFFF"><b>   /:/\ \  \     /:/\:\  \     /:/\:\  \     /:/  /    /:/\:\  \     /:/\ \  \  </b></font>
<font color="#55FFFF"><b>  _\:\~\ \  \   /::\~\:\  \   /::\~\:\  \   /:/  /    /:/  \:\  \   _\:\~\ \  \ </b></font>
<font color="#55FFFF"><b> /\ \:\ \ \__\ /:/\:\ \:\__\ /:/\:\ \:\__\ /:/__/    /:/__/ \:\__\ /\ \:\ \ \__\</b></font>
<font color="#55FFFF"><b> \:\ \:\ \/__/ \:\~\:\ \/__/ \/__\:\/:/  / \:\  \    \:\  \ /:/  / \:\ \:\ \/__/</b></font>
<font color="#55FFFF"><b>  \:\ \:\__\    \:\ \:\__\        \::/  /   \:\  \    \:\  /:/  /   \:\ \:\__\  </b></font>
<font color="#55FFFF"><b>   \:\/:/  /     \:\ \/__/        /:/  /     \:\  \    \:\/:/  /     \:\/:/  /  </b></font>
<font color="#55FFFF"><b>    \::/  /       \:\__\         /:/  /       \:\__\    \::/  /       \::/  /   </b></font>
<font color="#55FFFF"><b>     \/__/         \/__/         \/__/         \/__/     \/__/         \/__/  </b></font>

<font color="#55FFFF"><b>                  官方文档：sealyun.com</b></font>
<font color="#55FFFF"><b>                  项目地址：github.com/fanux/sealos</b></font>
<font color="#55FFFF"><b>                  QQ群   ：98488045</b></font>
<font color="#55FFFF"><b>                  常见问题：sealyun.com/faq</b></font>

[root@e1 ~]# kubectl get no
NAME   STATUS     ROLES                  AGE   VERSION
e1     NotReady   control-plane,master   85s   v1.21.12
e2     NotReady   control-plane,master   36s   v1.21.12
e3     NotReady   control-plane,master   45s   v1.21.12
[root@e1 ~]# journalctl -f -u kubelet
-- Journal begins at Thu 2022-05-19 20:34:58 CST. --
5月 23 17:08:09 e1 kubelet[2764337]: E0523 17:08:09.354088 2764337 kubelet.go:2211] &quot;Container runtime network not ready&quot; networkReady=&quot;NetworkReady=false reason:NetworkPluginNotReady message:Network plugin returns error: cni plugin not initialized&quot;
5月 23 17:08:14 e1 kubelet[2764337]: E0523 17:08:14.355297 2764337 kubelet.go:2211] &quot;Container runtime network not ready&quot; networkReady=&quot;NetworkReady=false reason:NetworkPluginNotReady message:Network plugin returns error: cni plugin not initialized&quot;
5月 23 17:08:19 e1 kubelet[2764337]: E0523 17:08:19.234374 2764337 remote_runtime.go:144] &quot;StopPodSandbox from runtime service failed&quot; err=&quot;rpc error: code = Unknown desc = failed to destroy network for sandbox \&quot;6cf7dbf9ec8f2aba8db3c520c715d8faa15bf1edd773b448f5dbb2ba1612494f\&quot;: cni plugin not initialized&quot; podSandboxID=&quot;6cf7dbf9ec8f2aba8db3c520c715d8faa15bf1edd773b448f5dbb2ba1612494f&quot;
5月 23 17:08:19 e1 kubelet[2764337]: E0523 17:08:19.234412 2764337 kuberuntime_gc.go:176] &quot;Failed to stop sandbox before removing&quot; err=&quot;rpc error: code = Unknown desc = failed to destroy network for sandbox \&quot;6cf7dbf9ec8f2aba8db3c520c715d8faa15bf1edd773b448f5dbb2ba1612494f\&quot;: cni plugin not initialized&quot; sandboxID=&quot;6cf7dbf9ec8f2aba8db3c520c715d8faa15bf1edd773b448f5dbb2ba1612494f&quot;
5月 23 17:08:19 e1 kubelet[2764337]: E0523 17:08:19.234853 2764337 remote_runtime.go:144] &quot;StopPodSandbox from runtime service failed&quot; err=&quot;rpc error: code = Unknown desc = failed to destroy network for sandbox \&quot;9b42a80a4fa2c85f104af4bf07adcba18496ea7655566e0240d279fe20c1311b\&quot;: cni plugin not initialized&quot; podSandboxID=&quot;9b42a80a4fa2c85f104af4bf07adcba18496ea7655566e0240d279fe20c1311b&quot;
5月 23 17:08:19 e1 kubelet[2764337]: E0523 17:08:19.234878 2764337 kuberuntime_gc.go:176] &quot;Failed to stop sandbox before removing&quot; err=&quot;rpc error: code = Unknown desc = failed to destroy network for sandbox \&quot;9b42a80a4fa2c85f104af4bf07adcba18496ea7655566e0240d279fe20c1311b\&quot;: cni plugin not initialized&quot; sandboxID=&quot;9b42a80a4fa2c85f104af4bf07adcba18496ea7655566e0240d279fe20c1311b&quot;
5月 23 17:08:19 e1 kubelet[2764337]: E0523 17:08:19.235477 2764337 remote_runtime.go:144] &quot;StopPodSandbox from runtime service failed&quot; err=&quot;rpc error: code = Unknown desc = failed to destroy network for sandbox \&quot;c0ec349588cae635853f5ff38986a7fae70d9a1f89eb2fe6846e254938abe258\&quot;: cni plugin not initialized&quot; podSandboxID=&quot;c0ec349588cae635853f5ff38986a7fae70d9a1f89eb2fe6846e254938abe258&quot;
5月 23 17:08:19 e1 kubelet[2764337]: E0523 17:08:19.235522 2764337 kuberuntime_gc.go:176] &quot;Failed to stop sandbox before removing&quot; err=&quot;rpc error: code = Unknown desc = failed to destroy network for sandbox \&quot;c0ec349588cae635853f5ff38986a7fae70d9a1f89eb2fe6846e254938abe258\&quot;: cni plugin not initialized&quot; sandboxID=&quot;c0ec349588cae635853f5ff38986a7fae70d9a1f89eb2fe6846e254938abe258&quot;
5月 23 17:08:19 e1 kubelet[2764337]: E0523 17:08:19.356209 2764337 kubelet.go:2211] &quot;Container runtime network not ready&quot; networkReady=&quot;NetworkReady=false reason:NetworkPluginNotReady message:Network plugin returns error: cni plugin not initialized&quot;
5月 23 17:08:24 e1 kubelet[2764337]: E0523 17:08:24.357257 2764337 kubelet.go:2211] &quot;Container runtime network not ready&quot; networkReady=&quot;NetworkReady=false reason:NetworkPluginNotReady message:Network plugin returns error: cni plugin not initialized&quot;
5月 23 17:08:29 e1 kubelet[2764337]: E0523 17:08:29.358299 2764337 kubelet.go:2211] &quot;Container runtime network not ready&quot; networkReady=&quot;NetworkReady=false reason:NetworkPluginNotReady message:Network plugin returns error: cni plugin not initialized&quot;
5月 23 17:08:34 e1 kubelet[2764337]: E0523 17:08:34.360015 2764337 kubelet.go:2211] &quot;Container runtime network not ready&quot; networkReady=&quot;NetworkReady=false reason:NetworkPluginNotReady message:Network plugin returns error: cni plugin not initialized&quot;
5月 23 17:08:39 e1 kubelet[2764337]: E0523 17:08:39.360674 2764337 kubelet.go:2211] &quot;Container runtime network not ready&quot; networkReady=&quot;NetworkReady=false reason:NetworkPluginNotReady message:Network plugin returns error: cni plugin not initialized&quot;
^C
[root@e1 ~]# firewall-cmd --get-zones
<font color="#FF5555">FirewallD is not running</font>
[root@e1 ~]# </pre>


**期望结果**

期望不要出现上述错误。。。或者，我可以通过什么线索去排查这个问题？

# 定位

一定程度上定位到问题了：似乎是 `v1.21.12` 的问题。

因为这个版本在 centos7 上也会 `NotReady` ，看日志也是一样的报错。

我在 openEuler 22.03 LTS 上 `sealos clean --all` 了以后，执行了这个：

~~~ sh
sealos init --passwd "$xx" --master 10.101.100.71 --master 10.101.100.72 --master 10.101.100.73 --pkg-url https://xxx/kube1.19.16.tar.gz --version v1.19.16
~~~

然后就成功了：

<pre><font color="#55FFFF"><b>19:03:09 [INFO] [ssh.go:65] [10.101.100.72:22] </b></font>	<font color="#55FFFF"><b>sudo chown $(id -u):$(id -g) $HOME/.kube/config</b></font>
<font color="#55FFFF"><b>19:03:09 [INFO] [ssh.go:65] [10.101.100.72:22] </b></font>
<font color="#55FFFF"><b>19:03:09 [INFO] [ssh.go:65] [10.101.100.72:22] Run &apos;kubectl get nodes&apos; to see this node join the cluster.</b></font>
<font color="#55FFFF"><b>19:03:09 [INFO] [ssh.go:65] [10.101.100.72:22] </b></font>
<font color="#55FF55"><b>19:03:09 [DEBG] [ssh.go:72] [10.101.100.72:22] sed &quot;s/10.101.100.71 apiserver.cluster.local/10.101.100.72 apiserver.cluster.local/g&quot; -i /etc/hosts</b></font>
<font color="#55FF55"><b>19:03:10 [DEBG] [ssh.go:72] [10.101.100.72:22] rm -rf .kube/config &amp;&amp; mkdir -p /root/.kube &amp;&amp; cp /etc/kubernetes/admin.conf /root/.kube/config &amp;&amp; chmod 600 /root/.kube/config</b></font>
<font color="#55FF55"><b>19:03:10 [DEBG] [ssh.go:72] [10.101.100.72:22] rm -rf /root/kube || :</b></font>
<font color="#55FF55"><b>19:03:11 [DEBG] [print.go:35] ==&gt;SendPackage==&gt;KubeadmConfigInstall==&gt;InstallMaster0==&gt;JoinMasters</b></font>
<font color="#55FFFF"><b>19:03:11 [INFO] [print.go:39] sealos install success.</b></font>
<font color="#55FFFF"><b>19:03:11 [INFO] [init.go:96] </b></font>
<font color="#55FFFF"><b>      ___           ___           ___           ___       ___           ___     </b></font>
<font color="#55FFFF"><b>     /\  \         /\  \         /\  \         /\__\     /\  \         /\  \    </b></font>
<font color="#55FFFF"><b>    /::\  \       /::\  \       /::\  \       /:/  /    /::\  \       /::\  \   </b></font>
<font color="#55FFFF"><b>   /:/\ \  \     /:/\:\  \     /:/\:\  \     /:/  /    /:/\:\  \     /:/\ \  \  </b></font>
<font color="#55FFFF"><b>  _\:\~\ \  \   /::\~\:\  \   /::\~\:\  \   /:/  /    /:/  \:\  \   _\:\~\ \  \ </b></font>
<font color="#55FFFF"><b> /\ \:\ \ \__\ /:/\:\ \:\__\ /:/\:\ \:\__\ /:/__/    /:/__/ \:\__\ /\ \:\ \ \__\</b></font>
<font color="#55FFFF"><b> \:\ \:\ \/__/ \:\~\:\ \/__/ \/__\:\/:/  / \:\  \    \:\  \ /:/  / \:\ \:\ \/__/</b></font>
<font color="#55FFFF"><b>  \:\ \:\__\    \:\ \:\__\        \::/  /   \:\  \    \:\  /:/  /   \:\ \:\__\  </b></font>
<font color="#55FFFF"><b>   \:\/:/  /     \:\ \/__/        /:/  /     \:\  \    \:\/:/  /     \:\/:/  /  </b></font>
<font color="#55FFFF"><b>    \::/  /       \:\__\         /:/  /       \:\__\    \::/  /       \::/  /   </b></font>
<font color="#55FFFF"><b>     \/__/         \/__/         \/__/         \/__/     \/__/         \/__/  </b></font>

<font color="#55FFFF"><b>                  官方文档：sealyun.com</b></font>
<font color="#55FFFF"><b>                  项目地址：github.com/fanux/sealos</b></font>
<font color="#55FFFF"><b>                  QQ群   ：98488045</b></font>
<font color="#55FFFF"><b>                  常见问题：sealyun.com/faq</b></font>

[root@e1 ~]# kubectl get no
NAME   STATUS   ROLES    AGE     VERSION
e1     Ready    master   4m6s    v1.19.16
e2     Ready    master   3m25s   v1.19.16
e3     Ready    master   3m30s   v1.19.16
[root@e1 ~]# </pre>

据此，本 issue 标题就应该改为【安装 `kube1.21.12` 后节点 `NotReady` 】了。

# REF

`https://github.com/labring/sealos/issues/1044`

