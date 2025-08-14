<?php
/* Database configuration */
define( 'DB_NAME', '${WORDPRESS_DB_NAME}' );
define( 'DB_USER', '${WORDPRESS_DB_USER}' );
define( 'DB_PASSWORD', '${DB_PASS}' );
define( 'DB_HOST', '${WORDPRESS_DB_HOST}' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

/* WordPress database table prefix */
\$table_prefix = 'wp_';

/* Debug settings */
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );

/* Absolute path to the WordPress directory */
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/* Sets up WordPress vars and included files */
require_once ABSPATH . 'wp-settings.php';