#!/bin/sh
set -eu

# Get database password from file
DB_PASS=$(cat "${WORDPRESS_DB_PASSWORD_FILE:-/run/secrets/db_password}")

# Only download WordPress if not already present
if [ ! -f /var/www/html/wp-config-sample.php ]; then
  echo "WordPress core files not found. Installing..."
  curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz
  tar -xzf /tmp/wordpress.tar.gz -C /tmp
  cp -a /tmp/wordpress/. /var/www/html/
  rm -rf /tmp/wordpress /tmp/wordpress.tar.gz
fi

sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' /etc/php81/php-fpm.d/www.conf


# Configure WordPress if not already configured
if [ ! -f /var/www/html/wp-config.php ]; then
  echo "Configuring wp-config.php..."
  cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
  sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/" /var/www/html/wp-config.php
  sed -i "s/username_here/${WORDPRESS_DB_USER}/" /var/www/html/wp-config.php
  sed -i "s/password_here/${DB_PASS}/" /var/www/html/wp-config.php
  sed -i "s/localhost/${WORDPRESS_DB_HOST}/" /var/www/html/wp-config.php
  
  curl -s https://api.wordpress.org/secret-key/1.1/salt/ >> /var/www/html/wp-config.php
  
  # Set proper ownership on config
fi

chown www:www /var/www/html/wp-config.php
# Start PHP-FPM
exec php-fpm81 --nodaemonize