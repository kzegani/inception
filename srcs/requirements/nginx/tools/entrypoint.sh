
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
    ssl_certificate $CERTS_;
    ssl_certificate_key /etc/nginx/ssl/inception.key;
    ssl_protocols TLSv1.3;
    root /var/www/html/wordpress;
    index index.php;
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass wordpress:9000;
    }
}
}" > /etc/nginx/nginx.conf

nginx -g "daemon off;"
