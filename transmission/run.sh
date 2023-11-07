#!/bin/bash

openvpn /AirVPN_America_UDP-443.ovpn &
sleep 5

echo "Starting transmission..."

ip route add 192.168.0.0/24 dev eth0

su -c "/usr/bin/transmission-daemon -f" sharing

