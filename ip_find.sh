#!/bin/bash
# This little scripts tries to get answers from all devices on the net
# Argument one defines a subdomain, e.g. 192.168.123
# Better way of doing: nmap -sn 192.168.1.0/24

# depending on the type of ping, use these options and grep string
if [ -n "$(env | grep -i windows)" ]; then
	echo "Using windows mode"
	options="-n 1 -w 1000"
	grep_str="Antwort"
	base_ip=`ipconfig | grep IPv4 | grep -Eo '192.168.[0-9]{1,3}' | tail -1`
else
	echo "Using unix mode"
	options="-c 1 -w 1"
	if [ -n "$(echo $LANG | grep de)" ]; then
		grep_str="bytes from"
	else
		# assuming english
		grep_str="bytes from"
	fi
	base_ip=`ifconfig | grep -Eo '192.168.[0-9]{1,3}' | head -1`
fi

if [ "$1" != "" ]; then
	echo "using script argument $1"
	exit
	base_ip=$1
fi

echo "start probing ip on domain $base_ip"

# ping range of ips
for i in `seq 1 254`;
do
	ip="$base_ip.$i"
	ping $options $ip | grep "$grep_str"
	echo -ne $i '\r'
done
