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
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --runtime=nvidia \
    --privileged \
    --net=host \
    -v /home/jonfrey/git/learn_voxel_nav:/home/code/learn_voxel_nav \
    -v /home/jonfrey/Datasets/learn_voxel_nav/traversability_wild_anymal:/home/dataset_trav \
    -v /home/jonfrey/Datasets/learn_voxel_nav/unity_dataset:/home/dataset_occ \
    -v /home/jonfrey/Results/learn_voxel_nav:/home/results \
    -v /home/jonfrey/Datasets/ANYmal_datasets:/home/dataset_robot \
    --env ENV_WORKSTATION_NAME=euler \
    --env NEPTUNE_API_TOKEN=$NEPTUNE_API_TOKEN \
    -w /home/code/learn_voxel_nav/learning \
    --name="minkowski-engine" \
    rslethz/minkowski-engine:latest python3 train.py