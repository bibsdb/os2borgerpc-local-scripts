#!/usr/bin/env bash
# Inspred by https://fabianlee.org/2019/10/05/bash-setting-and-replacing-values-in-a-properties-file-use-sed/

# Replace lines that starts with "send dhcp-client-identifier" with "send dhcp-client-identifier = hardware;"
# Also matches lines that starts with "#send dhcp-client-identifier"
sed -ir "s/^[#]*\s*send dhcp-client-identifier.*/send dhcp-client-identifier = hardware;/" /etc/dhcp/dhclient.conf