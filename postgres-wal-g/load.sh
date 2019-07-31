#!/bin/sh
set -ex
BACKUP_POINT=${1:-LATEST}

# Fetch latest backup and change it for anything you like
wal-g backup-fetch $PGDATA $BACKUP_POINT ${@:2}
# Add recovery file
touch $PGDATA/recovery.conf
echo "standby_mode = 'on'" >> $PGDATA/recovery.conf
echo "restore_command = 'sh /usr/local/bin/restore.sh %f %p'" >> $PGDATA/recovery.conf
# Start DB and let it Go !
exec /docker-entrypoint.sh postgres
