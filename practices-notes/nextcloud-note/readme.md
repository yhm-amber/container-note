

[repo-server]: https://github.com/nextcloud/server.git
[repo-ui-vue]: https://github.com/nextcloud/nextcloud-vue.git

[repo-app-android]: https://github.com/nextcloud/android.git
[repo-app-ios]: https://github.com/nextcloud/ios.git
[repo-app-desktop]: https://github.com/nextcloud/desktop.git

[repo-talk]: https://github.com/nextcloud/spreed.git

[site]: https://nextcloud.com
[docs]: https://docs.nextcloud.com

[doc-docker]: https://docs.nextcloud.com/server/latest/admin_manual/office/example-docker.html

- repo: [`server`][repo-server] [`ui`][repo-ui-vue]
- ref: [Installation example with Docker — Nextcloud latest Administration Manual latest documentation][doc-docker]

pull:

~~~ sh
docker pull -- collabora/code
~~~

run:

~~~ sh
docker run -t -d \
    -p 127.0.0.1:9980:9980 \
    -e 'domain=cloud\\.example\\.com' \
    --restart always \
    --cap-add MKNOD \
    -- collabora/code
~~~

> Once you have done that the server will listen on “localhost:9980”. 
> Now we just need to configure the locally installed Apache reverse proxy. 


