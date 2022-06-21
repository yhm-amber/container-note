FROM alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk --no-cache add -- bash tar zstd

# FROM bash

WORKDIR /flan-door
RUN ln -s /flan-door/src.sh /etc/profile.d/flan-door.sh

COPY welcome Dockerfile .
COPY src.sh readme .

ENTRYPOINT ["bash", "/flan-door/src.sh"]

CMD ["cat","welcome"]
