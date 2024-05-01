FROM debian:bullseye

RUN apt update && apt install nginx -y

RUN mkdir -p /var/www/html/custom_site

COPY html/index.html /var/www/html/custom_site

COPY tools/entrypoint.sh .

CMD bash entrypoint.sh
