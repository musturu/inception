#!/bin/bash
set -euo pipefail

# Read DB password from Docker secret if present
if [[ -f "/run/secrets/db_password" ]]; then
  chmod 644 /run/secrets/db_password || true
  export DATASOURCE_DB_PASSWORD="$(cat /run/secrets/db_password)"
fi

# Ensure permissions on writable dirs
chown -R grafana:grafana /var/lib/grafana || true

exec /usr/sbin/grafana-server --homepath=/usr/share/grafana --config=/etc/grafana/grafana.ini