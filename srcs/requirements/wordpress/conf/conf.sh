#!/bin/bash

sleep 2;

if [ -f /var/www/wordpress/wp-config.php ]; then
    echo "wordpress already installed.";
fi

if [ ! -f /var/www/wordpress/wp-config.php ]; then

sleep 10;

cat << EOF > /var/www/wordpress/wp-config.php
<?php
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
define( 'WP_DEBUG_DISPLAY', true );
@ini_set( 'display_errors', 1 );

define( 'DB_NAME', '${MYSQL_DATABASE}' );
define( 'DB_USER', '${MYSQL_USER}' );
define( 'DB_PASSWORD', '${MYSQL_PASSWORD}' );
define( 'DB_HOST', 'mariadb' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
\$table_prefix = 'wp_';

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
EOF

sleep 2;

wp  core install --allow-root --url=$DOMAIN_NAME --title=$WP_TITLE \
    --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL --skip-email --path='/var/www/wordpress';
wp  user create --allow-root --role=author $WP_GUEST $WP_GUEST_EMAIL \
    --user_pass=$WP_GUEST_PASSWORD --path='/var/www/wordpress';

chmod -R 777 /var/www/wordpress/wp-content

fi

if [ ! -d /run/php ]; then
    mkdir /run/php
fi

exec $@