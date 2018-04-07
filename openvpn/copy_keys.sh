#!/bin/bash 
OUTPUT_DIR="/home/simon/.openvpn"
OUTPUT_USER="simon"
OUTPUT_GROUP="simon"
KEYS_DIR=$EASY_RSA"/keys"

cp $KEYS_DIR/*.ovpn $OUTPUT_DIR/
chown $OUTPUT_USER:$OUTPUT_GROUP $OUTPUT_DIR/*.ovpn
chmod 600 $OUTPUT_DIR/*.ovpn
