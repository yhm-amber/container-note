
## 安装

一般都装着。

一般的系统都是用 `openssh` 。

小设备可以用 `dropbear` ，比如在安卓机上的话，在 termux 里可以这样：

~~~ sh
pkg in dropbear
~~~

## 免密

需要做的就是：
1. 生成密钥对
2. 把密钥对的公钥向目标节点分发

### 密钥生成

~~~ sh
ssh-keygen -t rsa
~~~

这会在 `~/.ssh` 生成 `id_rsa` 和 `id_rsa.pub` 。

### 密钥分发

原理就是在目标机器的 `~/.ssh/authorized_keys` 文件内追加本机的公钥信息。

~~~ sh
ssh-copy-id -i ~/.ssh/id_rsa.pub -- someuser@somehostip
~~~

此时需要输入目标机器的目标用户（不写就会用当前用户名作为目标用户名）的密码。输入后，相应信息就会写入完成，再次对该目标机用该用户名 `ssh` 时即不需再输入密码。

