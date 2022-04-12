#!/bin/bash

# Set package root path
PKGROOT="$( realpath "$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null 2>&1 && pwd )"/../ )"

# Build image
export DOCKER_BUILDKIT=1
docker build --progress=plain --ssh default -t "rslethz/remote-ros"  -f "$PKGROOT/Dockerfile" "$PKGROOT/"

# EOF
