#!/bin/bash

echo "events {
    worker_connections 768;
}

http {
    include    /etc/nginx/mime.types;
    server {
        listen 8080;

        server_name ai.$DOMAIN_NAME;

        default_type application/octet-stream;
        keepalive_timeout 65;
        gzip on;
        gzip_types text/css text/x-component application/x-javascript application/javascript text/javascript text/x-js text/richtext image/svg+xml text/plain text/xsd text/xsl text/xml image/x-icon;

        access_log /var/log/nginx/wordpress_access.log;
        error_log /var/log/nginx/wordpress_error.log;

        location / {
            root /var/www/html/custom_site;
            index index.html;
        }
    }
}" > /etc/nginx/nginx.conf

nginx -g "daemon off;"