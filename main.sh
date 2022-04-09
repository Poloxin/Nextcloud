#!/bin/bash

# Start
./blocks/start.sh
./blocks/update.sh
./blocks/installn.sh
./blocks/php.sh
./blocks/mariadb.sh
./blocks/nginx.sh
./blocks/nextcloud.sh
./blocks/postgresql.sh
./blocks/onlyoffice.sh
./blocks/nginxof.sh
echo "----Set-UP-Nextcloud!!!----"
sleep 600
./blocks/upgraden.sh
# End
