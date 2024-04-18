
while ! ping -c 1 mariadb; do sleep 1; done

mkdir run/php

cd /var/www/html/wordpress

wp core download --allow-root

mv wp-config-sample.php wp-config.php
sed -i "s/database_name_here/$MYSQL_DATABASE/g"	wp-config.php
sed -i "s/username_here/$MYSQL_USER/g"	wp-config.php
sed -i "s/password_here/$MYSQL_PASSWORD/g"	wp-config.php
sed -i "s/localhost/$WORDPRESS_DB_HOST/g"	wp-config.php

wp core install --url=$DOMAIN_NAME --title=inception --admin_user=$MYSQL_USER --admin_password=$MYSQL_PASSWORD --admin_email=$WP_EMAIL --allow-root

wp user create abel abel@gmail.com --role=author --user_pass=123 --allow-root

php-fpm7.4 -F
