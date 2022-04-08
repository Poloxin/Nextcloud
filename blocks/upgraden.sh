#!/bin/bash

# Upgrade Nextcloud
sed -i "$s/i\ 'memcache.local' => '\OC\Memcache\APCu',
 'memcache.distributed' => '\OC\Memcache\Redis',
   'redis' =>
   array (
        'host' => '127.0.0.1',
        'port' => 6379,
   ),
   'memcache.locking' => '\OC\Memcache\Redis',/" /var/www/nextcloud/config/config.php
