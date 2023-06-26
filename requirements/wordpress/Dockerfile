FROM debian:buster

RUN apt-get update && apt-get install -y wget

RUN apt-get install -y php php-fpm php-mysql

RUN apt-get install -y mariadb-client

RUN mkdir -p /usr/share/nginx/html/

RUN mkdir -p /var/run/php/

RUN wget https://wordpress.org/wordpress-6.2.2.tar.gz 

RUN tar -xvzf wordpress-6.2.2.tar.gz -C /usr/share/nginx/html/

RUN  wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 

RUN chmod +x wp-cli.phar 

RUN  apt install sendmail -y

RUN mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/www.conf /etc/php/7.3/fpm/pool.d/

COPY ./tools/script.sh /home/

RUN chmod +x /home/script.sh

CMD ["/home/script.sh"]
