FROM alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk --no-cache add -- bash tar zstd


WORKDIR /targeto
COPY Dockerfile src.sh LICENSE 'plan 🦪' ./

ENTRYPOINT ["bash","src.sh"]
CMD ["cat","welcome"]

COPY readme welcome ./


# ##################### #

# : simple pipeline demo 🩱
# 
# (
#     cd && cd container-note/build-practices/targeto &&
#     r=0 && while ! git pull ; do echo :::: $((++r)) ; done && unset -v -- r &&
#     docker build -t "$(basename $PWD)" -f Dockerfile -- . ) &&
# 
# eval "$(
#     
#     echo docker.io/amberyhm ghcr.io/yhm-amber | xargs -n1 |
#         xargs -i -- echo docker tag targeto {}/targeto '&&' repushed=0 '&&' while ! docker push {}/targeto ';' do echo :::: '$((++repushed))' for {} ; done )" &&
# 
# :;
# 
# docker image prune &&
# 
# :;


# ##################### #

# : simple test pipeline demo 🩰
# 
# while ! docker pull amberyhm/targeto:1 ;
# do echo ::: $((++x)) ; done &&
# 
# docker tag amberyhm/targeto:1 targeto &&
# 
# eval "$(docker run --rm -- targeto cat src.sh)" &&
# eval "$(docker run --rm -- targeto installer targeto zstd)" &&
# 
# :;
# 
# docker image prune &&
# 
# :;


 
