#!/bin/bash
echo $SSH_PORT

# set the password SSH_PASSWORD
echo "root:$SSH_PASSWORD" | chpasswd

echo SSH_PASSWORD: $SSH_PASSWORD
# show files present in the home directory
ls -la /root/

# Start SSH server at the port SSH_PORT
exec /usr/sbin/sshd -D -p $SSH_PORT