#!/bin/bash

MAIL_SERVER="smtp.web.de"
MAIL_PORT="587"
HOSTNAME="web.de"
GROUP="simon"

if [[ $(which ssmtp) == "" ]] ; then
	echo "ssmtp not found. Installing..."
	apt-get install ssmtp
fi

echo "WARNING: Your existing ssmtp configuration files will be overwritten."
echo "Your last chance to hit ctrl+c now. Proceed with ENTER."
read

echo
echo "Enter your email: "
read MAIL

echo "Enter your password: "
read -s PASSWORD

cat > /etc/ssmtp/ssmtp.conf << EOF
#
# /etc/ssmtp.conf -- a config file for sSMTP sendmail
#
root=$MAIL
mailhub=$MAIL_SERVER:$MAIL_PORT
rewriteDomain=$HOSTNAME
hostname=$HOSTNAME
UseTLS=no
UseSTARTTLS=Yes
AuthUser=$MAIL
AuthPass=$PASSWORD
#FromLineOverride=yes
FromLineOverride=no
EOF

echo "
# sSMTP aliases
#
# Format:       local_account:outgoing_address:mailhub
#
# Example: root:your_login@your.domain:mailhub.your.domain[:port]
# where [:port] is an optional port number that defaults to 25.
root:mrberti@web.de:smtp.web.de:587
simon:mrberti@web.de:smtp.web.de:587
" > /etc/ssmtp/revaliases

chgrp $GROUP /etc/ssmtp/*
chmod 640 /etc/ssmtp/*
