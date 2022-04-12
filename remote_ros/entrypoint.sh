#!/bin/bash

SSH_PASSWORD="docker"
SSH_PORT="12345"

for i in "$@"
do
case $i in
  SSH_PASSWORD=*)
    SSH_PASSWORD=${i#*=}
    shift
    ;;
  SSH_PORT=*)
    SSH_PORT=${i#*=}
    shift
    ;;
esac
done
echo "Start on port ${SSH_PORT}!"
echo "root:$SSH_PASSWORD"|chpasswd
sudo service ssh restart
sudo /usr/sbin/sshd -p $SSH_PORT
bash