#!/bin/bash

set -e 

DOCKER_IMG="pihole/pihole:latest"
DOCKER_CONFIGS="/home/simon/pihole/etc"
DOCKER_WWW="/var/www/html/simon"
TZ="Asia/Tokyo"
DNS1="1.1.1.1"
DNS2="1.0.0.1"

IP=$(hostname -I | awk '{print $1; exit}')
IPv6=$(hostname -I | awk '{print $3; exit}')

echo "IP: ${IP} - IPv6: ${IPv6}"

docker run -d \
    --name pihole \
	--restart=unless-stopped\
	--net=host\
	--cap-add=NET_ADMIN\
	-v "${DOCKER_CONFIGS}/pihole/:/etc/pihole/" \
	-v "${DOCKER_CONFIGS}/dnsmasq.d/:/etc/dnsmasq.d/" \
	-v "${DOCKER_WWW}:/var/www/html/simon" \
	-v "/var/www/html/.well-known:/var/www/html/.well-known" \
	-e TZ=$TZ\
	-e DNS1=$DNS1\
	-e DNS2=$DNS2\
	-e DNSMASQ_LISTENING="local"\
	-e INTERFACE="eth0"\
	-e ServerIPv6="${IPv6}"\
	-e ServerIP="${IP}" \
    $DOCKER_IMG
#	--mount type=bind,source="/home/simon/pihole/etc/lighttpd/external.conf",target="/etc/lighttpd/external",readonly \
#	--mount type=bind,source="/home/simon/certs",target="/etc/certs",readonly \
#-p 53:53/tcp -p 53:53/udp -p 80:80\
#-p 67/67/udp # for DHCP
#-p 443:443 # for SSL


sleep 3
PW=`docker logs pihole 2> /dev/null | grep 'password'`
echo $PW
echo $PW > pihole_pw.txt
