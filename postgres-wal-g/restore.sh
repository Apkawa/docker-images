#!/bin/sh
set -ex
wal-g wal-fetch $1 $2
echo "Wal-Fetch OK $1 $2 $?"
