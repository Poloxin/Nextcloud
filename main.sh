#!/bin/bash

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
echo "deb https://download.onlyoffice.com/repo/debian squeeze main" | sudo tee /etc/apt/sources.list.d/onlyoffice.list 
apt update
apt full-upgrade -y 
apt install -y htop mariadb-server php php-fpm php-common php-zip php-xml php-intl php-gd php-mysql php-mbstring php-curl php-imagick php-ldap nginx unzip php-gmp php-bcmath redis-server php-redis memcached php-memcached postgresql rabbitmq-server nginx-extras gnupg gnupg1 gnupg2 mariadb-client 

cd /tmp
wget https://download.nextcloud.com/server/releases/nextcloud-23.0.3.zip
