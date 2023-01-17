
[core-repo]: https://github.com/bolcom/libunftp.git
[core-crates]: https://crates.io/crates/libunftp
[site]: https://unftp.rs
[repo]: https://github.com/bolcom/unFTP.git
[docker]: https://hub.docker.com/r/bolcom/unftp

- [unFTP][site]
- [bolcom/libunftp | GitHub][core-repo]
- [bolcom/unFTP | GitHub][repo]
- [bolcom/unftp | DockerHub][docker]

> **unFTP is an open-source FTP(S)** (not SFTP)
>  server aimed at the **Cloud** that allows bespoke
>  **extension** through its pluggable authenticator,
>  storage back-end and user detail store architectures.
>  It aims to bring features typically needed
>  in cloud environments like integration with proxy servers,
>  Prometheus monitoring and shipping of structured logs
>  while capitalizing on the memory safety
>  and speed provided by its implementation
>  language, Rust.
> 
> **unFTP 是一个开源 FTP(S)** (不是 SFTP ) 服务器、
> 针对**云**，它允许通过其可插入的身份验证器、
> 存储后端和用户详细信息存储体系结构进行定制**扩展**。
> 它旨在带来云环境中通常需要的功能，
> 例如与代理服务器的集成、 Prometheus 监控和结构化日志的传输，
> 同时利用其实现语言 Rust 提供的内存安全性和速度。
> 
> unFTP is first an **embeddable library** ([libunftp][core-crates])
>  and second an FTPS **server application** ([unFTP][repo]).
>  You can run it out of the box, embed it in your app,
>  craft your own server or build extensions for it.
> 
> unFTP 首先是一个**可嵌入库** ([libunftp][core-crates]) ，
> 其次是一个 FTPS **服务器应用程序** ([unFTP][repo]) 。
> 您可以开箱即用，将其嵌入到您的应用程序中，制作您自己的服务器或为其构建扩展。
> 
> **un**FTP tries to **un**tangle you from old-school environments so you can move all the things, even FTP, to the cloud while your users still get that familiar FTP feeling.
> 
> **un**FTP 试图将您从老式环境中**解救**出来，这样您就可以将所有东西 (甚至 FTP ) 移动到云中，而您的用户仍然可以获得熟悉的 FTP 感觉。
> 

[docs-docker]: https://unftp.rs/server/docker

[Docker | unftp.rs][docs-docker]

pulls: 

~~~ sh
docker pull -- bolcom/unftp:v0.14.0-alpine
docker pull -- bolcom/unftp:v0.14.0-alpine-istio
docker pull -- bolcom/unftp:v0.14.0-scratch
~~~

Example running unFTP in a Docker container: 

~~~ sh
docker run \
  -e ROOT_DIR=/ \
  -e UNFTP_LOG_LEVEL=info \
  -e UNFTP_FTPS_CERTS_FILE='/unftp.crt' \
  -e UNFTP_FTPS_KEY_FILE='/unftp.key' \
  -e UNFTP_PASSIVE_PORTS=50000-50005 \
  -e UNFTP_SBE_TYPE=gcs \
  -e UNFTP_SBE_GCS_BUCKET=the-bucket-name \
  -e UNFTP_SBE_GCS_KEY_FILE=/key.json \
  -p 2121:2121 \
  -p 50000:50000 \
  -p 50001:50001 \
  -p 50002:50002 \
  -p 50003:50003 \
  -p 50004:50004 \
  -p 50005:50005 \
  -p 8080:8080 \
  -v /Users/xxx/unftp/unftp.key:/unftp.key  \
  -v /Users/xxx/unftp/unftp.crt:/unftp.crt \
  -v /Users/xxx/unftp/the-key.json:/key.json \
  -t -i \
  -- bolcom/unftp:v0.14.0-alpine
~~~



more: 

[docs-lib]: https://unftp.rs/libunftp
[docs-server]: https://unftp.rs/server

- [The Library][docs-lib]
- [The Server][docs-server]



