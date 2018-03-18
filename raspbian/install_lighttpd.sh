#!/bin/bash
# Installs lighttpd webserver
sudo apt-get install lighttpd
#sudo useradd -M www-data
sudo chown www-data:www-data /var/www
sudo chmod 775 /var/www
sudo usermod -a -G www-data `whoami`
