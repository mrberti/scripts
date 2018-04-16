#!/bin/bash

set -e 

DOCKER_IMG="diginc/pi-hole-multiarch:debian_armhf"
#DOCKER_IMG="diginc/pi-hole:arm_v3.1"
DOCKER_CONFIGS="/home/simon/pihole/etc"
TZ="Asia/Tokyo"
DNS1="1.1.1.1"
DNS2="1.0.0.1"

IP_LOOKUP="$(ip route get 1.1.1.1 | awk '{ print $NF; exit }')"  # May not work for VPN / tun0
IPv6_LOOKUP="$(ip -6 route get 2606:4700:4700::1111 | awk '{ print $9; exit }')"  # May not work for VPN / tun0
IP="${IP:-$IP_LOOKUP}"
IPv6="${IPv6:-$IPv6_LOOKUP}"

echo "IP: ${IP} - IPv6: ${IPv6}"

docker run -d \
    --name pihole \
	--net=host\
	-v "${DOCKER_CONFIGS}/pihole/:/etc/pihole/" \
	-v "${DOCKER_CONFIGS}/dnsmasq.d/:/etc/dnsmasq.d/" \
	-e ServerIP="${IP}" \
	-e ServerIPv6="${IPv6}"\
	-e TZ=$TZ\
	-e DNS1=$DNS1\
	-e DNS2=$DNS2\
	-e INTERFACE="eth0"\
	-e DNSMASQ_LISTENING="local"\
	--cap-add=NET_ADMIN\
	--restart=always\
    $DOCKER_IMG
#-p 53:53/tcp -p 53:53/udp -p 80:80\


sleep 3
docker logs pihole 2> /dev/null | grep 'password:'

