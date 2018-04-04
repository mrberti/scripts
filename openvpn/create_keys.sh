#!/bin/bash 
# A script to make a client .ovpn file including keys
# Credits go to: https://readwrite.com/2014/04/10/raspberry-pi-vpn-tutorial-server-secure-web-browsing/
SERVER_NAME="server"
CLIENT_NAMES="simon1" # simon2 simon3"

EASY_RSA="/etc/openvpn/easy-rsa"
KEYS_DIR=$EASY_RSA"/keys"

# We will work directly in the concerning directories
pushd $EASY_RSA

source ./vars
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
	echo "+++ Building key for $NAME +++"
	bash ./build-key $NAME

	echo
	echo "+++ Building key pass for $NAME +++"
	bash ./build-key-pass $NAME
	
	cd $KEYS_DIR

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
openvpn --genkey --secret $KEYS_DIR/ta.key

cd $KEYS_DIR
for NAME in $CLIENT_NAMES; do
# From here below copied from: https://gist.github.com/laurenorsini/9925434
# Default Variable Declarations 
	DEFAULT="Default.txt"
	FILEEXT=".ovpn" 
	CRT=".crt" 
	KEY=".3des.key" 
	CA="ca.crt" 
	TA="ta.key" 
	 
#Ask for a Client name 
#echo "Please enter an existing Client Name:"
#read NAME 
	 
	 
#1st Verify that client’s Public Key Exists 
	if [ ! -f $NAME$CRT ]; then 
	 echo "[ERROR]: Client Public Key Certificate not found: $NAME$CRT" 
	 exit 
	fi 
	echo "Client’s cert found: $NAME$CR" 
	 
	 
#Then, verify that there is a private key for that client 
	if [ ! -f $NAME$KEY ]; then 
	 echo "[ERROR]: Client 3des Private Key not found: $NAME$KEY" 
	 exit 
	fi 
	echo "Client’s Private Key found: $NAME$KEY"

#Confirm the CA public key exists 
	if [ ! -f $CA ]; then 
	 echo "[ERROR]: CA Public Key not found: $CA" 
	 exit 
	fi 
	echo "CA public Key found: $CA" 

#Confirm the tls-auth ta key file exists 
	if [ ! -f $TA ]; then 
	 echo "[ERROR]: tls-auth Key not found: $TA" 
	 exit 
	fi 
	echo "tls-auth Private Key found: $TA" 
	 
#Ready to make a new .opvn file - Start by populating with the 
#default file 
	cat $DEFAULT > $NAME$FILEEXT 
	 
#Now, append the CA Public Cert 
	echo "<ca>" >> $NAME$FILEEXT 
	cat $CA >> $NAME$FILEEXT 
	echo "</ca>" >> $NAME$FILEEXT

#Next append the client Public Cert 
	echo "<cert>" >> $NAME$FILEEXT 
	cat $NAME$CRT | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' >> $NAME$FILEEXT 
	echo "</cert>" >> $NAME$FILEEXT 
	 
#Then, append the client Private Key 
	echo "<key>" >> $NAME$FILEEXT 
	cat $NAME$KEY >> $NAME$FILEEXT 
	echo "</key>" >> $NAME$FILEEXT 
	 
#Finally, append the TA Private Key 
	echo "<tls-auth>" >> $NAME$FILEEXT 
	cat $TA >> $NAME$FILEEXT 
	echo "</tls-auth>" >> $NAME$FILEEXT 
	 
	echo "Done! $NAME$FILEEXT Successfully Created."

#Script written by Eric Jodoin
done

chmod 600 $KEYS_DIR/*
