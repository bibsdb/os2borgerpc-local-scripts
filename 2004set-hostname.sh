#!/bin/bash

set -e

if [ $# -ne 1 ]
then
    echo "Dette script skal bruge en parametre: computernavn"
    exit -1
fi

computernavn=$1

hostnamectl set-hostname $computernavn

set_os2borgerpc_config hostname $computernavn
os2borgerpc_push_config_keys hostname

