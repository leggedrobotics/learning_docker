export DOCKER_BUILDKIT=1
docker build --progress=plain --ssh default ./ -t rslethz/isaac-gym