
[site]: https://deno.land
[repo]: https://github.com/denoland/deno.git
[docs]: https://deno.land/manual
[docker]: https://hub.docker.com/r/denoland/deno
[repo-docker]: https://github.com/denoland/deno_docker.git

[pic-logo-repo]: https://deno.land/logo.svg
[pic-logo]: ./logo.svg

> Deno is a *simple*, *modern* and *secure*
>  runtime for **JavaScript** and **TypeScript**
>  that uses V8 and is built in Rust.
> 

![deno logo][pic-logo]

~~~ sh
: repl
docker run -it denoland/deno:1.29.2 repl

: sh
docker run -it denoland/deno:1.29.2 sh

: run script
docker run -i -t \
  -p 1993:1993 \
  -v "$PWD":/app \
  -- \
  denoland/deno:1.29.2 run \
    --allow-net \
    -- /app/main.ts
~~~

use from: 

~~~ dockerfile
FROM denoland/deno:1.29.2

# The port that your application listens to.
EXPOSE 1993

WORKDIR /app

# Prefer not to run as root.
USER deno

# Cache the dependencies as a layer (the following two steps are re-run only when deps.ts is modified).
# Ideally cache deps.ts will download and compile _all_ external files used in main.ts.
COPY deps.ts .
RUN deno cache deps.ts

# These steps will be re-run upon each file change in your working directory:
ADD . .
# Compile the main app so that it doesn't need to be compiled each startup/entry.
RUN deno cache main.ts

CMD ["run", "--allow-net", "main.ts"]
~~~

fake cli: 

~~~ sh
deno ()
{
    docker run \
      --interactive --tty --rm \
      --volume $PWD:/app \
      --volume $HOME/.deno:/deno-dir \
      --workdir /app \
      -- denoland/deno "$@" &&
    
    :;
} ;

deno --version
deno run ./main.ts
~~~



