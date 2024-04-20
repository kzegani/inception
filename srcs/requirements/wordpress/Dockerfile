FROM debian:bullseye

RUN apt update
RUN apt install -y iputils-ping php-fpm php7.4-mysql mariadb-client curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY tools/entrypoint.sh .

RUN chmod +x entrypoint.sh

CMD bash entrypoint.sh
