FROM debian:buster

RUN apt-get update && apt-get install -y mariadb-server

RUN sed -i "s/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/script.sh /root/script.sh

RUN chmod +x /root/script.sh
 
CMD ["bash","/root/script.sh"]