#!/bin/bash
timeout=5 # seconds
ip="192.168.1.91"
port=5025
cmd="MEAS?\n"
sleep=.1

while [ 1 ]
do
	data=$(echo -ne $cmd | nc $ip $port -w$timeout)
	if [ $data ]; then
		timestamp=$(date +%s.%3N)
		echo "$timestamp,$data"
		sleep $sleep
	else
		sleep 1
	fi
done
