#!/bin/bash

sudo ip link set dev $interface down

sudo ip addr add $host_ip/24 dev $interface

sudo systemctl unmask hostpad

sudo systemctl stop hostpad

sudo systemctl start hostapd

systemctl status hostapd


