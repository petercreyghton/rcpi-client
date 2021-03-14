#!/bin/bash

PORT=60000
TUNNELHOST=$(grep -i rcpi-server /etc/rcpi/rcpi.conf|cut -d":" -f2)

LOOP=0
MAXLOOP=15

while [ $LOOP -lt $MAXLOOP ]; do
	echo "hostname|nc -w1 $TUNNELHOST $PORT"
	hostname|nc -w1 $TUNNELHOST $PORT
	if [ $? -eq 0 ]; then echo "Hostname sent to tunnelhost"; break; fi
	sleep 1
	LOOP=$((LOOP+1))
done
