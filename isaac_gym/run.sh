XAUTH=/tmp/.docker.xauth
if [ ! -f $XAUTH ]
then
    xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
    if [ ! -z "$xauth_list" ]
    then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    else
        touch $XAUTH
    fi
    chmod a+r $XAUTH
fi

xhost +local:docker
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -



docker run -it \
    --volume="/home/jonfrey/git/isaac:/home/isaac" \
    --volume="/home/jonfrey/Datasets/learn_voxel_nav/unity_dataset:/home/work/meshes" \
    --volume="/home/jonfrey/Results/learn_voxel_nav/:/home/work/results" \
    --runtime=nvidia \
    --privileged \
    --net=host \
    --name="isaac-gym" \
    --rm \
    --gpus all \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    rslethz/isaac-gym \
    bash



    