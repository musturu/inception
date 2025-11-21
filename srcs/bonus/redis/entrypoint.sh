#!/bin/sh
set -e

# Ensure correct ownership at runtime (in case of mounted volume)
chown -R redis:redis /data || true

exec redis-server /etc/redis/redis.conf