

> [ejabberd][im] is an open-source,
robust, scalable and extensible realtime platform built using [Erlang/OTP][erlang],
that includes [XMPP][xmpp] Server, [MQTT][mqtt] Broker and [SIP][sip] Service.
> 
> Check the features in [ejabberd.im][im], [ejabberd Docs][features],
[ejabberd at ProcessOne][p1home], and the list of [supported protocols in ProcessOne][xeps]
and [XMPP.org][xmppej].
> 

ref: https://github.com/processone/ejabberd.git

[discussions]: https://github.com/processone/ejabberd/discussions
[docker-ecs-readme]: https://github.com/processone/docker-ejabberd/tree/master/ecs#readme
[docs-dev]: https://docs.ejabberd.im/developer/
[docs]: https://docs.ejabberd.im
[erlang]: https://www.erlang.org/
[features]: https://docs.ejabberd.im/admin/introduction/
[fluux]: https://fluux.io/
[github]: https://github.com/processone/ejabberd
[homebrew]: https://docs.ejabberd.im/admin/installation/#homebrew
[hubecs]: https://hub.docker.com/r/ejabberd/ecs/
[im]: https://ejabberd.im/
[issues]: https://github.com/processone/ejabberd/issues
[list]: https://lists.jabber.ru/mailman/listinfo/ejabberd
[localization]: https://docs.ejabberd.im/developer/extending-ejabberd/localization/
[mqtt]: https://mqtt.org/
[muc]: xmpp:ejabberd@conference.process-one.net
[osp]: https://docs.ejabberd.im/admin/installation/#operating-system-packages
[p1contact]: https://www.process-one.net/en/company/contact/
[p1download]: https://www.process-one.net/en/ejabberd/downloads/
[p1home]: https://www.process-one.net/en/ejabberd/
[packages]: https://github.com/processone/ejabberd/pkgs/container/ejabberd
[releases]: https://github.com/processone/ejabberd/releases
[sip]: https://en.wikipedia.org/wiki/Session_Initiation_Protocol
[stackoverflow]: https://stackoverflow.com/questions/tagged/ejabberd?sort=newest
[weblate]: https://hosted.weblate.org/projects/ejabberd/ejabberd-po/
[xeps]: https://www.process-one.net/en/ejabberd/protocols/
[xmpp]: https://xmpp.org/
[xmppej]: https://xmpp.org/software/servers/ejabberd/

## container

ref:

- https://docs.ejabberd.im/admin/installation/#docker-image
- https://github.com/processone/ejabberd/blob/master/CONTAINER.md

### pull

~~~ sh
docker pull ejabberd/ecs
docker pull ghcr.io/processone/ejabberd:latest
~~~

### run

That uses the default configuration file and XMPP domain "localhost" : 

~~~ sh
docker run --name ejabberd -d -p 5222:5222 ghcr.io/processone/ejabberd # daemon
docker run --name ejabberd -it -p 5222:5222 ghcr.io/processone/ejabberd live # living erlang console attached
~~~

Start with your configuration and database : 

~~~ sh
# in an empty fold

mkdir -- database
chown -- ejabberd database

cp -- ejabberd.yml.example ejabberd.yml

docker run --name ejabberd -i -t -p 5222:5222 \
  -v $(pwd)/ejabberd.yml:/opt/ejabberd/conf/ejabberd.yml \
  -v $(pwd)/database:/opt/ejabberd/database \
  -- ghcr.io/processone/ejabberd live
~~~

> **Note**
> 
> Notice that ejabberd runs in the container with an account named `ejabberd`, so the volumes you mount must grant proper rights to that account.
> 

### exec

ref: https://github.com/processone/ejabberd/blob/master/CONTAINER.md#next-steps

