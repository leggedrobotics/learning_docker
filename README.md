# Docker Learning Containers:

## Remote Container:

replace `<type>` with `gpu` or `ros`

1. Installation: 
```shell
cd remote_<type> && ./bin/build.sh 
```

2. Running the Container:
```shell
cd remote_<type> && ./bin/run.sh --password=docker --port=12355 --name=good_student --home=/some_path/RSL
```

- `--password`:   Password to login using ssh
- `--port`:       SSH port used
- `--home`:       Directory on the host machine that is mapped inside container.
- `--name`:       Name of the container. Is used to create a folder under `--home`


## Linuxserver Container:
Allows to create a virtual desktop. 
We assume you are able to run the Nvidia Docker Container. 
Ideally, the computer should be assigned a static IP such that it easily reachable within the ETH network. 
If not follow this guide: <https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html>

Big thanks to <https://docs.linuxserver.io/images/docker-rdesktop>

1. Installation: 
```shell
sudo docker pull lscr.io/linuxserver/rdesktop:ubuntu-xfce
```

2. Running the Container:
Start this container on the powerfull host machine.
```shell
./linuxserver/run.sh  --port=14402 --name=good_student --home=/some_path/RSL
```

- `--port`:       SSH port used
- `--home`:       Directory on the host machine that is mapped inside container.
- `--name`:       Name of the container.

Provide the students with the generated output, which provides detailed instructions on how to access the container. 



