FROM debian:buster

RUN apt-get update && apt-get install -y wget

RUN apt-get install -y php php-fpm php-mysql

RUN mkdir -p /usr/share/nginx/html/

RUN mkdir -p /var/run/php/

RUN wget https://wordpress.org/wordpress-6.2.2.tar.gz 

RUN tar -xvzf wordpress-6.2.2.tar.gz -C /usr/share/nginx/html/

RUN mv /usr/share/nginx/html/wordpress/wp-config-sample.php /usr/share/nginx/html/wordpress/wp-config.php

COPY ./tools/www.conf /etc/php/7.3/fpm/pool.d/

COPY ./tools/script.sh /home/

RUN chmod +x /home/script.sh

#RUN /home/script.sh

CMD ["/home/script.sh"]
#CMD ["php-fpm7.3", "-F"]