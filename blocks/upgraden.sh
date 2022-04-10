#!/bin/bash

# Upgrade Nextcloud
echo -e "\n-Upgrade-NC-"
cd /var/www/nextcloud/
sudo -u www-data php /var/www/nextcloud/occ  maintenance:install --database "mysql" --database-name "nextcloud"  --database-user "nextcloud" --database-pass "nextcloud" --admin-user "admin" --admin-pass "macinsoft"
sleep 10
sed -i "7 a\    1 => \'192.168.1.107\'," /var/www/nextcloud/config/config.php
sed -i  "$ i\  \'memcache.local\' => \'\\\\\OC\\\\\Memcache\\\\\Redis\',\n  \'memcache.distributed\' => \'\\\\\OC\\\\\Memcache\\\\\Redis\',\n  \'memcache.locking\' => \'\\\\\OC\\\\\Memcache\\\\\Redis\',\n  \'redis\' => \n      array (\n          \'host\' => \'localhost\',\n          \'port\' => 6379,\n      )," /var/www/nextcloud/config/config.php
sed -i  "$ i\  \  \'memcache.local\' => \'\\\\\OC\\\\\Memcache\\\\\Memcached\',\n  \'memcache.distributed\' => \'\\\\\OC\\\\\Memcache\\\\\Memcached\',\n  \'memcached_servers\' =>\n  array (\n    0 =>\n    array (\n      0 => \'localhost\',\n      1 => 11211,\n    ),\n  )," /var/www/nextcloud/config/config.php

sed -i "$ i\  \'default_phone_region\' => \'RU\'," /var/www/nextcloud/config/config.php
sed -i "$ i\  \'allow_local_remote_servers\' => true," /var/www/nextcloud/config/config.php
sed -i "7 a\    2 => \'192.168.1.107:8080\'," /var/www/nextcloud/config/config.php

sudo -u www-data php /var/www/nextcloud/occ app:disable dashboard
sudo -u www-data php /var/www/nextcloud/occ app:install onlyoffice
sudo -u www-data php /var/www/nextcloud/occ --no-warnings config:system:set onlyoffice DocumentServerUrl --value="http://192.168.1.107:8080"
sudo -u www-data php /var/www/nextcloud/occ app:install external
sudo -u www-data php /var/www/nextcloud/occ app:enable files_external
sudo -u www-data php /var/www/nextcloud/occ app:install forms
sudo -u www-data php /var/www/nextcloud/occ app:install side_menu
sudo -u www-data php /var/www/nextcloud/occ app:disable weather_status
sudo -u www-data php /var/www/nextcloud/occ app:disable photos
sudo -u www-data php /var/www/nextcloud/occ app:enable user_ldap

webuser=www-data
sudo -u ${webuser} php /var/www/nextcloud/occ ldap:delete-config s01
sudo -u ${webuser} php /var/www/nextcloud/occ ldap:create-empty-config
sudo -u ${webuser} php /var/www/nextcloud/occ ldap:set-config s01 ldapHost "192.168.1.2"
sudo -u ${webuser} php /var/www/nextcloud/occ ldap:set-config s01 ldapPort "389"
sudo -u ${webuser} php /var/www/nextcloud/occ ldap:set-config s01 ldapAgentName "sup"
sudo -u ${webuser} php /var/www/nextcloud/occ ldap:set-config s01 ldapAgentPassword "AstraPass"; history -d $((HISTCMD-1))
sudo -u ${webuser} php /var/www/nextcloud/occ ldap:set-config s01 ldapBase "dc=tpc,dc=tpcol,dc=ru"

echo -e "----Done----\n"
