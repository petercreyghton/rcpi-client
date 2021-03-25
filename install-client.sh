#!/bin/bash

# install.sh installs the RCPi service on a Raspberry Pi
#
# add hostname of hub as parameter to use your own URL

HUB=${1:-shell2pi.nl}
HIGHPORT=61522

# install required packages
#yum install -y epel-release
#yum install -y autossh net-tools bind-utils whois 
apt -y install autossh

# create config file
mkdir /etc/rcpi
cat > /etc/rcpi/rcpi.conf <<-EOF
rcpi-server:$HUB
EOF

# install script
cp rcpi-client.sh /usr/local/bin
cp send-hostname.sh /usr/local/bin

# install the service
cat > /lib/systemd/system/rcpi-client.service <<-EOF
[Unit]
Description=TunnelHub persistent client
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/usr/local/bin
ExecStart=/usr/local/bin/rcpi-client.sh
ExecStartPost=/bin/bash /usr/local/bin/send-hostname.sh
Restart=on-failure
RestartSec=10s

[Install]
WantedBy=multi-user.target
EOF

# get hostkey of rcpi server
mkdir ~/.ssh
ssh-keyscan -p $HIGHPORT -t rsa $HUB >> ~/.ssh/known_hosts

# enable the service 
systemctl daemon-reload
systemctl enable --now rcpi-client


# finished

