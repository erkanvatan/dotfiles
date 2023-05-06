#!/usr/bin/env bash

# Create a directory for the module and download the source code
sudo mkdir /usr/src/asus-wmi-1.0
pushd /usr/src/asus-wmi-1.0
sudo wget 'https://github.com/Plippo/asus-wmi-screenpad/archive/master.zip'
sudo unzip master.zip
sudo mv asus-wmi-screenpad-master/* .
sudo rmdir asus-wmi-screenpad-master
sudo rm master.zip

# Patch script to your kernel version
sudo sh prepare-for-current-kernel.sh

# Register the module with DKMS
sudo dkms add -m asus-wmi -v 1.0

# Build and install module
sudo dkms build -m asus-wmi -v 1.0
sudo dkms install -m asus-wmi -v 1.0

popd >/dev/null
