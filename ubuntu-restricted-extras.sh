#!/usr/bin/env bash

# Install the ubuntu-restricted extras meta-package that installs 
# - Support for MP3 and unencrypted DVD playback
# - Microsoft TrueType core fonts
# - Flash plugin
# - codecs for common audio and video files

sudo echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
sudo apt-get -y install ubuntu-restricted-extras


