#!/bin/bash

# Install programs
echo -e "\n--Install--"
apt install -y htop mariadb-server mariadb-client php php-gmp php-bcmath php-fpm php-common php-zip php-xml php-intl php-gd php-mysql php-mbstring php-curl php-imagick php-ldap php-json php-opcache php-apcu nginx unzip gnupg2 gnupg1 gnupg redis-server postgresql php-redis memcached php-memcached rabbitmq-server nginx-extras &> /dev/null

systemctl enable postgresql &> /dev/null
systemctl enable memcached &> /dev/null
echo -e "----Done----\n"
