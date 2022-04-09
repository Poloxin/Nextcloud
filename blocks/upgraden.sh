#!/bin/bash

# Upgrade Nextcloud
echo -e "\n-Upgrade-NC-"
sed -i  "$ i\"  \'memcache.local\' => \'\\\\\OC\\\\\Memcache\\\\\Redis\',\n  \'memcache.distributed\' => \'\\\\\OC\\\\\Memcache\\\\\Redis\',\n  \'memcache.locking\' => \'\\\\\OC\\\\\Memcache\\\\\Redis\',\n  \'redis\' => \n      array (\n          \'host\' => \'localhost\',          \'port\' => 6379,\n      )," /var/www/nextcloud/config/config.php
sed -i "$ i\  \'default_phone_region\' => \'RU\'," /var/www/nextcloud/config/config.php
sed -i "8 a\    \'192.168.1.107:8080\'," /var/www/nextcloud/config/config.php
echo -e "----Done----\n"
