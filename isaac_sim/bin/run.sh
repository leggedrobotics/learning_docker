#!/bin/bash
SSH_PORT="11111"
STUDENT_NAME="test"
SSH_PASSWORD="docker"
HOME_FOLDER_DIR="$HOME/RSL"
ENTRYPOINT="/entrypoint.sh"
TAG="3.11.2"

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
  --tag=*)
    TAG=${i#*=}
    shift
    ;;
esac
done

MOUNT_VOLUME=$HOME_FOLDER_DIR/$STUDENT_NAME
sudo mkdir -p $MOUNT_VOLUME
# print ssh port 
echo "SSH_PORT: $SSH_PORT"

RUN_COMMAND="docker run \
  --ulimit rtprio=99 \
  --cap-add=sys_nice \
  --net=host \
  -e "ACCEPT_EULA=Y" \
  --expose $SSH_PORT \
  -p $SSH_PORT:$SSH_PORT \
  -v $MOUNT_VOLUME/media:/media \
  -v $MOUNT_VOLUME/docker/isaac-sim/cache/kit:/isaac-sim/kit/cache/Kit:rw \
  -v $MOUNT_VOLUME/docker/isaac-sim/cache/ov:/root/.cache/ov:rw \
  -v $MOUNT_VOLUME/docker/isaac-sim/cache/pip:/root/.cache/pip:rw \
  -v $MOUNT_VOLUME/docker/isaac-sim/cache/glcache:/root/.cache/nvidia/GLCache:rw \
  -v $MOUNT_VOLUME/docker/isaac-sim/cache/computecache:/root/.nv/ComputeCache:rw  \
  -v $MOUNT_VOLUME/docker/isaac-sim/logs:/root/.nvidia-omniverse/logs:rw \
  -v $MOUNT_VOLUME/docker/isaac-sim/data:/root/.local/share/ov/data:rw \
  -v $MOUNT_VOLUME/docker/isaac-sim/documents:/root/Documents:rw 
  --name=isaac-sim-$STUDENT_NAME \
  -d --restart unless-stopped \
  -t \
  --shm-size=4g \
  --gpus all \
  -e SSH_PASSWORD=$SSH_PASSWORD \
  -e SSH_PORT=$SSH_PORT \
  --entrypoint=$ENTRYPOINT \
    rslethz/isaac-sim:$TAG"

echo $RUN_COMMAND
$RUN_COMMAND

function getHash {
  hostname -I | awk '{print $1}'
}
IP_ADDRS=$(getHash)

echo "Connect to the container using: ssh root@$IP_ADDRS -p $SSH_PORT"
echo "The default password it set to: $SSH_PASSWORD"
