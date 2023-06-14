#!/usr/bin/env bash

# Replace lines that contains "send dhcp-client-identifier" with "send dhcp-client-identifier = hardware;"
#sed -i 's/^send dhcp-client-identifier.*/send dhcp-client-identifier = hardware;/g' /etc/dhcp/dhclient.conf
sed -i '1d' /etc/dhcp/dhclient.conf