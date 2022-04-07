#!/bin/bash

# Fix Locale
echo -e "--------------Fix locale settings!----------------"

export LC_ALL="en_US.UTF-8"
locale-gen "en_US.UTF-8"

echo -e "--------------All done!---------------"
