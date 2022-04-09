#!/bin/bash

# Install Nextcloud
echo -e "\n _   _           _       _                 _
| \\ | |         | |     | |               | |
|  \\| | _____  _| |_ ___| | ___  _   _  __| |
| . \` |/ _ \\ \\/ / __/ __| |/ _ \\| | | |/ _\` |
| |\\  |  __/>  <| || (__| | (_) | |_| | (_| |
|_| \\_|\\___/_/\\_\\\\\__\\___|_|\\___/ \\__,_|\\__,_|\n"
cd /tmp
wget https://download.nextcloud.com/server/releases/nextcloud-23.0.3.zip
unzip nextcloud-*.zip &> /dev/null
mv nextcloud /var/www
rm -rf nextcloud-*.zip
chown -R www-data:www-data /var/www/nextcloud
echo -e "----Done----\n"
