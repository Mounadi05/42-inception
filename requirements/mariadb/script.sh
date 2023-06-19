#!/bin/bash

service mysql start 

sleep 5

mysql -u root -p$DB_ROOT_PASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';" 

mysql -u root -p$DB_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';"

mysql -u root -p$DB_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};"

mysql -u root -p$DB_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON ${DB_DATABASE}.* TO '${DB_USER}'@'%';"

mysql -u root -p$DB_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"


mysqladmin -u root -p"${DB_ROOT_PASSWORD}" shutdown

mysqld 