#!/bin/bash
sudo apt install gdebi-core
wget https://launcher.mojang.com/download/Minecraft.deb
sudo gdebi ~/Minecraft.deb

rm Minecraft.deb
