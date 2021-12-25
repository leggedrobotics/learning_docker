import os

mode = "tar"
ssh_key_name = "jonfrey_ws"  # name of the ssh key within ~/.ssh/ folder for bitbucket
isaac_path = "/home/jonfrey/Repos/isaac"  # Folder contatining all the repos needed


if mode == "tar":

    cwd = os.getcwd()
    if not os.path.exists("isaac.tar"):
        os.system(f"cd {isaac_path}/.. && tar -cvf {cwd}/isaac.tar isaac")

    os.system(
        "export DOCKER_BUILDKIT=1 && docker build --progress=plain -f Dockerfile_tar ./ -t rslethz/isaac-gym"
    )

elif mode == "bitbucket":
    os.system(
        f"eval $(ssh-agent) && ssh-add ~/.ssh/{ssh_key_name} && export DOCKER_BUILDKIT=1 && docker build --progress=plain --ssh default --build-arg LEGGED_GYM_BRANCH=learn_voxel_nav -f Dockerfile_bitbucket ./ -t rslethz/isaac-gym"
    )
