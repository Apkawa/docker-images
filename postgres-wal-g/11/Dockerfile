FROM postgres:11.4

ENV GO_VERSION=1.12.7
ENV WALG_VERSION=v0.2.10

ENV _build_deps="wget cmake git build-essential"

COPY dump.sh /usr/local/bin/dump.sh
COPY load.sh /usr/local/bin/load.sh
COPY --chown=postgres:postgres archive.sh /usr/local/bin/archive.sh
COPY --chown=postgres:postgres restore.sh /usr/local/bin/restore.sh

RUN set -ex  \
    && export GOROOT=/usr/local/go \
    && export GOPATH=/tmp/ \
    && export PATH=$GOPATH/bin:$GOROOT/bin:$PATH \

     && apt-get -qq update \
     && apt-get -qqy install  $_build_deps \
     # Install go
     && wget -qO - https://dl.google.com/go/go$GO_VERSION.linux-amd64.tar.gz | tar xz -f '-' \
     && mv go /usr/local \

     && cd /tmp  \
     &&  git clone https://github.com/wal-g/wal-g/  $GOPATH/src/wal-g \
     && cd $GOPATH/src/wal-g/ \
     && git checkout $WALG_VERSION \
     && GOBIN=/usr/local/bin make install \
     && make deps \
     && make pg_build \
     && install main/pg/wal-g /usr/local/bin \
     # Cleanup
     && cd / \
     && rm -rf /tmp/wal-g \
     && wal-g --help \
     && apt-get purge $_build_deps -qqy \
     && apt-get autoremove -qqy \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/* $GOPATH/src/ $GOROOT


RUN set -x \
    # make the sample config easier to munge (and "correct by default")
    && echo "wal_level=replica" >> /usr/share/postgresql/postgresql.conf.sample \
    && echo "archive_mode=on" >> /usr/share/postgresql/postgresql.conf.sample \
    && echo "archive_command='sh /usr/local/bin/archive.sh %p'" >> /usr/share/postgresql/postgresql.conf.sample \
    && echo "archive_timeout=60" >> /usr/share/postgresql/postgresql.conf.sample \
    && chmod 700 /usr/local/bin/dump.sh \
    && chmod 700 /usr/local/bin/load.sh






