#!/bin/bash

# Config MariaDB
echo -e "\n--MariaDB--"
systemctl enable mariadb &> /dev/null
systemctl start mariadb &> /dev/null

mysql -e "CREATE DATABASE nextcloud"
mysql -e "CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY 'nextcloud'"
mysql -e "GRANT ALL ON nextcloud.* TO 'nextcloud'@'localhost' IDENTIFIED BY 'nextcloud' WITH GRANT OPTION"
mysql -e "FLUSH PRIVILEGES"
mysql -e "EXIT"
echo -e "----Done----\n"
