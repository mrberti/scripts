#!/bin/bash

file=/dev/shm/data
baud=500000
serial=/dev/ttyUSB0

function finish {
	echo "removing temporary file $file"
	rm -f $file
}

trap finish EXIT

echo "starting capturing to $file"
stty -F $serial $baud -inpck ignbrk time 5 min 1
cat $serial > $file
