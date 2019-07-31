FROM python:3.6-alpine
MAINTAINER apkawa <apkawa@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV DUMB_INIT_VERSION 1.0.1

ENV FLOWER_VERSION 0.9.2

RUN apk add --no-cache --update \
        openssl \
        curl \
    # Dumb Init
    && wget -O /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64 \
    && chmod +x /usr/bin/dumb-init \

    # Cleanup
    && rm -rf /tmp/*

RUN pip3  install --ignore-installed  --no-cache-dir flower==$FLOWER_VERSION \
  # Cleanup (Remove all tests folder and python compiled files)
  && find /usr/local \
    \( -type d -a -name test -o -name tests \) -exec echo rm -rf '{}' + \
    -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec echo rm -f '{}' + \
  && rm -rf /usr/src/python ~/.cache

ADD celeryconfig.py flowerconfig.py  /opt/celery-flower/
ADD bin/flower.sh /opt/celery-flower/bin/
RUN chmod +x /opt/celery-flower/bin/flower.sh

WORKDIR /opt/celery-flower

EXPOSE 5555

CMD ["/usr/bin/dumb-init", "/opt/celery-flower/bin/flower.sh"]
