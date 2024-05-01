#!/bin/bash

sed -i "s/127.0.0.1/0.0.0.0/g"	/etc/mysql/mariadb.conf.d/50-server.cnf

sleep 1

service mariadb start

sleep 1

mariadb -u username -p -h hostname -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"

shred -u -n 3 db_root.sql

mariadb -h localhost -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%'; FLUSH PRIVILEGES;"

shred -u -n 3 db.sql

mariadb-admin -p$MYSQL_ROOT_PASSWORD shutdown

sleep 1

mariadbd