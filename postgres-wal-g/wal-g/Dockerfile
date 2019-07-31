FROM golang:1.12.7-buster AS builder
MAINTAINER apkawa <apkawa@gmail.com>

ENV WALG_VERSION=v0.2.10

ENV _build_deps="wget cmake git build-essential"

RUN set -ex  \
    && export GOPATH=/tmp/go/ \
    && export PATH=$GOPATH/bin:$GOROOT/bin:$PATH \
     && apt-get -qq update \
     && apt-get -qqy install  $_build_deps \
     && mkdir -p $GOPATH \
     &&  git clone https://github.com/wal-g/wal-g/  $GOPATH/src/wal-g \
     && cd $GOPATH/src/wal-g/ \
     && git checkout $WALG_VERSION \
     && GOBIN=/usr/local/bin make install \
     && make deps \
     && make pg_build \
     && install main/pg/wal-g / \
     && /wal-g --help

FROM debian:10-slim
COPY --from=builder /wal-g /
ENTRYPOINT ["/wal-g"]





