#!/bin/bash

set -e 

DOCKER_IMG="rabbitmq:3-management"
DOCKER_NAME="rabbitmq"
TZ="Asia/Tokyo"

docker run -d \
    --name $DOCKER_NAME \
	--net=host \
	-v "/home/simon/rabbitmq/etc/rabbitmq:/etc/rabbitmq" \
	-v "/home/simon/rabbitmq/var/lib/rabbitmq:/var/lib/rabbitmq" \
	-e "TZ=${TZ}" \
	--restart=always \
    $DOCKER_IMG \

