#!/bin/bash

# script to set up an autoreverse tunnel to a TunnelHub

LOGFILE=/var/log/rcpi-client.log
HUB=$(grep -i rcpi-server /etc/rcpi/rcpi.conf|cut -d":" -f2)
HIGHPORT=61522
AUTOLOGINUSER=pi

# for future use
STATION=$(hostname |cut -d. -f1|tr '[:upper:]' '[:lower:]')

echo "$( date +%F_%T) Initiating reverse tunnel to $HUB" >>$LOGFILE
autossh -M 0 -o "ServerAliveInterval=30" -o "ServerAliveCountMax=3" -NTR 0:localhost:22 $AUTOLOGINUSER@$HUB -p $HIGHPORT
