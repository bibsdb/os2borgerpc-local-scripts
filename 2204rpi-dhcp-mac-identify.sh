#!/usr/bin/env bash
# Inspred by https://fabianlee.org/2019/10/05/bash-setting-and-replacing-values-in-a-properties-file-use-sed/

# Remove all lines that contains the string "dhcp-identifier"
sed -i '/dhcp-identifier/d' /etc/netplan/50-cloud-init.yaml
# Insert a line after a line that contains "dhcp4:". Insert " \ \ \ \ \ \ dhcp-identifier: mac"
# The spaces are nescessary to get the right indention in the yaml-file
sed -ir '/^[#]*\s*dhcp4:.*/a \ \ \ \ \ \ \ \ \ \ \ \ dhcp-identifier: mac' /etc/netplan/50-cloud-init.yaml

# Enable the new configuration
netplan apply