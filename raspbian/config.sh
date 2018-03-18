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
sudo apt-get install vim-gtk

# Create new user
sudo useradd -G `groups` simon
sudo passwd simon

# Reboot
sudo reboot
