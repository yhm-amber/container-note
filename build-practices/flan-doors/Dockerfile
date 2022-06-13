FROM bash

WORKDIR /flan-door
RUN ln -s /flan-doors/src.sh /etc/profile.d/flan-door.sh

COPY Dockerfile .
COPY {src.sh,readme} .

ENTRYPOINT ["bash", "/flan-door/src.sh"]

CMD ["cat","welcome"]
