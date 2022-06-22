FROM alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk --no-cache add -- bash tar zstd


WORKDIR /targeto
COPY Dockerfile src.sh ./

ENTRYPOINT ["bash","src.sh"]
CMD ["cat","welcome"]

COPY readme welcome ./
