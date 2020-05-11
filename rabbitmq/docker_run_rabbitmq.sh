#!/bin/bash
## You need to enable ipforwarding:
# sysctl net.ipv4.conf.all.forwarding=1
# sudo iptables -P FORWARD ACCEPT

set -e 

DOCKER_IMG="rabbitmq:3-management"
DOCKER_NAME="rabbitmq"

docker run -d \
    --name $DOCKER_NAME \
	-p 15672:15672 \
	-p 1883:1883 \
	--mount type=bind,source="/home/simon/rabbitmq/etc/rabbitmq",target="/etc/rabbitmq" \
	--mount type=bind,source="/home/simon/rabbitmq/var/lib/rabbitmq",target="/var/lib/rabbitmq" \
	--mount type=bind,source="/home/simon/certs",target="/etc/certs",readonly \
	--restart=unless-stopped \
    $DOCKER_IMG \

