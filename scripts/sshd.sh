#!/bin/sh
set -uxe

# Don't use DNS to make ssh connections faster
echo "UseDNS no" >> /etc/ssh/sshd_config
