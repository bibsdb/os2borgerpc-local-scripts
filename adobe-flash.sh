#!/usr/bin/env bash

# Install Adobe Flash plugin

sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
sudo apt update
sudo apt -y install flashplugin-installer


