FROM busybox as dumb-init
# Download dumb init
# TODO verify sum
ENV DUMB_INIT_VERSION=1.2.2

RUN wget https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64 \
    -O /dumb-init \
     && chmod +x /dumb-init


FROM alpine:3.10 AS builder


ENV _build_deps="wget cmake git build-base bash fuse fuse-dev"

WORKDIR src/
RUN set -ex  \
     && apk add --no-cache $_build_deps \
     && git clone https://github.com/gburca/rofs-filtered  rofs-filtered \
     && cd rofs-filtered \
     && mkdir build && cd build \
     && cmake .. \
     && make \
     && install rofs-filtered / \
     && /rofs-filtered --version



FROM alpine:3.10

MAINTAINER apkawa <apkawa@gmail.com>

COPY --from=dumb-init /dumb-init /usr/local/bin/
COPY --from=builder /rofs-filtered /usr/local/bin/
RUN set -ex && apk add --no-cache fuse

CMD ["--help"]
ENTRYPOINT ["dumb-init", "rofs-filtered"]





