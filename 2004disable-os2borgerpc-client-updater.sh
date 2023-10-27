#!/usr/bin/env bash
# Inspred by https://fabianlee.org/2019/10/05/bash-setting-and-replacing-values-in-a-properties-file-use-sed/

# If the script is run multiple times this prevents the "#" signs adding up. 
# We remove it and set it agian in the next line.
sed -i 's/# update_client()/update_client()/g' /usr/local/bin/jobmanager

# Replace "update_client()" with "# update_client()" in /usr/local/bin/jobmanager
sed -i 's/update_client()/# update_client()/g' /usr/local/bin/jobmanager
