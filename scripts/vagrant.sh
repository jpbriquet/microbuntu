#!/bin/sh
set -eux

# Set up sudo
echo "${BASE_USER}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/$BASE_USER
chmod 440 /etc/sudoers.d/$BASE_USER
chown root.root /etc/sudoers.d/$BASE_USER

# Install vagrant insecure ssh key (replaced automatically at first vagrant up)
SSH_USER_DIR="/home/${BASE_USER}/.ssh"
mkdir -p "${SSH_USER_DIR}"
curl -Lso "${SSH_USER_DIR}/authorized_keys" \
    'https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub'
chmod -R go-rwsx "${SSH_USER_DIR}"
chown -R "${BASE_USER}:${BASE_USER}" "${SSH_USER_DIR}"
