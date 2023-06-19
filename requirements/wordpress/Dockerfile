FROM debian:buster

RUN apt-get update && apt-get install -y wget

RUN apt-get install -y php-fpm php-mysql

RUN wget https://wordpress.org/wordpress-6.2.2.tar.gz && tar -xvzf wordpress-6.2.2.tar.gz

COPY ./s.sh .

RUN chmod +x ./s.sh

#CMD ["php-fpm", "--nodaemonize"]

CMD ["bash", "s.sh"]