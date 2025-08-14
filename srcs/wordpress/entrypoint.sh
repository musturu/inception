#!/bin/sh
set -eu

# Function to log messages
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

export table_prefix='$table_prefix'
# Ensure necessary environment variables are set
: "${WORDPRESS_DB_PASSWORD_FILE:?Environment variable WORDPRESS_DB_PASSWORD_FILE is not set}"

# Fetch database password from the secrets file
export DB_PASS=$(cat "${WORDPRESS_DB_PASSWORD_FILE:-/run/secrets/db_password}" || { log "Error: Unable to read database password."; exit 1; })

# Download and extract WordPress
log "Downloading WordPress..."
curl -O https://wordpress.org/latest.tar.gz || { log "Error: Failed to download WordPress."; exit 1; }

log "Extracting WordPress..."
tar -xzf latest.tar.gz || { log "Error: Failed to extract WordPress."; exit 1; }

log "Copying WordPress files to /var/www/html/..."
cp -a wordpress/. /var/www/html/ || { log "Error: Failed to copy WordPress files."; exit 1; }

# Clean up temporary files
log "Cleaning up temporary WordPress files..."
rm -rf wordpress latest.tar.gz

# Substitute environment variables into wp-config.php
if [ -f /opt/wp-config-template.php ]; then
    log "Substituting environment variables using envsubst..."
    envsubst < /opt/wp-config-template.php > /var/www/html/wp-config.php || { log "Error: Failed to create wp-config.php."; exit 1; }
else
    log "Error: /opt/wp-config-template.php not found!"
    exit 1
fi

# Append authentication keys and salts to wp-config.php
if [ -f /var/www/html/wp-config.php ]; then
    log "Adding authentication keys and salts to wp-config.php..."
    curl -s https://api.wordpress.org/secret-key/1.1/salt/ >> /var/www/html/wp-config.php || { log "Error: Failed to fetch authentication keys and salts."; exit 1; }
else
    log "Error: /var/www/html/wp-config.php not found!"
    exit 1
fi

# Ensure proper ownership and permissions for WordPress files
log "Setting correct permissions for /var/www/html/..."
chown -R www-data:www-data /var/www/html || { log "Error: Failed to set ownership."; exit 1; }
chmod -R 755 /var/www/html || { log "Error: Failed to set permissions."; exit 1; }

# Start PHP-FPM
log "Starting PHP-FPM..."
exec php-fpm81 --nodaemonize