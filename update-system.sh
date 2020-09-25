#!/bin/bash
set -e

# Stop Debconf from doing anything
export DEBIAN_FRONTEND=noninteractive

apt-get update
listUpgrades=`apt list --upgradable |grep upgradable |cut -d/ -f1`
execUpgrades="DEBIAN_FRONTEND=noninteractive apt-get --yes --assume-yes -o DPkg::options::=\"--force-confdef\" -o DPkg::options::=\"--force-confold\" --only-upgrade install "$listUpgrades
eval $execUpgrades