#!/bin/bash
set -e

WP_PATH=/var/www/html

if [ ! -f "/run/secrets/db_password" ]; then
	echo "[ERROR] Secret db_password not found"
	exit 1
fi

MYSQL_PASSWORD=$(cat /run/secrets/db_password)

until nc -z mariadb 3306; do
	sleep 1
done

mkdir -p /run/php
chown -R www-data:www-data /run/php

# install wordpress
if [ ! -f "$WP_PATH/index.php" ]; then
	echo "Installing wordpress..."

	cd "$WP_PATH"

	curl -O https://wordpress.org/latest.tar.gz
	tar -xzf latest.tar.gz
	rm latest.tar.gz
	mv wordpress/* .
	rmdir wordpress
fi

# config
if [ ! -f "$WP_PATH/wp-config.php" ]; then
	cp "$WP_PATH/wp-config-sample.php" "$WP_PATH/wp-config.php"

	sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/" "$WP_PATH/wp-config.php"
	sed -i "s/username_here/${WORDPRESS_DB_USER}/" "$WP_PATH/wp-config.php"
	sed -i "s/password_here/${MYSQL_PASSWORD}/" "$WP_PATH/wp-config.php"
	sed -i "s/localhost/${WORDPRESS_DB_HOST}/" "$WP_PATH/wp-config.php"
fi

# wp install
if ! wp core is-installed --path="$WP_PATH" --allow-root; then
	echo "Installing Wordpress via WP-CLI..."

	wp core install \
	--path="$WP_PATH" \
	--url="${DOMAIN_NAME}" \
	--title="Inception" \
	--admin_user="${WP_ADMIN_USER}" \
	--admin_password="${WP_ADMIN_PASS}" \
	--admin_email="${WP_ADMIN_EMAIL}" \
	--skip-email \
	--allow-root

	wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
	--path="$WP_PATH" \
	--role=author \
	--user_pass="${WP_USER_PASS}" \
	--allow-root
fi

# start as PID 1
exec php-fpm8.2 -F