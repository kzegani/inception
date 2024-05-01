FROM debian:bullseye

# Install dependencies
RUN apt update && apt-get install wget php php-mysql  -y

# Download Adminer
RUN wget "http://www.adminer.org/latest.php" -O /var/www/html/adminer.php 

RUN chown -R www-data:www-data /var/www/html/adminer.php && \
    chmod 755 /var/www/html/adminer.php

WORKDIR /var/www/html

RUN rm -rf index.html

CMD ["php", "-S", "0.0.0.0:80"]
