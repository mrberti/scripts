#!/bin/bash

if [ "$1" != "" ]; then
	baud=$1
else
	baud=500000
fi

file=/dev/shm/data
serial=/dev/ttyUSB0

function finish {
	echo "removing temporary file $file"
	rm -f $file
}

trap finish EXIT

echo "starting capturing to $file. Baudrate = $baud"
stty -F $serial $baud -inpck ignbrk time 5 min 1
cat $serial > $file
