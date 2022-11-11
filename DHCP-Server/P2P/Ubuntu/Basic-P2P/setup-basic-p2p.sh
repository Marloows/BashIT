#!/bin/bash

#######################################
###### !!!!!!! DISCLAIMER !!!!!! ######
#######################################

# YOU SHOULD NOT RUN BASH SCRIPTS FROM RANDOM PEOPLE ON THE INTERNET!!!!

# you should not run any bash scripts from random people on the internet

# this is not free candy after all

# that being said this script is meant to be used as a reference on how to setup a dhcp server other an ethernet port

# If you are feeling adventurous and want to use this scrip to automate things, feel free to use it!

# ------------------------------------------------

# This script aims to setup a peer-to-peer network connection between two devices via ethernet cable

# This scrip is to be run on the "server" device

# you should run this script once to set everything up

# you can also run again if things aren't working properly ;)

# ------------------------------------------------

###############
## Variables ##
###############

# the name of the targeted interface
interface='eth0'

# we are only using dnsmasq as dhcp-server
# to avoid conflict with systemd-resolve
port='53053'
# the default is port 53 which will make the service fail!

# network portion of the IP address
network_ip='10.0.0'
# by host is meant this device which is gonna be the dhcp-server
host_ip='1'

# because there is usually only one ethernet port on a computer
# this range should allow just one IP which gonna be "10.0.0.10"
# the idea behind this is to make simpler by referring to the "10.0.0.10" address as the other device
dhcp_range_start='10'
dhcp_range_end='11'

# location of the dnsmasq configuration file
dnsmasq_conf='/etc/dnsmasq.conf'

# location of netplan configuration file
ip_conf='/etc/netplan/01-ethernet-ip.yaml'

# ------------------------------------------------

# it’s always a good idea to download packages before changing network setting
# based on my experiences
apt install dnsmasq

# because bash scripts doesn’t crash after encountering an error
# this script will run and apply the changes
# regardless whether dnsmasq is already downloaded *or NOT

# stop the service before applying any changes
# not really necessary!
systemctl stop dnsmasq

# ------------------------------------------------

###############################################
## Setup static ip address for the interface ##
###############################################

# Bash Heredoc

# ">" means, replace stdout file descriptor with what come afterwards
# "<<" means, replace stdin file descriptor with what come afterwards, which is in this case the Heredoc

# Heredoc is start with "<<" after a command to be the stdin-file for that process
# anything between the EOF belong to the heredoc
# *EOF is not unique anything else should work

# Heredocs supports Parameter Substitution

cat > $ip_conf << EOF
network:
    version: 2
    ethernets:
        $interface:
            dhcp4: false
            addresses: [$network_ip.$host_ip/24]
            optional: true
EOF

netplan apply

# ------------------------------------------------

######################
## setup dhcpserver ##
######################

cat > $dnsmasq_conf << EOF
port=$port
interface=$interface
dhcp-range=$network_ip.$dhcp_range_start,$network_ip.$dhcp_range_end,255.255.255.0,192h
EOF

# ------------------------------------------------

systemctl start dnsmasq
systemctl enable dnsmasq

# ------------------------------------------------

