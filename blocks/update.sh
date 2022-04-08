#!/bin/bash

# Update
echo -e "\n---Update---"
apt update &> /dev/null
apt full-upgrade -y &> /dev/null
echo -e "----Done----\n"
