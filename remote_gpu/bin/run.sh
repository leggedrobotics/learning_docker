#!/bin/bash
SSH_PORT="12346"
STUDENT_NAME="test"
SSH_PASSWORD="docker"
HOME_FOLDER_DIR="$HOME/RSL"
ENTRYPOINT="/entrypoint.sh"

for i in "$@"
do
case $i in
  --password=*)
    SSH_PASSWORD=${i#*=}
    shift
    ;;
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

echo $MOUNT_VOLUME

RUN_COMMAND="docker run \
  --ulimit rtprio=99 \
  --cap-add=sys_nice \
  --net=host \
  --expose $SSH_PORT \
  -v $MOUNT_VOLUME:/media/ \
  --name=remote-gpu-$STUDENT_NAME \
  -d --restart unless-stopped \
  -t \
  --shm-size=4g \
  --gpus all \
  --entrypoint=$ENTRYPOINT \
  rslethz/remote-gpu SSH_PASSWORD=$SSH_PASSWORD SSH_PORT=$SSH_PORT"

echo $RUN_COMMAND
$RUN_COMMAND

function getHash {
  hostname -I | awk '{print $1}'
}
IP_ADDRS=$(getHash)

echo "Connect to the container using: ssh root@$IP_ADDRS -p $SSH_PORT"
echo "The default password it set to: $SSH_PASSWORD"
