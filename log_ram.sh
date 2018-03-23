#!/bin/bash
# logs the used and free ram
# also tells you which new processes started in each cycle
# first parameter must be sleep time

sleep_time=${1:-1}
new_procs=
old_procs=
grep_str='Mem'
grep_ops=
awk_str='{print $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7}'

echo -e "timestamp\ttotal\tused\tfree\tshared\tbuff\tavailable"
while true; do
	ps_a=`ps -eo comm | sort`
	echo -ne "$(date +"%s")\t"
	echo -ne "$(free | grep $grep_ops $grep_str | awk "$awk_str")"
	echo -ne "\t"
	echo -n $new_procs
	echo -n $old_procs
	sleep $sleep_time
	ps_b=`ps -eo comm | sort`
	new_procs=`diff <(echo "$ps_a") <(echo "$ps_b") | grep ">" | awk '{print "+" $2 ";"}'`
	old_procs=`diff <(echo "$ps_a") <(echo "$ps_b") | grep "<" | awk '{print "-" $2 ";"}'`
	echo
done
