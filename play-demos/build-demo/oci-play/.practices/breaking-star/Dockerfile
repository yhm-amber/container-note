FROM bash

WORKDIR /Breaking-Star
RUN ln -s /Breaking-Star/src.sh /etc/profile.d/breaking-star.sh

COPY welcome Dockerfile .
COPY src.sh readme .

ENTRYPOINT ["bash", "/Breaking-Star/src.sh"]

CMD ["cat","welcome"]
