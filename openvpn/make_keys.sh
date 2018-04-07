#!/bin/bash 
# A script to make server and client keys
SERVER_NAME="server"
CLIENT_NAMES="pi_simon1 pi_simon2 pi_akiko1"
#KEEP_CA_KEY=""

OUTPUT_DIR="/home/simon/.openvpn"
OUTPUT_USER="simon"
OUTPUT_GROUP="simon"

# We will work directly in the concerning directories
cd $EASY_RSA

source ./vars
# If you want to increase the DH Key size, do it here 
# Do not forget to set the correct file in the server configuration file
KEY_SIZE=2048
EASY_RSA="/etc/openvpn/easy-rsa"
KEY_DIR="$EASY_RSA/keys"

echo
echo "+++ Removing old keys. +++"
bash ./clean-all
echo
echo "+++ Build CA. +++"
bash ./build-ca
echo
echo "+++ Build server key for $SERVER_NAME +++"
bash ./build-key-server $SERVER_NAME

for NAME in $CLIENT_NAMES; do

	echo
	echo "+++ Building key pass for $NAME +++"
	bash ./build-key-pass $NAME
	
	cd $KEY_DIR

	echo
	echo "+++ Encrypt key file. +++"
	openssl rsa -in $NAME.key -des3 -out $NAME.3des.key
	
	cd $EASY_RSA

done

echo
echo "+++ Build DH key. +++"
bash ./build-dh

echo
echo "+++ Generate HMAC key. +++"
openvpn --genkey --secret $KEY_DIR/ta.key

# After all keys are created, we don't need the ca.key anymore
if [[ $KEEP_CA_KEY == "" ]] ; then
	rm -v $KEY_DIR/ca.key
fi

# Set permissions, just to make sure
chmod 600 $KEY_DIR/*
chown root:root $KEY_DIR/*
