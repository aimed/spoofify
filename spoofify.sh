#!/bin/bash
# Based on:
# https://blog.macsales.com/43777-tech-101-spoofing-a-mac-address-in-macos-high-sierra
# http://www.dgkapps.com/blog/osx-tips/osx-tips-turn-off-wifi-from-the-command-line/

# Get current wifi device
CURRENT_DEVICE=$(networksetup -listallhardwareports | awk '$3=="Wi-Fi" {getline; print $2}')
echo "Current Wi-Fi Device = '$CURRENT_DEVICE'"

# Store the current address and create a new random mac address
CURRENT_ADDRESS=$(ifconfig $CURRENT_DEVICE | awk '/ether/{print $2}')
NEW_ADDRESS=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
echo "Current MAC Address = '$CURRENT_ADDRESS'"

# Actually change the address
sudo ifconfig $CURRENT_DEVICE ether $NEW_ADDRESS

# Verify that the adress has been changed
NEW_ADDRESS_VERIFIED=$(ifconfig $CURRENT_DEVICE | awk '/ether/{print $2}')

echo "New Address = '$NEW_ADDRESS_VERIFIED'"
echo "You now need to disconnect frmo your current network and connect again."