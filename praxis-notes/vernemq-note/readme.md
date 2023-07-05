
[src/gh]: https://github.com/vernemq/vernemq.git "A distributed MQTT message broker based on Erlang/OTP. Built for high quality & Industrial use cases."
[container.src/gh]: https://github.com/vernemq/docker-vernemq.git "VerneMQ Docker image - Starts the VerneMQ MQTT broker and listens on 1883 and 8080 (for websockets)."
[operator.src/gh]: https://github.com/vernemq/vmq-operator.git "VerneMQ Operator creates/configures/manages VerneMQ clusters atop Kubernetes"

[site]: https://vernemq.com "Clustering MQTT for high availability and scalability."
[docs]: https://docs.vernemq.com

[dockerhub]: https://hub.docker.com/r/vernemq/vernemq

[pic::logo.jpg.ol]: https://i.imgur.com/bln3fK3.jpg
[pic::logo.jpg]: ./vernemq_bln3fK3.jpg

![logo][pic::logo.jpg]

----

[🧱 site][site] | [📜 src][src/gh] | [🧊 container src][container.src/gh] | [⚙ operator src][operator.src/gh] | [📔 docs][docs] | [🧫 dockerhub][dockerhub]

Install: 

~~~ sh
: install : debian
sudo dpkg -i vernemq-<VERSION>.bionic.x86_64.deb

: verify : debian
dpkg -s vernemq | grep Status

: If VerneMQ has been installed successfully
: `Status: install ok installed` will return


: install : centos
sudo yum install vernemq-<VERSION>.centos7.x86_64.rpm

: verify : centos
rpm -qa | grep vernemq


: ::: :

: svc start
service vernemq start
~~~

Containerized ref: 

- [Running VerneMQ using Docker | VerneMQ](https://docs.vernemq.com/installing-vernemq/docker)
- [VerneMQ on Kubernetes | VerneMQ](https://docs.vernemq.com/guides/vernemq-on-kubernetes)

~~~ sh
: normal
docker run --name vernemq1 -d -- vernemq/vernemq

: port
docker run -p 1883:1883 --name vernemq1 -d -- vernemq/vernemq

: this will listens on 1883 for MQTT connections and on 8080 for MQTT over websocket
: but the broker won't be able to authenticate the connecting clients
: you can allow anonymous clients

: allow anonymous clients
docker run -e "DOCKER_VERNEMQ_ALLOW_ANONYMOUS=on" --name vernemq1 -d -- vernemq/vernemq

: auto join cluster
docker run -e "DOCKER_VERNEMQ_DISCOVERY_NODE=<IP-OF-VERNEMQ1>" --name vernemq2 -d -- vernemq/vernemq

: you can find the IP of a docker container using
: docker inspect <CONTAINER_NAME> | grep \"IPAddress\"

: check
docker exec vernemq1 vmq-admin cluster show

: you can see nodes and statues
: in this cluster
~~~

~~~ sh
: helm instance
helm install vernemq/vernemq ## 这个我没测试，文档只说了这些，但按说不能用。

: operator
curl -L https://codeload.github.com/vernemq/vmq-operator/zip/master --output repo.zip &&
unzip -j repo.zip '*/examples/only_vernemq/*' -d only_vernemq &&
kubectl apply -f only_vernemq

: verify
: kubectl get pods -n messaging
: kubectl exec -n messaging -- vernemq-k8s-0 vmq-admin cluster show

: port
kubectl port-forward -n messaging -- svc/vernemq-k8s 1883:1883 &&
kubectl port-forward -n messaging -- svc/vernemq-k8s 8888:8888 && :
~~~

更多见 ref ... 看起来给的信息不太够。


