#!/bin/bash

## isc-dhcp-server

setup_isc_dhcp_server='11-setup_isc-dhcp-server.sh'

dhcp_config='/etc/dhcp/dhcpd.conf'

dhcp_config_interface='/etc/default/isc-dhcp-server'

interface='wlan0'

lease_time='600'

max_lease_time='7200'

network_ip='192.168.22'

network_subnet="$network_ip.0"

network_netmask='255.255.255.0'

host_ip="$network_ip.1"

network_range_start="$network_ip.20"

network_range_end="$network_ip.100"

domain_name='mydomain.example'

# -----------------------

## hostapd

setup_hostapd='22-setup_hostapd.sh'

hostapd_config='/etc/hostapd/hostapd.conf'

hostapd_default='/etc/default/hostapd'

wap_ssid='MWM-WLAN'

wap_password='blast-quake'


# -----------------------

# static IP

setup_static_ip='33-setup_static-ip.sh'

network_ipconfig="/etc/netplan/22-$wap_ssid.yaml"

# -----------------------

setup_launch='99-setup_launch.sh'

