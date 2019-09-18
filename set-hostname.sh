#!/bin/bash

set -e

if [ $# -ne 1 ]
then
    echo "Dette script skal bruge en parametre: computernavn"
    exit -1
fi

computernavn=$1

hostnamectl set-hostname $computernavn

