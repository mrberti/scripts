#!/bin/bash
IP6="$(ip -6 route get 2606:4700:4700::1111 | awk '{ print $9; exit }')"
echo $IP6
