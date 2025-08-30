<?php
/* Database configuration */
define( 'DB_NAME', '${WORDPRESS_DB_NAME}' );
define( 'DB_USER', '${WORDPRESS_DB_USER}' );
define( 'DB_PASSWORD', '${DB_PASS}' );
define( 'DB_HOST', '${WORDPRESS_DB_HOST}' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

/* WordPress database table prefix */
$table_prefix = 'wp_';

/* Debug settings */
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );

/* Redis Object Cache configuration */
define('WP_REDIS_DISABLED', false);
define('WP_REDIS_HOST', 'redis');
define('WP_REDIS_PORT', 6379);
