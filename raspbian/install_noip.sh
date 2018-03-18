#!/bin/bash
# Install and configure NOIP
mkdir ~/noip
pushd ~/noip
wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz
tar vzxf noip-duc-linux.tar.gz
cd noip-2.1.9-1
sudo make
sudo make install
sudo crontab -e
popd
