#!/bin/sh
set -ux # No -e flag for the dd case

# Remove unused locales
apt-get install -y -q localepurge

# Clean apt cache
apt-get clean
rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /var/log/*

# Block until the empty file has been removed, otherwise, Packer
# will try to kill the box while the disk is still full and that's bad
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
sync
sync
sync

exit 0
