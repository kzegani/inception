#!/bin/bash

sed -i "s/127.0.0.1/0.0.0.0/g"	/etc/mysql/mariadb.conf.d/50-server.cnf

sleep 1

service mariadb start

sleep 1

mariadb < db_root.sql

shred -u -n 3 db_root.sql

mariadb -h localhost -u root -p$MYSQL_ROOT_PASSWORD < db.sql

shred -u -n 3 db.sql

mariadb-admin -p$MYSQL_ROOT_PASSWORD shutdown

sleep 1

mariadbd