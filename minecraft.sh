#!/bin/bash
sudo apt-get install  -y gdebi
wget --no-check-certificate https://launcher.mojang.com/download/Minecraft.deb
sudo gdebi -n Minecraft.deb
rm Minecraft.deb

