FROM debian:buster

RUN apt-get update && apt-get install -y mariadb-server

COPY script.sh /root/script.sh

RUN chmod +x /root/script.sh
 

CMD ["bash","/root/script.sh"]