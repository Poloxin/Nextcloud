#!/bin/bash


# Install Nextcloud

# Update packets
apt update
apt full-upgrade -y 

# Install programms for Nextcloud
apt install -y htop mariadb-server php php-fpm php-common php-zip php-xml php-intl php-gd php-mysql php-mbstring php-curl php-imagick php-ldap php-json php-opcache php-apcu nginx unzip smbclient

# Set php
echo -e "env[HOSTNAME] = $HOSTNAME\nenv[PATH] = /usr/local/bin:/usr/bin:/bin\nenv[TMP] = /tmp\nenv[TMPDIR] = /tmp\nenv[TEMP] = /tmp" >> /etc/php/7.4/fpm/pool.d/www.conf

echo -e "opcache.enable=1\nopcache.enable_cli=1\nopcache.interned_strings_buffer=8\nopcache.max_accelerated_files=10000\nopcache.memory_consumption=128\nopcache.save_comments=1\nopcache.revalidate_freq=1" >> /etc/php/7.4/fpm/php.ini

systemctl enable php7.4-fpm
systemctl restart php7.4-fpm

# Set MariaDB
systemctl enable mariadb
systemctl start mariadb

db_pass=nextcloudDBTPC

mysql -e "UPDATE mysql.user SET Password = PASSWORD('$db_pass') WHERE User = 'root'"
mysql -e "CREATE DATABASE nextcloud"
mysql -e "CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY 'nextcloud'"
mysql -e "GRANT ALL ON nextcloud.* TO 'nextcloud'@'localhost' IDENTIFIED BY 'nextcloud' WITH GRANT OPTION"
mysql -e "FLUSH PRIVILEGES"
mysql -e "EXIT"

# Set Nginx

echo "server {
        listen 80;
        server_name 192.168.1.107;

        root /var/www/nextcloud;

        add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
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

        location ~ ^/(data|config|\.ht|db_structure\.xml|README) {
                deny all;
        }

        location ^~ /.well-known {
                location = /.well-known/carddav { return 301 /remote.php/dav/; }
                location = /.well-known/caldav  { return 301 /remote.php/dav/; }
                location ^~ /.well-known{ return 301 /index.php/$uri; }
                try_files $uri $uri/ =404;
        }

        location / {
                rewrite ^/.well-known/host-meta /public.php?service=host-meta last;
                rewrite ^/.well-known/host-meta.json /public.php?service=host-meta-json last;
                rewrite ^(/core/doc/[^\/]+/)$ $1/index.html;
                try_files $uri $uri/ index.php;
        }

        location ~ ^(.+?\.php)(/.*)?$ {
                try_files $1 = 404;
                include fastcgi_params;
                fastcgi_param SCRIPT_FILENAME $document_root$1;
                fastcgi_param PATH_INFO $2;
		fastcgi_param HTTPS off;
                fastcgi_pass unix:/run/php/php7.4-fpm.sock;
        }

        location ~* ^.+\.(jpg|jpeg|gif|bmp|ico|png|css|js|swf)$ {
                expires modified +30d;
                access_log off;
        }
}" >> /etc/nginx/conf.d/nextcloud.conf

sudo systemctl enable nginx
sudo systemctl restart nginx


# Install Nextcloud

cd /tmp
wget https://download.nextcloud.com/server/releases/nextcloud-23.0.3.zip
unzip nextcloud-*.zip
mv nextcloud /var/www
chown -R www-data:www-data /var/www/nextcloud
