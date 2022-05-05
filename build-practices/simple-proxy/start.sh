#! /bin/sh

mkdir -p -- /etc/nginx/stream-conf.d ;

sh /get-stream-conf.sh "$@" | tee /etc/nginx/stream-conf.d/rancher.conf

exec /docker-entrypoint.sh 'nginx' '-g' 'daemon off;'

