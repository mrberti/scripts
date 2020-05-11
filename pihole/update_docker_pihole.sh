#!/bin/bash
NAME="pihole"
REPO="pihole/pihole:latest"
DOCKER="/usr/bin/docker"

$DOCKER pull $REPO
$DOCKER rm -f pihole
/home/simon/scripts/pihole/docker_run_pihole.sh

