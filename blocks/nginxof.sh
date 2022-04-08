#!/bin/bash

# Config NGINX for OnlyOffice
echo -e "\nNGINX-OFFICE"
echo -e "include /etc/nginx/includes/http-common.conf;
server {
  listen 0.0.0.0:8080;
  listen [::]:8080 default_server;
  server_tokens off;

  include /etc/nginx/includes/ds-*.conf;
}" > /etc/onlyoffice/documentserver/nginx/ds.conf
echo -e "----Done----\n"
