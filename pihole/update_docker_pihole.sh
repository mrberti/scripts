#!/bin/bash
NAME="pihole"
REPO="diginc/pi-hole-multiarch:debian_armhf"
DOCKER="/usr/bin/docker"

$DOCKER pull $REPO
$DOCKER rm -f pihole
/usr/local/bin/docker_run_pihole.sh
