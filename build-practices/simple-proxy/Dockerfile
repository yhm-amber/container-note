FROM nginx:stable-alpine

COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir /etc/nginx/stream-conf.d

COPY get-stream-conf.sh /get-stream-conf.sh
COPY start.sh /start.sh
COPY readme /readme

COPY Dockerfile /Dockerfile
