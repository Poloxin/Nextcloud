#!/bin/bash

# Install programs
echo -e "\n--Install--"
apt install -y htop mariadb-server mariadb-client php php-gmp php-bcmath php-fpm php-common php-zip php-xml php-intl php-gd php-mysql php-mbstring php-curl php-imagick php-ldap php-json php-opcache php-apcu nginx unzip &> /dev/null
echo -e "----Done----\n"