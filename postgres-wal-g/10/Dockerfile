FROM postgres:10.9
MAINTAINER apkawa <apkawa@gmail.com>

COPY --from=apkawa/wal-g:latest /usr/local/bin/wal-g /usr/local/bin/wal-g

COPY dump.sh /usr/local/bin/dump.sh
COPY load.sh /usr/local/bin/load.sh
COPY --chown=postgres:postgres archive.sh /usr/local/bin/archive.sh
COPY --chown=postgres:postgres restore.sh /usr/local/bin/restore.sh


RUN set -x \
    # make the sample config easier to munge (and "correct by default")
    && echo "wal_level=replica" >> /usr/share/postgresql/postgresql.conf.sample \
    && echo "archive_mode=on" >> /usr/share/postgresql/postgresql.conf.sample \
    && echo "archive_command='sh /usr/local/bin/archive.sh %p'" >> /usr/share/postgresql/postgresql.conf.sample \
    && echo "archive_timeout=60" >> /usr/share/postgresql/postgresql.conf.sample \
    && chmod 700 /usr/local/bin/dump.sh \
    && chmod 700 /usr/local/bin/load.sh






