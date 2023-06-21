#!/bin/sh 

sed -i "s/database_name_here/$DB_DATABASE/g" /usr/share/nginx/html/wordpress/wp-config.php 
sed -i "s/username_here/$DB_USER/g" /usr/share/nginx/html/wordpress/wp-config.php 
sed -i "s/password_here/$DB_USER_PASSWORD/g" /usr/share/nginx/html/wordpress/wp-config.php 
sed -i "s/localhost/$DB_HOST/g" /usr/share/nginx/html/wordpress/wp-config.php

wp core install  --url=$url --title=$title --admin_name=$wordpress_admin --admin_password=$wordpress_password --admin_email=$admin_email --path=/usr/share/nginx/html/wordpress/ --allow-root 

php-fpm7.3 -F