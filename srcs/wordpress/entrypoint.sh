#!/bin/sh
set -eu

# Get database password from the secrets file
DB_PASS=$(cat "${WORDPRESS_DB_PASSWORD_FILE:-/run/secrets/db_password}")

# Use envsubst to substitute environment variables in config_template.php to wp-config.php
if [ -f /opt/wp-config-template.php ]; then
    echo "Substituting environment variables using envsubst..."
    envsubst < /opt/wp-config-template.php > /var/www/html/wp-config.php
else
    echo "Error: /opt/wp-config-template.php not found!"
    exit 1
fi

# add Salts and Keys
if [ -f /var/www/html/wp-config.php ]; then
    echo "Adding authentication keys and salts..."
    curl -s https://api.wordpress.org/secret-key/1.1/salt/ >> /var/www/html/wp-config.php
else
    echo "Error: /var/www/html/wp-config.php not found!"
    exit 1
fi

# Start PHP-FPM
echo "Starting PHP-FPM..."
exec php-fpm81 --nodaemonize