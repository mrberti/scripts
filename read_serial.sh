#!/bin/bash
# This script reads data from a device and writes it into a file.
# Other programs, such as octave or gnuplot can read from the file to plot the data.
# When /dev/shm is used, the IO is quite efficient.
# Author: Simon Bertling, 2018

file=/dev/shm/data
file_buf=/dev/shm/data_buf
dev=/dev/ttyUSB0

function finish {
	echo "removing temporary files"
	rm -f $file
	rm -f $file_buf
}

trap finish EXIT

if [ "$1" != "" ]; then
	max_lines=$1
else
	max_lines=2000
fi

if [ "$2" != "" ]; then
	baud=$2
else
	baud=500000
fi

# Create files
touch $file $file_buf

# Set serial option
stty -F $dev $baud -inpck ignbrk time 5 min 1
echo "starting captruing to $file. Maximum line count = $max_lines.  Baudrate = $baud."

# Pipe data into a while loop
line_counter=0
cat $dev | \
while read line; do
	let line_counter=line_counter+1
	if [[ $line_counter -gt $max_lines ]]; then
		# Clearing buffer
		tail -n$max_lines $file > $file_buf
		cp $file_buf $file
		line_counter=0
	fi
	echo $line >> $file
done

