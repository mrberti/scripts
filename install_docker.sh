#!/bin/bash
#https://docs.docker.com/install/linux/docker-ce/debian/

# Uninstall old versions
sudo apt-get remove docker docker-engine docker.io containerd runc

# For Raspbian using convenience script
curl -fsSL https://get.docker.com -o /var/temp/get-docker.sh
sudo sh /var/temp/get-docker.sh

# Adding user to docker group
sudo usermod -aG docker `whoami`
