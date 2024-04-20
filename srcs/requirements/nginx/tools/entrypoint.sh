
mkdir /etc/nginx/ssl

openssl req -x509 -nodes -out $CERTS_ -keyout /etc/nginx/ssl/inception.key -subj "/C=MA/ST=KH/L=KH/O=42/OU=42/CN=kzegani.42.fr/UID=kzegani"

echo "events {
    worker_connections 768;
}

http {
    include    /etc/nginx/mime.types;

    server {
        listen 443 ssl;
        server_name $DOMAIN_NAME;

        default_type application/octet-stream;
        keepalive_timeout 65;
        gzip on;
        gzip_types text/css text/x-component application/x-javascript application/javascript text/javascript text/x-js text/richtext image/svg+xml text/plain text/xsd text/xsl text/xml image/x-icon;

        ssl_certificate $CERTS_;
        ssl_certificate_key /etc/nginx/ssl/inception.key;
        ssl_protocols TLSv1.3;

        access_log /var/log/nginx/wordpress_access.log;
        error_log /var/log/nginx/wordpress_error.log;

        root /var/www/html/wordpress;
        index index.php;

        location ~ \.php$ {
            fastcgi_pass wordpress:9000;
            include snippets/fastcgi-php.conf;
            include fastcgi_params;
            include /etc/nginx/fastcgi_params;
            fastcgi_read_timeout 3600s;
            fastcgi_buffer_size 128k;
            fastcgi_buffers 4 128k;
        }
    }
}" > /etc/nginx/nginx.conf

nginx -g "daemon off;"
