#!/bin/bash

sudo apt-get install -y hostapd

cat << EOF | sudo tee $hostapd_config

interface=$interface
driver=nl80211
ssid=$wap_ssid
hw_mode=g
channel=7
wmm_enabled=0
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=$wap_password
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP

EOF

cat << EOF | sudo tee $hostapd_default

DAEMON_CONF=$hostapd_config

EOF


