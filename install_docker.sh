#!/bin/bash
#https://docs.docker.com/install/linux/docker-ce/debian/

# Uninstall old versions
sudo apt-get remove docker docker-engine docker.io containerd runc

# For Raspbian using convenience script
curl -fsSL https://get.docker.com -o /var/tmp/get-docker.sh
sudo sh /var/tmp/get-docker.sh
rm /var/tmp/get-docker.sh

# Adding user to docker group
sudo usermod -aG docker `whoami`
