FROM debian:buster

RUN apt-get update && apt install -y php 

RUN apt install -y wget   

RUN apt install -y php-mysql

RUN wget "https://www.adminer.org/latest.php" -O /var/www/html/adminer.php

CMD ["php", "-S", "0.0.0.0:8080", "/var/www/html/adminer.php"]
