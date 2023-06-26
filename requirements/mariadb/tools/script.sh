#!/bin/bash
service mysql start 

sleep 2

mysql -u root -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';"

mysql -u root  -e "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};"

mysql -u root -e "GRANT ALL PRIVILEGES ON ${DB_DATABASE}.* TO '${DB_USER}'@'%';"

mysql -u root  -e "FLUSH PRIVILEGES;" 

service mysql stop

mysqld 