## ð¢ð¢ð¥ è­¦åï¼

å¨ä¸è¾¹åæ¬æä¸è¾¹å®è·µçè¿ç¨ä¸­ï¼æåç°ä¸äºå¾èç¼çç°è±¡ï¼ä»ä»¬çææ¡£åè½¯ä»¶è¡¨ç°ä¸ä¸è´ã

ç±äºæ¬æåºäºä»ä»¬ææ¡£æå¯¼åæï¼å æ­¤ä¹å·å¤ä¸å¯é æ§ã

å¥½äºï¼ä½ å·²ç»ç¥éäºãä¸é¢çåå®¹ä¸çä¹æ²¡å³ç³»äºï¼ç­å°ä¸ç¥éå¥æ¶åä¸åé½ðäºåè¯´å§ã


## å¼å§ä¹åéè¦æç¡®çæè¦

- [RKE2](https://docs.rke2.io/) æ¯ä¸ä¸ª Kubernetes åè¡çï¼ K3S æ¯åä¸ä¸ªï¼äºèæç±»ä¼¼çå°æ¹ã
- [Rancher](../rancher-note) æ¯ä¸ä¸ª Kubernetes ç®¡çç³»ç»ï¼éè¦ç¨ `helm` å®å¨ Kubernetes ä¸ï¼è¿è¿éè¦è¿ä¸ª Kubernetes å·²ç»åå¤å¥½è¶³å¤çä¸è¥¿ï¼æèéç¨ Docker çæ¹å¼ï¼ä½è¿å¶å®æ¯æå®¹å¨å½èç¹å¹¶å¨éé¢ååæ ·çäºæï¼ï¼å¯ä»¥ç®¡çåæ¬èªèº«è¢«é¨ç½²éç¾¤å¨åçå¤ä¸ª Kubernetes éç¾¤ã
- ä¸è¿°ç RKE2 ã K3S ã Rancher é½æ¯ç»ç» RancherLab çä½åï¼ä¸è¿°ç Kubernetes å¹¶ä¸æ¯å¼ä¸æ ·å·ä½çå®¹å¨ç¼æç³»ç»äº§åï¼èæ¯æä¸ç±»è¿æ ·çäº§åã

## å¿«éå¼å§

### 0. æ­¥éª¤ç®è¿°

å¤§ä½çå®è£è¿ç¨æ¯è¿æ ·çï¼

1. åå®æä¸ä¸ªåèç¹éç¾¤çå¯å¨
2. ç¶ååå å¥ `server` æ `agent` èç¹
3. è¦è®© `server` ä¿æå¥æ°

ä¸é¢ç±äºæãæ¼«é¿ç­å¾ãçæåµï¼æä»¥ä¸ºé²æ­¢ä¸­æ­ï¼ææ¯å¨ `screen` ä¸­åçè¿äºå·¥ä½ãè¿å¹¶ä¸æ¯å¿è¦çææ®µï¼ä½å»ºè®®ç¨ä¸ã

è¿æ¯æçç¬è®°ãæä¼å¯¹è½¯ä»¶çå®è£æ¹æ¡ææèªå·±ççæ³ï¼å¹¶å¨æè®¤ä¸ºå¿è¦çä½ç½®è®°ä¸æè®¤ä¸ºå¿è¦ççè®ºä¸å¯ç¨çæ¹è¿ææ®µã

### 1. åèç¹å¯å¨

ref: https://docs.rancher.cn/docs/rke2/install/quickstart/_index

ä»ä»¬ååè½¯ä»¶æ¯é èæ¬å®æçã

èæ¬åçäºæï¼[å¨è¿é](https://docs.rancher.cn/docs/rke2/install/methods/_index)æ¯è¿ä¹è¯´çï¼

> å½å®è£èæ¬è¢«æ§è¡æ¶ï¼å®ä¼å¤æ­å®æ¯ä»ä¹ç±»åçç³»ç»ãå¦æå®æ¯ä¸ä¸ªä½¿ç¨ RPM çæä½ç³»ç»ï¼æ¯å¦ CentOS æ RHELï¼ï¼å®å°æ§è¡åºäº RPM çå®è£ï¼å¦åèæ¬ä¼é»è®¤ä¸º tarballãåºäº RPM çå®è£å°å¨ä¸é¢ä»ç»ã
> 
> æ¥ä¸æ¥ï¼å®è£èæ¬ä¸è½½ tarballï¼éè¿æ¯è¾ SHA256 åå¸å¼è¿è¡éªè¯ï¼æåå°åå®¹æåå°/usr/localãå¦æéè¦ï¼æä½èå¯ä»¥å¨å®è£åèªç±ç§»å¨æä»¶ãè¿ä¸ªæä½åªæ¯æå tarballï¼å¹¶æ²¡æåå¶ä»ç³»ç»çä¿®æ¹ã
> 

é¤äºéæ©å®è£æ¹å¼åéªè¯å®è£åä»¥å¤ï¼å°±æ¯æ³¨åæå¡äºã

ä¸é¢åç¦»çº¿å®è£çæ¼ç¤ºãå¿è¦çç¦»çº¿æä»¶ `rke2-images.linux-amd64.tar.zst` æ¾å¨å½åç®å½ç `rke2-artifacts` ç®å½ä¸ã

*ï¼å¯¹äºæçå®è£éè¦ï¼ä»ä»¬[å®ç½](https://docs.rancher.cn/docs/rke2/install/airgap/_index)è¯´æ `rke2-images-cilium.linux-amd64.tar.zst` å `rke2-images-core.linux-amd64.tar.zst` å°±å¥½ãä¸è¿æç¨ä¸å°åªè½è¿åç½çæºå¨è¯äºï¼ä¼å¨å¯å¨æå¡çæ­¥éª¤æ¥éï¼å¿é¡»æ `rke2-images.linux-amd64.tar.zst` æè¡ï¼äºå®ä¸åªæå®å°±è¡ãä»ä»¬èªå·±æèæ¬é¨åçå½±åæ³¢åå°äºæå¡åå¯å¨æ­¥éª¤ï¼å¯åè½éªè¯ä¼°è®¡æ¯åçæ¥çï¼ç»æèªå·±é½æ²¡åç°æç§ä»ä»¬çç¦»çº¿æ¹æ¡æ¥ä¼èµ°ä¸éï¼ä»ä»¬ç°å¨çè¿ä¸ªå¸®å©åå·¥åä½çæ¨¡ååæ¹æ¡å¶å®å¹¶ä¸è½æååæ¥ä»»ä½ä½ç¨ãå¦æè¿é¨åé¨ç½²è½å¤å®¹å¨åï¼ç¦»çº¿ä¸ç¦»çº¿çå°±ä¹æ²¡è¿ä¹å¤å±äºå¿äºãï¼*

æçå½ä»¤ï¼

~~~ sh
: éè¿è½å¤è¿éå¤ç½çèç¹åå¾å®è£èæ¬
ssh 10.11.111.101 -- curl -sfL http://rancher-mirror.rancher.cn/rke2/install.sh | tee rke2-artifacts/install.sh
: ç¶åå¨ snapper çå¯¹å¿«ç§ççæ§ä¸ä½¿ç¨ cat rke2-artifacts/install.sh | RKE2_CNI=cilium INSTALL_RKE2_ARTIFACT_PATH=rke2-artifacts sh - è¿ä¸å®è£å½ä»¤
snapper create -d 'rke2 sh' --command 'cat rke2-artifacts/install.sh | RKE2_CNI=cilium INSTALL_RKE2_ARTIFACT_PATH=rke2-artifacts sh -'
~~~

å¨ç»è¿å¦ä¸çæ­¥éª¤å®éç¨å½ä»¤ `cat rke2-artifacts/install.sh | RKE2_CNI=cilium INSTALL_RKE2_ARTIFACT_PATH=rke2-artifacts sh -` å¼å§å¹¶å®æå®è£åï¼è¿æ¯æå¾å°çå±å¹è¾åºï¼

~~~ text
[WARN]  /usr/local is read-only or a mount point; installing to /opt/rke2
[INFO]  staging local checksums from rke2-artifacts/sha256sum-amd64.txt
[INFO]  staging zst airgap image tarball from rke2-artifacts/rke2-images.linux-amd64.tar.zst
[INFO]  staging tarball from rke2-artifacts/rke2.linux-amd64.tar.gz
[INFO]  verifying airgap tarball
grep: /tmp/rke2-install.sexyziki5m/rke2-images.checksums: No such file or directory
[INFO]  installing airgap tarball to /var/lib/rancher/rke2/agent/images
[INFO]  verifying tarball
[INFO]  unpacking tarball file to /opt/rke2
[INFO]  updating tarball contents to reflect install path
[INFO]  moving systemd units to /etc/systemd/system
[INFO]  install complete; you may want to run:  export PATH=$PATH:/opt/rke2/bin
~~~

å¯¹äºèæ¬ï¼è¿å ä¸ªéé¡¹ï¼åéï¼å¯è½å¯¹ä½ æ¯è¾éè¦ï¼

- éæ©å®è£æºï¼ `INSTALL_RKE2_MIRROR=cn` ï¼è¿ä¸ªæ¯ [`cn`](http://rancher-mirror.rancher.cn/rke2/install.sh) æ¥æºèæ¬ç¹æçåè½ï¼
- éæ©ç¦»çº¿åç®å½ï¼ `INSTALL_RKE2_ARTIFACT_PATH=/root/rke2-artifacts` ï¼ç¦»çº¿åä¸è½½[è§è¿é](https://github.com/rancher/rke2/releases)ï¼
- å³å®èç¹ç±»åï¼ `INSTALL_RKE2_TYPE=agent` ï¼è¿ä¸ªåéç©ºççè¯å¼å°±é»è®¤æ¯ `server` äºï¼
- éæ©ç½ç»æä»¶ï¼ `RKE2_CNI=cilium` ï¼å®ç­äºèæ¬ç `--cni` éé¡¹ï¼

åºäº `snapper` ççæ§ç»æï¼è¯¦ç»è§åæï¼æ¥çï¼æ°å¢çéç½®æ§æä»¶å°±æ¯å¨ `/etc/systemd/system` ç®å½ä¸ç `rke2-agent.service` å `rke2-server.service` ã

è¿ä¸ªå ref éæå°çèæ¬ä¼åçäºåºæ¬ç¸ç¬¦ãä¹å°±æ¯è¯´ï¼èæ¬çå·¥ä½æ¯å¯ä»¥ç¨å®¹å¨æ¹æ¡ä»£æ¿çã

ä»ä»¬å¯¹äºç¹å®ç³»ç»å½ç¶ä¹æä½¿ç¨åç®¡çå¨çæ¹æ¡ãä¸è¿ä¸è®ºåªç§ï¼å¶å®é½ä¸å¦ç´æ¥æåéååå»ºå®¹å¨æ¥å¾å¥½çã

*ââå¦æååé¨ç½²è½å®¹å¨åçè¯ï¼ä»ä¹æ³¨åæå¡ãé¨ç½²äºè¿å¶ï¼å°±åªæ¯éåæåèå·²äºãåæ¬¡æ§è¡å°±æ¯ `run --rm` ï¼å¸¸é©»å°±æ¯ `run -d` ï¼ä¸è½½å°±æ¯ `pull` ï¼æ³ç¦»çº¿å°± `save` ç¶å `load` ãéªè¯åç³»ç»å¼å®¹çæ¹é¢èªç¶é½æ¯æ éèèãå¯¹ç¨æ·æä¾çä¹åªéè¦æ¯å¦ä½ä½¿ç¨éåçå½ä»¤èå·²ï¼èä¸æ¯ä¸ä¸ªå¤æå°æ²¡è¾¹å¿çãèæ¬ããæ³è¦æ³¨åæå¯è¢« `systemctl` æ§å¶çæå¡ä¹ä¸æ¯ä¸å¯ä»¥ï¼çè³ `.service` æä»¶çåå®¹ä¹å¯ä»¥éè¿è¿è¡å®¹å¨éçæä¸ªäºè¿å¶ç»çæåºæ¥ï¼å¹¶ä¸æå¡åæ­¢å½ä»¤ä¹ä¸éè¦æ¯ç²æ´å°ææ­»ç¹å®åç§°çè¿ç¨äºï¼èåªè¦æé£å ä¸ªç¹å®åç§°çå¸¸é©»åå°å®¹å¨åæ­¢å°±å¥½ãèä¸æ´ä¸ªè¿ç¨ä¸­ä¹ä¸éè¦æ¹åå®¹å¨çæ°æ®ç®å½ä»¥å¤çç®å½ï¼ä¸ä¼å¯¹ç³»ç»äº§çé¾ä»¥è¿½è¸ªçå½±åãå¯è§ï¼**å¦ä½æ­£ç¡®åæ¾è½¯ä»¶**ï¼ Docker å¬å¸çäººä»¬ç»åºçæ¹æ¡æ¯ä¸ä¸çãä»ä»¬æ¯åå¾å¥½åã*

æ¥ä¸æ¥ï¼å¿è¦çç«¯å£å¼æ¾ï¼

~~~ sh
snapper create -d 'pub rke2 9345 6443' --command '
    firewall-cmd --zone=public --add-port=9345/tcp --add-port=9345/udp --add-port=6443/tcp --permanent '
: å·æ°éç½®
sudo systemctl reload firewalld
: æ£æ¥
sudo firewall-cmd --zone=public --list-ports --permanent
~~~

ç¶åå°±å¯ä»¥å¯å¨ `rke2-server.service` æå¡äºãå¯¹äºç®åç RKE2 ï¼é¦æ¬¡å¯å¨è¯¥æå¡å°±æ¯å¯¹éç¾¤çå®è£ï¼æä»¥è¿ä¸ªå¯å¨æä¹ä¼ç¨ `snapper` çå¯¹å¿«ç§çæ§èµ·æ¥ã

é¦æ¬¡å¯å¨ä¼å `/etc/rancher/rke2/config.yaml` å½±åãå¦æè¦å¢å æ°çèç¹å°±è¦æè¿ä¸ªæä»¶ï¼èä¸è¦ç¼è¾å¥½ï¼åå»ºéç¾¤çç¬¬ä¸ä¸ªèç¹åä¸éè¦æå®ã

~~~ sh
snapper create -d 'rke2 first server start' --command 'systemctl start rke2-server.service'
~~~

å¦æä¸æ¯ç¦»çº¿å®è£ï¼ç¦»çº¿å®è£å°±æ¯èµå¼äº `INSTALL_RKE2_ARTIFACT_PATH=rke2-artifacts` è¿ä¸ªéé¡¹ï¼ï¼ä½ ä¼ç­å¾ä¹ã

ç­å¾æ¶ï¼å¯ä»¥å¨åä¸ä¸ªèç¹çå¦ä¸ä¸ª SHell ä¸ç¨ `journalctl -u rke2-server -f` æ¥çæ¥å¿ã

åºäº `snapper` çæ§çç»æå¯ç¥ï¼å¯¹äºç³»ç»éç½®æ¹é¢ï¼è¿ä¸ªè¿ç¨ä¼æ°å¢ä»¥ä¸æä»¶åç®å½ï¼

~~~ text
+..... /etc/cni
+..... /etc/cni/net.d
+..... /etc/rancher
+..... /etc/rancher/node
+..... /etc/rancher/node/password
+..... /etc/rancher/rke2
+..... /etc/rancher/rke2/rke2.yaml
~~~

é¤æ­¤ä»¥å¤ï¼è¿ä¼å¢å ä¸äºäºè¿å¶ï¼å¨é»è®¤çç³»ç»å¿«ç§éç½®æ¹æ¡ä¸è¿äºä¸ä¼è¢«è¿½è¸ªå°ï¼ã

ç¶åä½ å°±å¯ä»¥åè¿æ ·éªè¯ï¼è¿ç¬¬ä¸ä¸ªèç¹ï¼æ¯å¦ `Ready` äºï¼

~~~ sh
/var/lib/rancher/rke2/bin/kubectl --kubeconfig /etc/rancher/rke2/rke2.yaml get no
~~~

æèï¼ä½¿ç¨å«çç­ä»·çæ¹å¼ï¼æ¯å¦åå¥½å¿è¦ç `PATH` åæ´æè½¯é¾æ¥å¢å ï¼å¹¶æ `/etc/rancher/rke2/rke2.yaml` è¿ä¸ª `kubeconfig` æä»¶åå¥å° `~/.kube/config` éï¼è®°å¾æå®çæéåæ `chmod 400` å¦ï¼ã

æ´å¤ä¿¡æ¯ï¼æ¥èª ref é¾æ¥ï¼ï¼

> è¿è¡æ­¤å®è£ç¨åºåï¼
> 
> - `rke2-server` æå¡å°è¢«å®è£ã `rke2-server` æå¡å°è¢«éç½®ä¸ºå¨èç¹éå¯åæè¿ç¨å´©æºæè¢«ææ¶èªå¨éå¯ã
> - å¶ä»çå®ç¨ç¨åºå°è¢«å®è£å¨ `/var/lib/rancher/rke2/bin/` ãå®ä»¬åæ¬ `kubectl` , `crictl` , å `ctr` ãæ³¨æï¼è¿äºä¸è¥¿é»è®¤ä¸å¨ä½ çè·¯å¾ä¸ã
> - è¿æä¸¤ä¸ªæ¸çèæ¬ä¼å®è£å° `/usr/local/bin/rke2` çè·¯å¾ä¸ãå®ä»¬æ¯ `rke2-killall.sh` å `rke2-uninstall.sh` ã
> - ä¸ä¸ª `kubeconfig` æä»¶å°è¢«åå¥ `/etc/rancher/rke2/rke2.yaml` ã
> - ä¸ä¸ªå¯ç¨äºæ³¨åå¶ä» `server` æ `agent` èç¹çä»¤çå°å¨ `/var/lib/rancher/rke2/server/node-token` æä»¶ä¸­åå»ºã
> 

å¨æè¿éï¼ä¸¤ä¸ªæ¸çèæ¬çæå¨è·¯å¾æ¯ `/opt/rke2/bin` ã

å¶ä¸­å¸è½½èæ¬ï¼éè¿ `snapper create -d 'rke2 un' --command /opt/rke2/bin/rke2-uninstall.sh` çæ§å®çæ§è¡ï¼ä½ ä¼ç¡®è®¤å°çå®å¸¦æ¥çååæ¯ï¼

- å®å é¤äº `/etc/cni` å `/etc/rancher` ä¸¤ä¸ªç®å½
- å®å¨ `/etc/systemd/system` ç®å½ä¸å é¤äº `rke2-agent.service` å `rke2-server.service` ä¸¤ä¸ªæä»¶

ä»¥åå¶å®ä¸äºä¸è¢« `snapper` é»è®¤çç³»ç»å¿«ç§éç½®æè¿½è¸ªçæä»¶ã

### 2. å¢å  `server` èç¹

å¶å®å°±æ¯é«å¯ç¨ã

æ³¨æè¦å¥æ°ã

ref: https://docs.rancher.cn/docs/rke2/install/ha/_index

ååä¸æ­¥åºå«æ¯ï¼å¨å¯å¨ `rke2-server.service` æå¡ä¹åï¼è¯·ååå»º `/etc/rancher/rke2/config.yaml` ï¼åå®çæå¨ç®å½ï¼ï¼å¹¶å¨å¶ä¸­å å¥ä»¥ä¸åå®¹ï¼

~~~ yaml
server: https://<server>:9345
token: <token from server node>
tls-san: [<ip>,<domain>,...]
~~~

å¶ä¸­ï¼

- å¨ `<server>` å¤è¦åè½å¤è®¿é®å°ç¬¬ä¸ä¸ª `server` ç IP æèååã
- å¨ `<token from server node>` å¤çåå®¹å°±æ¯å®è¦å å¥çèç¹ç `/var/lib/rancher/rke2/server/node-token` æä»¶çåå®¹ã
- è `<ip>` å `<domain>` å¤å°±åè½å¤è®¿é®å°è¢«å å¥éç¾¤ç `server` ç IP æèååï¼ä¸éè¦ç«¯å£å·ï¼ã

æå¥½ç»ç¬¬ä¸ä¸ª `server` ä¹åå»ºè¿æ ·ä¸ä¸ªéç½®ï¼å¹¶éå¯å®ã

### 3. å¢å  `agent` èç¹

è¿ä¸ªå¨[å¿«éå¼å§çä¸é¢é¨å](https://docs.rancher.cn/docs/rke2/install/quickstart/_index#linux-agent%EF%BC%88worker%EF%BC%89%E8%8A%82%E7%82%B9%E7%9A%84%E5%AE%89%E8%A3%85)ã

å `server` çä¸åå°±æ¯ï¼

- èæ¬çæ§è¡å¨ `sh` åé¢å¤å ä¸ä¸ª `INSTALL_RKE2_TYPE=agent` ï¼
- éè¦æä½çæå¡åè¿æ¬¡æ¯ `rke2-agent.service` ï¼
- å¨åæ¬¡å¯å¨è¿ä¸ªæå¡åå¡å¿è¦ååå»º `/etc/rancher/rke2/config.yaml` ï¼åæ¬å®çæå¨ç®å½ï¼ç¶åæ ¹æ®ä½ çæåµå¡«å¥ä»¥ä¸åå®¹ï¼
  
  ~~~ yaml
  server: https://<server>:9345
  token: <token from server node>
  ~~~
  
  å¶ä¸­ï¼
  
  - å¨ `<token from server node>` å¤çåå®¹å°±æ¯å®è¦å å¥çèç¹ç `/var/lib/rancher/rke2/server/node-token` æä»¶çåå®¹ã
  - å¨ `<server>` å¤è¦åè½å¤è®¿é®å°è¢«å å¥éç¾¤ç `server` ç IP æèååã
  
*è·å¢å  `server` æ¯ï¼é¤äºè¦ç¨å°çæå¡äºè¿å¶ï¼æå¯å¨æ¨¡å¼ï¼ä¸åå¤ä¹æ²¡æå«çä¸åãéè¦äºååå¤çéç½®æä»¶ä¹å ä¹ä¸æ ·ã*

Windows èç¹ä¸ç `agent` å®è£è§åæã

### æ¥èª `snapper` çè®°å½

è¿ä¸ª `snapper` æ¯ä¸ä¸ªæ¥èª SUSE ç»ç»çå·¥å·ï¼å®å¯ä»¥è®©ä½ å¾æ¹ä¾¿å°ä½¿ç¨æä»¶ç³»ç»çå¿«ç§åè½ã

å¨ `openSUSE Leap 15.2` åè¡çä¸­ï¼é»è®¤éç½®ï¼ `root` ï¼ä¸çç³»ç»å¿«ç§ï¼åªä¼å»çè§ææéç½®æ§çç®å½ï¼ä¸ä¼ç®¡äºè¿å¶çè³æ¯æ°æ®çç®å½ã

è¿éè¯¦ç»æè¿°ä¸ä¸ææ¯æä¹ç¨å®çã

ä¸æåºäºåé¢åå»ºç¬¬ä¸ä¸ªèç¹çæ­¥éª¤ãæ´ä¸ªè¿ç¨ä¸­ä½¿ç¨äºä¸æ¬¡å¯¹å¿«ç§çåå»ºï¼è¢«çæ§çå¨ä½åå«æ¯ï¼

- èæ¬æ§è¡ï¼ `cat rke2-artifacts/install.sh | RKE2_CNI=cilium INSTALL_RKE2_ARTIFACT_PATH=rke2-artifacts sh -`
- ç«¯å£å¼æ¾ï¼ `firewall-cmd --zone=public --add-port=9345/tcp --add-port=9345/udp --add-port=6443/tcp --permanent`
- æå¡é¦å¯ï¼ `systemctl start rke2-server.service`

è¿æ¯ä¸èå®æä»¥åï¼æç `snapper list` çè¾åºåå®¹ï¼

~~~ text
 # | Type   | Pre # | Date                            | User | Used Space | Cleanup | Description             | Userdata
---+--------+-------+---------------------------------+------+------------+---------+-------------------------+--------------
0  | single |       |                                 | root |            |         | current                 |
1* | single |       | Thu 07 Apr 2022 04:26:00 PM CST | root | 436.00 KiB |         | first root filesystem   |
2  | single |       | Thu 07 Apr 2022 04:39:31 PM CST | root |  28.27 MiB | number  | after installation      | important=yes
3  | pre    |       | Tue 03 May 2022 11:06:07 PM CST | root |   1.77 MiB |         | rke2 sh                 |
4  | post   |     3 | Tue 03 May 2022 11:06:18 PM CST | root |  16.00 KiB |         | rke2 sh                 |
5  | pre    |       | Tue 03 May 2022 11:14:25 PM CST | root |  16.00 KiB |         | pub rke2 9345 6443      |
6  | post   |     5 | Tue 03 May 2022 11:14:26 PM CST | root | 160.00 KiB |         | pub rke2 9345 6443      |
7  | pre    |       | Tue 03 May 2022 11:41:03 PM CST | root | 320.00 KiB |         | rke2 first server start |
8  | post   |     7 | Tue 03 May 2022 11:44:33 PM CST | root | 176.00 KiB |         | rke2 first server start |
~~~

ä¸æåºäºå®æ¥æ£æ¥åççååã

#### èæ¬æ§è¡

æ ¹æ®ä¹åç» `-d` çå¤æ³¨ä¿¡æ¯ `rke2 sh` å¯ä»¥çå°ï¼è¿ä¸ªé¶æ®µçå¯¹å¿«ç§çåºå·åå«æ¯ `3` å `4` ã

é£ä¹ç¨ `snapper status 3..4` å°±è½çå°è¿æé´çç³»ç»éç½®ååï¼

~~~ text
+..... /etc/systemd/system/rke2-agent.service
+..... /etc/systemd/system/rke2-server.service
~~~

å°±æ¯è¯´ï¼å¯¹äºç³»ç»éç½®èè¨ï¼åååªæè¿äºã

å¨è¿ä¸ªä½ç½®å¢å  `.service` æä»¶å°±æ¯æ³¨åæå¡ã

åå«ççå®ä»¬çåå®¹å§ï¼

##### `rke2-agent.service`

~~~ service
[Unit]
Description=Rancher Kubernetes Engine v2 (agent)
Documentation=https://github.com/rancher/rke2#readme
Wants=network-online.target
After=network-online.target
Conflicts=rke2-server.service

[Install]
WantedBy=multi-user.target

[Service]
Type=notify
EnvironmentFile=-/etc/default/%N
EnvironmentFile=-/etc/sysconfig/%N
EnvironmentFile=-/opt/rke2/lib/systemd/system/%N.env
KillMode=process
Delegate=yes
LimitNOFILE=1048576
LimitNPROC=infinity
LimitCORE=infinity
TasksMax=infinity
TimeoutStartSec=0
Restart=always
RestartSec=5s
ExecStartPre=/bin/sh -xc '! /usr/bin/systemctl is-enabled --quiet nm-cloud-setup.service'
ExecStartPre=-/sbin/modprobe br_netfilter
ExecStartPre=-/sbin/modprobe overlay
ExecStart=/opt/rke2/bin/rke2 agent
ExecStopPost=-/bin/sh -c "systemd-cgls /system.slice/%n | grep -Eo '[0-9]+ (containerd|kubelet)' | awk '{print $1}' | xargs -r kill"
~~~

##### `rke2-server.service`

~~~ service
[Unit]
Description=Rancher Kubernetes Engine v2 (server)
Documentation=https://github.com/rancher/rke2#readme
Wants=network-online.target
After=network-online.target
Conflicts=rke2-agent.service

[Install]
WantedBy=multi-user.target

[Service]
Type=notify
EnvironmentFile=-/etc/default/%N
EnvironmentFile=-/etc/sysconfig/%N
EnvironmentFile=-/opt/rke2/lib/systemd/system/%N.env
KillMode=process
Delegate=yes
LimitNOFILE=1048576
LimitNPROC=infinity
LimitCORE=infinity
TasksMax=infinity
TimeoutStartSec=0
Restart=always
RestartSec=5s
ExecStartPre=/bin/sh -xc '! /usr/bin/systemctl is-enabled --quiet nm-cloud-setup.service'
ExecStartPre=-/sbin/modprobe br_netfilter
ExecStartPre=-/sbin/modprobe overlay
ExecStart=/opt/rke2/bin/rke2 server
ExecStopPost=-/bin/sh -c "systemd-cgls /system.slice/%n | grep -Eo '[0-9]+ (containerd|kubelet)' | awk '{print $1}' | xargs -r kill"
~~~

#### å¼æ¾ç«¯å£

æ ¹æ®ä¹åç» `-d` çå¤æ³¨ä¿¡æ¯ `pub rke2 9345 6443` å¯ä»¥çå°ï¼è¿ä¸ªé¶æ®µçå¯¹å¿«ç§çåºå·åå«æ¯ `5` å `6` ã

é£ä¹ç¨ `snapper status 5..6` å°±è½çå°è¿æé´çç³»ç»éç½®ååï¼

~~~ text
c..... /etc/firewalld/zones/public.xml
c..... /etc/firewalld/zones/public.xml.old
~~~

å°±æ¯è¯´ï¼å¯¹äºç³»ç»éç½®èè¨ï¼åååªæè¿äºã

è¿å°±æ¯ `firewall-cmd` å½ä»¤çææã

åå®¹ï¼

##### `public.xml`

~~~ xml
<?xml version="1.0" encoding="utf-8"?>
<zone>
  <short>Public</short>
  <description>For use in public areas. You do not trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.</description>
  <service name="ssh"/>
  <service name="dhcpv6-client"/>
  <port port="9345" protocol="tcp"/>
  <port port="9345" protocol="udp"/>
  <port port="6443" protocol="tcp"/>
</zone>
~~~

è¿éé¢æä»¬å¯ä»¥çå°æä»¬å å¥çè§åã

æä»¬å¯ä»¥ç¨ `snapper diff 5..6 /etc/firewalld/zones/public.xml` çå°å·ä½çæ¹åï¼

~~~ text
--- /.snapshots/5/snapshot/etc/firewalld/zones/public.xml       2022-04-07 16:36:26.836000000 +0800
+++ /.snapshots/6/snapshot/etc/firewalld/zones/public.xml       2022-05-03 23:14:26.302837842 +0800
@@ -4,4 +4,7 @@
   <description>For use in public areas. You do not trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.</description>
   <service name="ssh"/>
   <service name="dhcpv6-client"/>
+  <port port="9345" protocol="tcp"/>
+  <port port="9345" protocol="udp"/>
+  <port port="6443" protocol="tcp"/>
 </zone>
~~~

##### `public.xml.old`

~~~ xml
<?xml version="1.0" encoding="utf-8"?>
<zone>
  <short>Public</short>
  <description>For use in public areas. You do not trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.</description>
  <service name="ssh"/>
  <service name="dhcpv6-client"/>
  <port port="9345" protocol="tcp"/>
  <port port="9345" protocol="udp"/>
</zone>
~~~

ä¼¼ä¹ï¼ä¸æ¬¡ `firewall-cmd` æå¤ä¸ª `--add-port` åºç°çè¯ï¼å°±ä¼è¢«ç»åæå¤æ¬¡ `firewall-cmd` å½ä»¤çç­æã

æä»¥æå¯¼è´ `.old` æä»¶åªä¼è®°å½ä¸ä¸æ¬¡çä¸ä¸ªå°çååã

å½ç¶è¿åªæ¯çæµã

æä»¬å¯ä»¥ç¨ `snapper diff 5..6 /etc/firewalld/zones/public.xml.old` çå°å·ä½çæ¹åï¼

~~~ text
--- /.snapshots/5/snapshot/etc/firewalld/zones/public.xml.old   2022-04-07 16:36:26.424000000 +0800
+++ /.snapshots/6/snapshot/etc/firewalld/zones/public.xml.old   2022-05-03 23:14:26.302837842 +0800
@@ -4,4 +4,6 @@
   <description>For use in public areas. You do not trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.</description>
   <service name="ssh"/>
   <service name="dhcpv6-client"/>
+  <port port="9345" protocol="tcp"/>
+  <port port="9345" protocol="udp"/>
 </zone>
~~~

å¯ä»¥ç¡®å®çæ¯ï¼ä¸ä¸ªæä»¨ `--add-port` ç `firewall-cmd` å½ä»¤ï¼ä¼è®©è¿ä¸ª `.old` æä»¶ä¹å¤åºä¸¤è¡æ¥ã

#### æå¡å¯å¨

æ ¹æ®ä¹åç» `-d` çå¤æ³¨ä¿¡æ¯ `rke2 first server start` å¯ä»¥çå°ï¼è¿ä¸ªé¶æ®µçå¯¹å¿«ç§çåºå·åå«æ¯ `7` å `8` ã

é£ä¹ç¨ `snapper status 7..8` å°±è½çå°è¿æé´çç³»ç»éç½®ååï¼

~~~ text
+..... /etc/cni
+..... /etc/cni/net.d
+..... /etc/rancher
+..... /etc/rancher/node
+..... /etc/rancher/node/password
+..... /etc/rancher/rke2
+..... /etc/rancher/rke2/rke2.yaml
~~~

å°±æ¯è¯´ï¼å¯¹äºç³»ç»éç½®èè¨ï¼åååªæè¿äºã

è¿å°±æ¯ `systemctl start rke2-server.service` å½ä»¤å¨é»å¡æé´æ°å¢çä¸è¥¿ã

å¶å®åªæä¸æ ·ï¼ `/etc/cni/net.d` `/etc/rancher/node/password` `/etc/rancher/rke2/rke2.yaml` ã

åä¸¤èï¼ä¸ä¸ªæ¯éææäºçå¯ç ï¼å¦ä¸ä¸ªå°±æ¯æ¬éç¾¤ç `kubeconfig` ã

å¶ä¸­ï¼å¨è¿ä¸ªå½ä»¤å®æåï¼å¨ `/etc/cni/net.d` åä¼åºç° `10-canal.conflist` å `calico-kubeconfig` ä¸¤ä¸ªæä»¶ã

äºå®ä¸ï¼æä¸ç¥éè¿æ¯ä¸ºä½ãæéæ©çç½ç»æä»¶æ¯ `cilium` ï¼ä½å®ä»¬åå®ä»¬çåå®¹ä¸æ­¤æ¯«ä¸ç¸å¹²ã

è¿æ¯å®ä»¬çåå®¹ï¼

##### `10-canal.conflist`

~~~ json
{
  "name": "k8s-pod-network",
  "cniVersion": "0.3.1",
  "plugins": [
    {
      "type": "calico",
      "log_level": "info",
      "datastore_type": "kubernetes",
      "nodename": "opensuse-1",
      "mtu": 1450,
      "ipam": {
          "type": "host-local",
          "ranges": [
              [
                  {
                      "subnet": "usePodCidr"
                  }
              ]
          ]
      },
      "policy": {
          "type": "k8s"
      },
      "kubernetes": {
          "kubeconfig": "/etc/cni/net.d/calico-kubeconfig"
      }
    },
    {
      "type": "portmap",
      "snat": true,
      "capabilities": {"portMappings": true}
    },
    {
      "type": "bandwidth",
      "capabilities": {"bandwidth": true}
    }
  ]
}
~~~

##### `calico-kubeconfig`

~~~ yaml
# Kubeconfig file for Calico CNI plugin.
apiVersion: v1
kind: Config
clusters:
- name: local
  cluster:
    server: https://[10.43.0.1]:443
    certificate-authority-data: <å¾é¿çç§å¯ð>
users:
- name: calico
  user:
    token: <å¾é¿å¾é¿çç§å¯ðð>
contexts:
- name: calico-context
  context:
    cluster: local
    user: calico
current-context: calico-context
~~~



