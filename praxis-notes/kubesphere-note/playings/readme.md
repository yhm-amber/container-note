像这样新增示例用户：

![5523cffec4053c0615cdf7c33520d731.png](.pics/5523cffec4053c0615cdf7c33520d731.png)

保存。

在示例企业空间成员里增加该用户：

![6c4ec0dbc446e84f9cebab4468f1d0b4.png](.pics/6c4ec0dbc446e84f9cebab4468f1d0b4.png)

我这里邀请之为该企业空间管理员。确认保存。

登出 `admin` 用户，登入 `demo-user` 用户。

创建用户时的密码只是初始密码，用它登入会被提示设置自己的密码：

![9b5c21ed9f777d3d5f9fe187baf2c358.png](.pics/9b5c21ed9f777d3d5f9fe187baf2c358.png)

可设置或跳过。

登入成功后就可以看到自己有权访问的企业空间了：

![ad7b85d4a9ddf02808490cc90a3dbd7c.png](.pics/ad7b85d4a9ddf02808490cc90a3dbd7c.png)

## 私有 Harbor 使用

ref: `https://kubesphere.io/zh/docs/project-user-guide/configuration/image-registry`   

在创建“部署”类型的工作负载的时候，对其管理的容器组添加容器，可以在这里（绿框）选择 Hub 。

![0ead1bbde672c60c57ef17217fa26f46.png](.pics/0ead1bbde672c60c57ef17217fa26f46.png)

但现在我们只有一个 Hub 。

如何增加 Hub ？

在“配置”、“保密字典”界面，点“创建”以增加。

在其中的“数据设置”步，类型选择“镜像仓库信息”：

![1bae05199d42922fd34821b57af5b331.png](.pics/1bae05199d42922fd34821b57af5b331.png)

然后根据自己仓库的情况，选择访问协议并填写必要内容：

![3e61771d7b38a1d7e6d77a9589763fdf.png](.pics/3e61771d7b38a1d7e6d77a9589763fdf.png)

验证通过后，创建即可。

之后就可以在创建“部署”类型的“工作负载”时使用这个镜像源了。

另外，在 Kubesphare 以外的界面（比如 Rancher ），你也可以使用在这个项目中创建的“保密字典”；只不过到时候有可能是另外的叫法（比如叫作“密文”等）。在使用时，本质上就是在资源对应的 `Pod.spec.imagePullSecrets` 字段中填充信息，具体可以检查你通过界面创建的“工作负载”的“ `YAML` ”来验证。

