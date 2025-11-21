#!/bin/sh
set -e

# Render nginx.conf from template with ${NGINX_HOST}
envsubst '${NGINX_HOST}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Generate self-signed cert if missing
if [ ! -f /etc/nginx/ssl/nginx.crt ] || [ ! -f /etc/nginx/ssl/nginx.key ]; then
  openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/CN=${NGINX_HOST:-localhost}"
fi

exec nginx -g "daemon off;"