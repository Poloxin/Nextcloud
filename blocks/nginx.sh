#!/bin/bash

# Config NGINX
echo -e "\n---NGINX---"
echo "server {
        listen 80;
        server_name 192.168.1.107;

        root /var/www/nextcloud;

        add_header Strict-Transport-Security \"max-age=31536000; includeSubDomains\" always;
        client_max_body_size 20G;
        fastcgi_buffers 64 4K;

        rewrite ^/caldav(.*)$ /remote.php/caldav$1 redirect;
        rewrite ^/carddav(.*)$ /remote.php/carddav$1 redirect;
        rewrite ^/webdav(.*)$ /remote.php/webdav$1 redirect;

        index index.php;
        error_page 403 = /core/templates/403.php;
        error_page 404 = /core/templates/404.php;

        location = /robots.txt {
            allow all;
            log_not_found off;
            access_log off;
        }

        location ~ ^/(data|config|\\.ht|db_structure\\.xml|README) {
                deny all;
        }

        location ^~ /.well-known {
                location = /.well-known/carddav { return 301 /remote.php/dav/; }
                location = /.well-known/caldav  { return 301 /remote.php/dav/; }
                location ^~ /.well-known{ return 301 /index.php/\$uri; }
                try_files \$uri \$uri/ =404;
        }

        location / {
                rewrite ^/.well-known/host-meta /public.php?service=host-meta last;
                rewrite ^/.well-known/host-meta.json /public.php?service=host-meta-json last;
                rewrite ^(/core/doc/[^\\/]+/)$ \$1/index.html;
                try_files \$uri \$uri/ index.php;
        }

        location ~ ^(.+?\\.php)(/.*)?$ {
                try_files \$1 = 404;
                include fastcgi_params;
                fastcgi_param SCRIPT_FILENAME \$document_root\$1;
                fastcgi_param PATH_INFO \$2;
                fastcgi_param HTTPS off;
                fastcgi_pass unix:/run/php/php7.4-fpm.sock;
        }

        location ~* ^.+\\.(jpg|jpeg|gif|bmp|ico|png|css|js|swf)$ {
                expires modified +30d;
                access_log off;
        }
}" > /etc/nginx/conf.d/nextcloud.conf

systemctl enable nginx &> /dev/null
sudo systemctl restart nginx &> /dev/null
echo -e "----Done----\n"
