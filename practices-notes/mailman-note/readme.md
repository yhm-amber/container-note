[web]: https://list.org

[repo.gl]: https://gitlab.com/mailman
[wiki]: http://wiki.list.org

[docs.container]: https://docs.list.org/en/latest/install/docker.html
[docker.repo.gh]: https://github.com/maxking/docker-mailman.git "maxking/docker-mailman | GitHub"
[docker.docs]: https://asynchronous.in/docker-mailman


~~~ sh
: mailman core
pull -- ghcr.io/maxking/mailman-core
pull -- docker.io/maxking/mailman-core

: mailman web
pull -- ghcr.io/maxking/mailman-web
pull -- docker.io/maxking/mailman-web

: postorius
pull -- ghcr.io/maxking/postorius
pull -- docker.io/maxking/postorius

: ::: :

: rolling
pull -- ghcr.io/maxking/mailman-core:rolling
pull -- ghcr.io/maxking/mailman-web:rolling
: one commit one up also every night.
~~~

