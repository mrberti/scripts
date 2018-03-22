#!/bin/bash
# Installs lighttpd webserver
sudo apt-get install lighttpd
#sudo useradd -M www-data
sudo chown www-data:www-data /var/www
sudo chmod 775 /var/www
sudo usermod -a -G www-data `whoami`

echo 'Now add accesslog.filename = "/var/log/lighttpd/access.log" to /etc/lighttpd/lighttpd.conf'
