FROM golang:alpine3.15 AS builder

ENV WALG_VERSION=v2.0.0

ENV _build_deps="wget cmake git build-base bash"

RUN set -ex  \
     && apk add --no-cache $_build_deps \
     && git clone https://github.com/wal-g/wal-g/  $GOPATH/src/wal-g \
     && cd $GOPATH/src/wal-g/ \
     && git checkout $WALG_VERSION \
     && make install \
     && make deps \
     && make pg_build \
     && install main/pg/wal-g / \
     && /wal-g --help

FROM alpine:3.15
COPY --from=builder /wal-g /
ENTRYPOINT ["/wal-g"]
