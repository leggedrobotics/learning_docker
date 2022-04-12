# Docker Learning Containers:

## Remote Container:

replace `<type>` with `gpu` or `ros`

1. Installation: 
```shell
cd remote_<type> && ./bin/build.sh 
```

2. Running the Container:
```shell
cd remote_<type> && ./bin/run.sh --password=docker --port=12345 --name=good_student --home=/some_path/RSL
```

- `--password`:   Password to login using ssh
- `--port`:       SSH port used
- `--home`:       Directory on the host machine that is mapped inside container.
- `--name`:       Name of the container. Is used to create a folder under `--home`