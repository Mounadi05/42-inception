#!/bin/sh 

sleep 6

if [ ! -f /usr/share/nginx/html/wordpress/wp-config.php ]; then
mv  -f /usr/share/nginx/html/wordpress/wp-config-sample.php /usr/share/nginx/html/wordpress/wp-config.php
sed -i "s/database_name_here/$DB_DATABASE/g" /usr/share/nginx/html/wordpress/wp-config.php 
sed -i "s/username_here/$DB_USER/g" /usr/share/nginx/html/wordpress/wp-config.php 
sed -i "s/password_here/$DB_USER_PASSWORD/g" /usr/share/nginx/html/wordpress/wp-config.php 
sed -i "s/localhost/$DB_HOST/g" /usr/share/nginx/html/wordpress/wp-config.php
wp core install  --url=$url --title=$title --admin_name=$wordpress_admin --admin_password=$wordpress_password --admin_email=$admin_email --path=/usr/share/nginx/html/wordpress/ --allow-root 


wp user create $WP_user $user_mail --role="author" --user_pass=$user_pass  --path=/usr/share/nginx/html/wordpress/ --allow-root 

chown www-data:www-data /usr/share/nginx/html/wordpress -R 

wp plugin install redis-cache --activate  --path=/usr/share/nginx/html/wordpress/ --allow-root

wp config set WP_REDIS_HOST co_redis --path=/usr/share/nginx/html/wordpress/ --allow-root
wp config set WP_CACHE true --path=/usr/share/nginx/html/wordpress/ --allow-root
wp config set WP_REDIS_DATABASE 0 --path=/usr/share/nginx/html/wordpress/ --allow-root
wp config set WP_REDIS_PORT 6379 --path=/usr/share/nginx/html/wordpress/ --allow-root
wp config set FTP_HOST $FTP_HOST --path=/usr/share/nginx/html/wordpress/ --allow-root
wp config set FTP_USER $FTP_USER --path=/usr/share/nginx/html/wordpress/ --allow-root
wp config set FTP_PASS $FTP_PASS --path=/usr/share/nginx/html/wordpress/ --allow-root
wp config set FS_METHOD "direct" --path=/usr/share/nginx/html/wordpress/ --allow-root
wp redis enable --path=/usr/share/nginx/html/wordpress/ --allow-root

fi

php-fpm7.3 -F
