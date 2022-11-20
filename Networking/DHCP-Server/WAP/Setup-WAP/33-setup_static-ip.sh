#!/bin/bash

# setup static IP

cat << EOF | sudo tee $network_ipconfig

network:
    version: 2
    ethernets:
        $interface:
            optional: true
            dhcp4: false
            addresses: [$host_ip/24]

EOF

sudo ip link set dev $interface down

sudo netplan apply

