#!/bin/bash

sudo apt-get install isc-dhcp-server -y

cat << EOF | sudo tee $dhcp_config

default-lease-time $lease_time;
max-lease-time $max_lease_time;

authoritative;

subnet $network_subnet netmask $network_netmask {
 range $network_range_start $network_range_end;
 option routers $host_ip;
 option domain-name-servers $host_ip;
 option domain-name "$domain_name";
}

EOF

cat << EOF | sudo tee $dhcp_config_interface

INTERFACESv4="$interface"
INTERFACESv6=""

EOF

sudo systemctl restart isc-dhcp-server

systemctl status isc-dhcp-server


