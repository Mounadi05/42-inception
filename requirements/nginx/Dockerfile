FROM debian:buster

RUN apt-get update && apt-get install -y nginx

RUN apt-get install -y openssl 

COPY ./conf /etc/nginx/sites-enabled

RUN mv /etc/nginx/sites-enabled/conf /etc/nginx/sites-enabled/default

RUN mkdir /etc/nginx/ssl/

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/ssl.key -out /etc/nginx/ssl/ssl.crt -subj "/C=US/ST=California/L=San Francisco/O=Example Company/OU=IT/CN=localhost/emailAddress=admin@example.com"

CMD ["nginx", "-g", "daemon off;"]