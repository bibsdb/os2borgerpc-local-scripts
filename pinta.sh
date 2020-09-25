#!/bin/bash

# Install Pinta Project
# Pinta is a free, open source program for drawing and image editing.
sudo rm -rf /etc/apt/sources.list.d/pinta*
apt-get update
sudo apt-get remove -y pinta
sudo apt-get install -y pinta

