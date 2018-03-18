#!/bin/bash
# Change standard password
passwd

# Regenerate SSH server keys
sudo mkdir /etc/ssh/backup
sudo dpkg-reconfigure openssh-server

# Update hostname
echo "simon-pi" > /etc/hostname
# Add line to /etc/hosts: 127.0.1.1 simon-pi
echo "127.0.1.1 simon-pi" >> /etc/hosts

# Start raspi configuration
sudo raspi-config

# Install standard software
sudo apt-get update
sudo apt-get install vim-gtk git

# Install XRDP. Boot to desktop must be activated
#sudo apt-get purge realvnc-vnc-server
#sudo apt-get install xrdp

# Install and configure NOIP
#mkdir ~/noip
#pushd ~/noip
#wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz
#tar vzxf noip-duc-linux.tar.gz
#cd noip-2.1.9-1
#sudo make
#sudo make install
#sudo crontab -e
#popd

# Get my standard scripts
cd ~
git clone git@github.com:mrberti/home
git clone git@github.com:mrberti/scripts
git clone git@github.com:mrberti/python

# Create new user
sudo useradd -G `groups` simon
sudo passwd simon

# Reboot
sudo reboot
