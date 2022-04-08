#!/bin/bash

# Upgrade Nextcloud
sed  "$s i  \'memcache.local\' => \'\OC\Memcache\APCu\',\n \'memcache.distributed\' => \'\OC\Memcache\Redis\',\n   \'redis\' =>\n   array (\n        \'host\' => '127.0.0.1',\n        \'port\' => 6379,\n   ),\n   \'memcache.locking\' => \'\OC\Memcache\Redis\',/" /var/www/nextcloud/config/config.php
