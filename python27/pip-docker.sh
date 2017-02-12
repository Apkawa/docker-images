#!/usr/bin/env sh

pip install --no-cache-dir $* || return 1
rm -rf /usr/src/python ~/.cache || return 1