#!/bin/sh 
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&& chmod +x wp-cli.phar \
&& mv wp-cli.phar /usr/local/bin/wp

wp core install  --url=$url \
--title=${title} \
--admin_name=${wordpress_admin} \
--admin_password=${wordpress_password} \
--admin_email=${admin_email} --path=/usr/share/nginx/html/wordpress/ --allow-root

php-fpm7.3 -F