
service mariadb start

mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '123';"

mariadb -h localhost -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS wpdb;"

mariadb -h localhost -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE USER 'abel-all'@'%' IDENTIFIED BY '123'; GRANT ALL PRIVILEGES ON wpdb.* TO 'abel-all'@'%'; FLUSH PRIVILEGES;"

mariadb-admin -p$MYSQL_ROOT_PASSWORD shutdown

mariadbd
