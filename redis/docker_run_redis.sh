#!/bin/bash

set -e 

DOCKER_IMG="redis"
DOCKER_NAME="redis"
REDIS_CMD="redis-server /usr/local/etc/redis/redis.conf"
CONF="/home/simon/redis/redis.conf"
DATA="/home/simon/redis/data"
TZ="Asia/Tokyo"

docker run -d \
    --name $DOCKER_NAME \
	--net=host \
	-v "${CONF}:/usr/local/etc/redis/redis.conf" \
	-v "${DATA}:/data" \
	-e "TZ=$TZ" \
	--restart=always \
    $DOCKER_IMG \
	$REDIS_CMD

