#!/usr/bin/env bash

if [ $# -ne 1 ]
then
  echo "Dette script tager en parameter: printernavn"
  exit -1
fi


lpoptions -p $1 -l