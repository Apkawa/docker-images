FROM postgres:11.4-alpine
MAINTAINER apkawa <apkawa@gmail.com>

COPY --from=apkawa/wal-g:alpine /wal-g /usr/local/bin/wal-g

COPY dump.sh /usr/local/bin/dump.sh
COPY load.sh /usr/local/bin/load.sh
COPY --chown=postgres:postgres archive.sh /usr/local/bin/archive.sh
COPY --chown=postgres:postgres restore.sh /usr/local/bin/restore.sh


RUN set -x \
    # make the sample config easier to munge (and "correct by default")
    && export CONF_SAMPLE=/usr/local/share/postgresql/postgresql.conf.sample \
    && echo "wal_level=replica" >> $CONF_SAMPLE \
    && echo "archive_mode=on" >> $CONF_SAMPLE \
    && echo "archive_command='sh /usr/local/bin/archive.sh %p'" >>  $CONF_SAMPLE \
    && echo "archive_timeout=60" >> $CONF_SAMPLE \
    && chmod 700 /usr/local/bin/dump.sh \
    && chmod 700 /usr/local/bin/load.sh \
    && wal-g --help






