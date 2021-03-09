# RCPi - Remote Controlled Raspberry Pi

## TL;DR

### Provide secure access to a headless Raspberry Pi via a jumphost in the cloud

# Installation

On a Raspberry Pi, run install-client.sh to install the autossh service and persist it through systemd. Access the Pi through the default jumphost: http://shell2pi.nl


## The Why

Accessing a headless Raspberry Pi can be a challenge. When no wired access is possible, it's not always easy to find the ip address. On top of that, not all Pi users have access to an SSH client.

## The What

By creating a persistent reverse tunnel to a jumnphost in the cloud, the Raspberry Pi can be accessed though the jumphost. The jumphost dynamically creates a web terminal, so any computer can access the Pi with a internet browser.

Ok, not any computer. The computer must be on the same (Wifi) network as the Pi. Network access to the Pi is restricted to computers on the same local network. The jumphost dynamically creates firewall rules to prevent others from connecting to your Pi. By redirecting dynamic local ports, the jumphost provides the default HTTP and SSH ports to access the Pi. 

In short, your computer has access to the Pi when it connects to the same network (Wifi, Hotspot or wired). Installing SSH is not even necessary, as the jumphost also provides a web shell to your Pi via http://shell2pi.nl by default.

## The How

The Pi runs runs a systemd service called 'rcpi-client' which starts an instance of autossh that persists a reverse tunnel to a  jumphost in the cloud. The jumphost detects new connections and dynamically adds firewall rules to iptables, providing access to the Pi via standard ports through DNAT. Additional firewall rules restrict Pi access to the local network based on the ip address of the Pi's internet connection.

## Alternate jumpserver

If you're bold, build your own jumphost in the cloud. Make sure to make a priority of security, so that no one else can remote access your Raspberry Pi!

Next, run the installation script with the hostname of your alternate jumphost as the first parameter. 
