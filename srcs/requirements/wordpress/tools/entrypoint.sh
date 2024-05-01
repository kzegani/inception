#!/bin/bash

while ! ping -c 1 mariadb; do sleep 1; done

service redis-server start

mkdir run/php

cd /var/www/html/wordpress

wp core download --allow-root

mv /wp-config.php /var/www/html/wordpress/

rm wp-config-sample.php

sed -i "s/database_name_here/${MYSQL_DATABASE}/g" wp-config.php
sed -i "s/username_here/${MYSQL_USER}/g" wp-config.php
sed -i "s/password_here/${MYSQL_PASSWORD}/g" wp-config.php
sed -i "s/localhost/${WORDPRESS_DB_HOST}/g" wp-config.php

sed -i "s/key1/${AUTH_KEY}/g" wp-config.php
sed -i "s/key2/${SECURE_AUTH_KEY}/g" wp-config.php
sed -i "s/key3/${LOGGED_IN_KEY}/g" wp-config.php
sed -i "s/key4/${NONCE_KEY}/g" wp-config.php
sed -i "s/key5/${AUTH_SALT}/g" wp-config.php
sed -i "s/key6/${SECURE_AUTH_SALT}/g" wp-config.php
sed -i "s/key7/${LOGGED_IN_SALT}/g" wp-config.php
sed -i "s/key8/${NONCE_SALT}/g" wp-config.php

sed -i "s/domain_name/${DOMAIN_NAME}/g" wp-config.php

sed -i 's/^post_max_size = .*/post_max_size = 64M/' /etc/php/7.4/fpm/php.ini
sed -i 's/^memory_limit = .*/memory_limit = 256M/' /etc/php/7.4/fpm/php.ini
sed -i 's/^max_execution_time = .*/max_execution_time = 300/' /etc/php/7.4/fpm/php.ini
sed -i 's/^upload_max_filesize = .*/upload_max_filesize = 32M/' /etc/php/7.4/fpm/php.ini

sed -i 's/^date.timezone = .*/date.timezone = "Africa\/Casablanca"/' /etc/php/7.4/fpm/php.ini

sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|g" /etc/php/7.4/fpm/pool.d/www.conf

wp core install --url=${DOMAIN_NAME} --title=inception --admin_user=${MYSQL_USER} --admin_password=${MYSQL_PASSWORD} --admin_email=${WP_EMAIL} --allow-root

wp user create ${WP_USER} ${WP_EMAIL} --role=author --user_pass=${WP_PASS} --allow-root

wp plugin install redis-cache --activate --allow-root --path=${WP_VOLUME}

wp redis enable --allow-root --path=${WP_VOLUME}

wp redis status --allow-root --path=${WP_VOLUME}

php-fpm7.4 -F
