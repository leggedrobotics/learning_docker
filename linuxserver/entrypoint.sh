#!/bin/bash
echo $SSH_PORT

# set the password SSH_PASSWORD
echo "$SSH_USERNAME:$SSH_PASSWORD" | chpasswd

echo SSH_PASSWORD: $SSH_PASSWORD

# Start SSH server at the port SSH_PORT
exec /usr/sbin/sshd -D -p $SSH_PORT