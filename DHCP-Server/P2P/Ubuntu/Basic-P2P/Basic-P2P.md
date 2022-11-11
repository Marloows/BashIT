# Basic Peer-To-Peer

Connecting two computers over an ethernet cable to create a simple network won't work as one expects.

Trust me, I've tried!

This project aims to solve this problem by making one of the computers act like a DHCP-Server so that when an ethernet connection is detected, the "server " will assign the other device automatically an IP address.

## Implementation on Ubuntu using dnsmasq

dnsmasq provides the functionality of a DNS and DHCP Server.

We will be using only the DHCP capability of dnsmasq in this project.

This setup is done on the server device and doesn't need to be repeated.

The server device will be assigned the IP address "192.168.0.1".

The connected device will be given the IP "192.168.0.22".
