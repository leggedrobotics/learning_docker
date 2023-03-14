#!/bin/bash
SSH_PORT="14400"
STUDENT_NAME="test"
HOME_FOLDER_DIR="$HOME/RSL"

for i in "$@"
do
case $i in
  --port=*)
    SSH_PORT=${i#*=}
    shift
    ;;
  --name=*)
    STUDENT_NAME=${i#*=}
    shift
    ;;
  --home=*)
    HOME_FOLDER_DIR=${i#*=}
    shift
    ;;
esac
done

MOUNT_VOLUME=$HOME_FOLDER_DIR/$STUDENT_NAME
mkdir -p $MOUNT_VOLUME

RUN_COMMAND="docker run -d   --name=rdesktop   --security-opt seccomp=unconfined    -e PUID=1000   -e PGID=1000   -e TZ=Etc/UTC   -p $SSH_PORT:3389    --device /dev/dri:/dev/dri    --shm-size="4gb"    --restart unless-stopped   --runtime=nvidia   -e NVIDIA_VISIBLE_DEVICES=all -v $MOUNT_VOLUME:/media/ --name=linuxserver-$STUDENT_NAME lscr.io/linuxserver/rdesktop:ubuntu-xfce"

echo $RUN_COMMAND
$RUN_COMMAND

function getHash {
  hostname -I | awk '{print $1}'
}
IP_ADDRS=$(getHash)

echo "----------------------------------------------------------"
echo "Connect to the VirtualDesktop using Remmina. At first make sure you are within the ETH network. Either connect to the eth or eth-5 wifi or connecto to the VPN provided by ETH. On Ubuntu just search for Remmina / or from the cli excecute remmina. Then select RDP (default) and enter following IP $IP_ADDRS:$SSH_PORT . It is usefull to enable the autorescaling within Remmina. When logging in you will be asked for a username and password. The default username is abc and the password is abc.
The only permanent storage is within /media , therfore store everything in this folder. This container is in an experimental state and we have little experience using it. Therefore make sure to store all your information in /media/ and regularly push your code. Enjoy!"
echo "----------------------------------------------------------"