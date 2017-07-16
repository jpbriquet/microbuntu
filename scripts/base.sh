#!/bin/sh
set -uxe

# Create customize folder
mkdir -p /var/customize
chown ubuntu.ubuntu /var/customize

# DNS - Set static google dns configuration
echo "supersede domain-name-servers 8.8.8.8, 8.8.4.4;" >> /etc/dhcp/dhclient.conf

# Update package definition
apt-get update

# Base tools
apt-get install curl

# Install latest kernel
apt-get install -qy linux-virtual-hwe-16.04-edge

# Remove previous kernel
apt-get remove -qy linux-image-$(uname -r) linux-headers-$(uname -r) linux-headers-$(uname -r) linux-headers-generic linux-headers-virtual linux-image-virtual linux-virtual
apt-get -qy autoremove
update-grub2

# Upgrade system
apt-get -y upgrade
