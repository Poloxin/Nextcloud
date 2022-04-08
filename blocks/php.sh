#!/bin/bash

# Config PHP
echo -e "\n----PHP----"
sed -i "/^\;env\[HOSTNAME\] = \$HOSTNAME/s/\;//" /etc/php/7.4/fpm/pool.d/www.conf 
sed -i "/^\;env\[PATH\] = \/usr\/local\/bin:\/usr\/bin:\/bin/s/\;//" /etc/php/7.4/fpm/pool.d/www.conf 
sed -i "/^\;env\[TMP\] = \/tmp/s/\;//" /etc/php/7.4/fpm/pool.d/www.conf 
sed -i "/^\;env\[TMPDIR\] = \/tmp/s/\;//" /etc/php/7.4/fpm/pool.d/www.conf 
sed -i "/^\;env\[TEMP\] = \/tmp/s/\;//" /etc/php/7.4/fpm/pool.d/www.conf 

sed -i "/^\;opcache.enable=/s/\;//" /etc/php/7.4/fpm/php.ini
sed -i "s/\;opcache.enable_cli=0/opcache.enable_cli=1/" /etc/php/7.4/fpm/php.ini
sed -i "/^\;opcache.interned_strings_buffer=8/s/\;//" /etc/php/7.4/fpm/php.ini
sed -i "/^\;opcache.max_accelerated_files=10000/s/\;//" /etc/php/7.4/fpm/php.ini
sed -i "/^\;opcache.memory_consumption=128/s/\;//" /etc/php/7.4/fpm/php.ini
sed -i "/^\;opcache.save_comments=1/s/\;//" /etc/php/7.4/fpm/php.ini
sed -i "s/\;opcache.revalidate_freq=2/opcache.revalidate_freq=1/" /etc/php/7.4/fpm/php.ini
sed -i "/^memory_limit = 128M/s/128M/512M/" /etc/php/7.4/fpm/php.ini


systemctl enable php7.4-fpm &> /dev/null
systemctl restart php7.4-fpm &> /dev/null
echo -e "----Done----\n"
