FROM bash

WORKDIR /flan-doors
RUN ln -s /flan-doors/src.sh /etc/profile.d/flan-doors.sh

COPY Dockerfile .
COPY {src.sh,readme} .

ENTRYPOINT ["bash", "/flan-doors/src.sh"]

CMD ["cat","welcome"]
