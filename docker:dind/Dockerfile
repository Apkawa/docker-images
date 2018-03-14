FROM docker:dind

RUN set -ex \
    && apk add --no-cache \
    python python-dev py-pip build-base bash openssh-client ansible \
    && pip install docker-compose
