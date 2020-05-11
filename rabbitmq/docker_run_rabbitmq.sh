#!/bin/bash

set -e 

DOCKER_IMG="rabbitmq:3-management"
DOCKER_NAME="rabbitmq"
TZ="Asia/Tokyo"

docker run -d \
    --name $DOCKER_NAME \
	--net=host \
	--mount type=bind,source="/home/simon/rabbitmq/etc/rabbitmq",target="/etc/rabbitmq" \
	--mount type=bind,source="/home/simon/rabbitmq/var/lib/rabbitmq",target="/var/lib/rabbitmq" \
	--mount type=bind,source="/home/simon/certs",target="/etc/certs",readonly \
	-e TZ="${TZ}" \
	--restart=unless-stopped \
    $DOCKER_IMG \

