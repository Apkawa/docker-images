FROM alpine:3.5

MAINTAINER apkawa <apkawa@gmail.com>

COPY ./pip-docker.sh /usr/local/bin/pip-docker

RUN apk add --no-cache \
    python \
    py-psycopg2 \
    py-virtualenv \
    py-crypto \
    py-lxml \
    py-pillow \
    py-pip \
    && apk add --no-cache \
    --virtual build-deps \
    gcc python-dev musl-dev linux-headers \
    && pip-docker ipython "setuptools>=28" \
    && apk del build-deps

CMD ["ipython"]

