
[hub]: https://hub.getdbt.com
[site]: https://getdbt.com

[utils-repo]: https://github.com/dbt-labs/dbt-utils.git
[repo]: https://github.com/dbt-labs/dbt-core.git

[ghcr]: https://github.com/dbt-labs/dbt-core/pkgs/container/dbt-core

> dbt enables data analysts and
>  engineers to transform their
>  data using the same practices
>  that software engineers use to
>  build applications.
> 
> dbt 使数据分析师和工程师
> 能够使用软件工程师用于
> 构建应用程序的
> 相同实践来转换他们的数据。
> 

links: 

- [Package hub | hub][hub]
- [dbt - Transform data in your warehouse][site]
- [dbt-labs/dbt-utils | GitHub][utils-repo]
- [dbt-labs/dbt-core | GitHub][repo]
- [dbt-labs/dbt-core | ghcr.io][ghcr]

[Install with Docker | dbt Developer Hub][docs-i-docker]

> Note that running dbt in this manner
>  can be significantly slower if your
>  operating system differs from
>  the system that built the Docker image.
>  If you're a frequent local developer,
>  we recommend that you install
>  dbt Core via [Homebrew][docs-i-hb] or [pip][docs-i-pip] instead.
> 
> 请注意，如果您的操作系统与构建 Docker 映像
> 的系统不同，以这种方式运行 dbt 可能会明显变慢。
> 如果您是本地开发人员，我们建议您
> 通过 [Homebrew][docs-i-hb] 或 [pip][docs-i-pip] 安装 dbt Core 。
> 

[docs-i-docker]: https://docs.getdbt.com/docs/get-started/docker-install
[docs-i-hb]: https://docs.getdbt.com/docs/get-started/homebrew-install
[docs-i-pip]: https://docs.getdbt.com/docs/get-started/pip-install


你可能要用到的：

- [所有的 `dbt-lab` 的镜像](https://github.com/orgs/dbt-labs/packages)

~~~ sh
docker run \
--network=host \
--mount type=bind,source=path/to/project,target=/usr/app \
--mount type=bind,source=path/to/profiles.yml,target=/root/.dbt/ \
<dbt_image_name> \
ls
~~~


