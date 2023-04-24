#!/usr/bin/env bash

if [ $# -ne 1 ]
then
    echo "Usage: $(basename $0) {elo-usb.tar} "
    echo ""
    exit -1
fi

# We have the Elo 

DRIVER_TAR_FILE=$1

if [ ! -f $DRIVER_TAR_FILE ]
then
    echo "No such file: $DRIVER_TAR_FILE"
    echo "Please supply a path to an existing elo driver tar file"
    exit -1
fi

# Add elo touch driver
tgtDir="/etc/opt"
tar -xf "$DRIVER_TAR_FILE" -C ${tgtDir}
cd ${tgtDir}/elo-usb
sudo chmod 777 *
sudo chmod 444 *.txt

# Copy elo udev rules
sudo cp ${tgtDir}/elo-usb/99-elotouch.rules /etc/udev/rules.d

# Copy and enable the elo.service systemd script
sudo cp ${tgtDir}/elo-usb/elo.service /etc/systemd/system/
sudo systemctl enable elo.service
