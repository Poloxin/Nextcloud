# Myself list

## PHP

```
sudo vi /etc/php/7.4/fpm/php.ini
```

```
memory_limit=512M
```

```
sudo systemctl restart php7.4-fpm
```

## Memcache

```
sudo vim /var/www/nextcloud/config/config.php
```

```
 'memcache.local' => '\OC\Memcache\APCu',
 'memcache.distributed' => '\OC\Memcache\Redis',
   'redis' =>
   array (
        'host' => '127.0.0.1',
        'port' => 6379,
   ),
   'memcache.locking' => '\OC\Memcache\Redis',
```

```
sudo -u www-data php /var/www/nextcloud/occ files:scan --all
```

```
sudo -u www-data php /var/www/nextcloud/occ db:convert-filecache-bigint
```

## Location

```
sudo vi /var/www/nextcloud/config/config.php
```

```
'default_phone_region' => 'RU',
```

## Trusted Domain
