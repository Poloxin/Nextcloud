#!/bin/bash

# Install OnlyOffice
echo -e "\n  ____        _        ____   __  __ _          
 / __ \\      | |      / __ \\ / _|/ _(_)         
| |  | |_ __ | |_   _| |  | | |_| |_ _  ___ ___ 
| |  | | '_ \\| | | | | |  | |  _|  _| |/ __/ _ \\
| |__| | | | | | |_| | |__| | | | | | | (_|  __/
 \\____/|_| |_|_|\\__, |\\____/|_| |_| |_|\\___\\___|
                 __/ |                          
                |___/\n"

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
echo "deb https://download.onlyoffice.com/repo/debian squeeze main" | sudo tee /etc/apt/sources.list.d/onlyoffice.list
apt update &> /dev/null
apt full-upgrade -y &> /dev/null

echo -e "\n\n\n=====================================Enter password=========================================\n\n\n"
apt install onlyoffice-documentserver -y &> /dev/null
echo -e "----Done----\n"
