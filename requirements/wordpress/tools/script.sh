#!/bin/sh 

sleep 6

if ! wp core is-installed --path=/usr/share/nginx/html/wordpress/ --allow-root > /dev/null; then
mv  -f /usr/share/nginx/html/wordpress/wp-config-sample.php /usr/share/nginx/html/wordpress/wp-config.php
sed -i "s/database_name_here/$DB_DATABASE/g" /usr/share/nginx/html/wordpress/wp-config.php 
sed -i "s/username_here/$DB_USER/g" /usr/share/nginx/html/wordpress/wp-config.php 
sed -i "s/password_here/$DB_USER_PASSWORD/g" /usr/share/nginx/html/wordpress/wp-config.php 
sed -i "s/localhost/$DB_HOST/g" /usr/share/nginx/html/wordpress/wp-config.php
wp core install  --url=$url --title=$title --admin_name=$wordpress_admin --admin_password=$wordpress_password --admin_email=$admin_email --path=/usr/share/nginx/html/wordpress/ --allow-root > /dev/null
echo "define('WP_REDIS_HOST', 'co_redis');" >> /usr/share/nginx/html/wordpress/wp-config.php
echo "define('WP_CACHE', true);" >> /usr/share/nginx/html/wordpress/wp-config.php
echo "define('WP_REDIS_DATABASE', '0');" >> /usr/share/nginx/html/wordpress/wp-config.php

wp user create $WP_user $user_mail --role="author" --user_pass=$user_pass  --path=/usr/share/nginx/html/wordpress/ --allow-root 


wp plugin install redis-cache --activate  --path=/usr/share/nginx/html/wordpress/ --allow-root
wp redis enable --path=/usr/share/nginx/html/wordpress/ --allow-root

fi

php-fpm7.3 -F
