#!/bin/bash
NAME="pihole"
REPO="pihole/pihole:latest"
DOCKER="/usr/bin/docker"

$DOCKER pull $REPO
$DOCKER rm -f pihole
/usr/local/bin/docker_run_pihole.sh

