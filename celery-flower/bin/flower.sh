#!/bin/sh -e

# Defaults
export LOG_LEVEL="${LOG_LEVEL:-info}"
export HOST_IP="${HOST_IP:-$(/sbin/ip route|awk '/default/ { print $3 }')}"
export AMQP_HOST="${AMQP_HOST:-$HOST_IP}"
export AMQP_ADMIN_HOST="${AMQP_ADMIN_HOST:-$HOST_IP}"


/usr/local/bin/celery --loglevel="$LOG_LEVEL" flower
