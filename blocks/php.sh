#!/bin/bash

# Config PHP
echo -e "\n----PHP----"
sed 's/#env[HOSTNAME] = $HOSTNAME/env[HOSTNAME] = $HOSTNAME/w' /etc/php/7.4/fpm/pool.d/www.conf

systemctl enable php7.4-fpm &> /dev/null
systemctl restart php7.4-fpm &> /dev/null
echo -e "----Done----\n"
