#!/bin/sh
set -ex
wal-g backup-push $PGDATA $@
echo "Backup-Push OK $?"
