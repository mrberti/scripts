#!/bin/bash

set -e 

DOCKER_IMG="pihole/pihole:latest"
DOCKER_CONFIGS="/home/simon/pihole/etc"
DOCKER_WWW="/var/www/html/simon"
TZ="Europe/Berlin"
DNS1="1.1.1.1"
DNS2="1.0.0.1"

IP=$(hostname -I | awk '{print $1; exit}')
IPv6=$(hostname -I | awk '{print $3; exit}')

echo "IP: ${IP} - IPv6: ${IPv6}"

docker run -d \
    --name pihole \
	--restart=unless-stopped \
	-p 53:53/tcp -p 53:53/udp -p 8001:80 \
	-v "${DOCKER_CONFIGS}/pihole/:/etc/pihole/" \
	-v "${DOCKER_CONFIGS}/dnsmasq.d/:/etc/dnsmasq.d/" \
	-e TZ=$TZ\
	-e DNS1=$DNS1\
	-e DNS2=$DNS2\
    $DOCKER_IMG
	# -e ServerIPv6="${IPv6}"\
	# -e ServerIP="${IP}" \
# -p 67/67/udp # for DHCP
	# --cap-add=NET_ADMIN\
	# --net=host\
	# -v "${DOCKER_WWW}:/var/www/html/simon" \
	# -v "/var/www/html/.well-known:/var/www/html/.well-known" \
	# -e DNSMASQ_LISTENING="local"\
	# -e INTERFACE="eth0"\
#	--mount type=bind,source="/home/simon/pihole/etc/lighttpd/external.conf",target="/etc/lighttpd/external",readonly \
#	--mount type=bind,source="/home/simon/certs",target="/etc/certs",readonly \
#-p 53:53/tcp -p 53:53/udp -p 80:80\
#-p 67/67/udp # for DHCP
#-p 443:443 # for SSL


sleep 5
PW=`cat pihole_pw.txt`
docker exec -it pihole sudo pihole setpassword $PW
