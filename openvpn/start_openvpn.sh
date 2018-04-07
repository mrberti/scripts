#!/bin/bash
systemctl start openvpn
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j SNAT --to-source 192.168.1.80
echo 1 > /proc/sys/net/ipv4/ip_forward
