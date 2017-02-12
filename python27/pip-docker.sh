#!/usr/bin/env sh

pip install --no-cache-dir --upgrade --force-reinstall $* || return 1
rm -rf /usr/src/python ~/.cache || return 1