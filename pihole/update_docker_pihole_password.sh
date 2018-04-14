#!/bin/bash

set -e 

echo -n "Please enter a new password: "
read -s PW
echo
echo -n "Confirm: "
read -s PW2
echo

if [[ $PW != $PW2 ]] ; then
	echo "Passwords are not the same."
	exit 1
fi

docker exec pihole bash -c "pihole -a -p $PW"
