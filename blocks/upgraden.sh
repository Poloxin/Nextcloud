#!/bin/bash

# Upgrade Nextcloud
echo -e "\n-Upgrade-NC-"
sed -i  "$ i\  \'memcache.local\' => \'\OC\Memcache\APCu\',\n \'memcache.distributed\' => \'\OC\Memcache\Redis\',\n   \'redis\' =>\n   array (\n        \'host\' => '127.0.0.1',\n        \'port\' => 6379,\n   ),\n   \'memcache.locking\' => \'\OC\Memcache\Redis\',/" /var/www/nextcloud/config/config.php
sed -i "$ i\  \'default_phone_region\' => \'RU\',/" /var/www/nextcloud/config/config.php
sed -ie "/^\    0 => \'192.168.1.107\'/a \    \'192.168.1.107:8080\',"

echo -e "sudo -u www-data php /var/www/nextcloud/occ files:scan --all"
echo -e "sudo -u www-data php /var/www/nextcloud/occ db:convert-filecache-bigint"
echo -e "----Done----\n"
