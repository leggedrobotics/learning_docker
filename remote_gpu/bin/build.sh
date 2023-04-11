#!/bin/bash

PYTHON_VERSION="3.11.2"
CUDA_VERSION="11.7"
BASE="ubuntu:focal"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        --py)
        PYTHON_VERSION="$2"
        shift
        shift
        ;;
        --base)
        BASE="$2"
        shift
        shift
        ;;
        --cuda)
        CUDA_VERSION="$2"
        shift
        shift
        ;;
        *)
        echo "Unknown option: $1"
        exit 1
        ;;
    esac
done

# Set package root path
PKGROOT="$( realpath "$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null 2>&1 && pwd )"/../ )"

echo PKGROOT: $PKGROOT

# Build image
export DOCKER_BUILDKIT=1
DOCKER_BUILD_ARGS=()
if [[ -n "$PYTHON_VERSION" ]]; then
    DOCKER_BUILD_ARGS+=( "--build-arg PYTHON_VERSION=$PYTHON_VERSION" )
fi
if [[ -n "$CUDA_VERSION" ]]; then
    DOCKER_BUILD_ARGS+=( "--build-arg CUDA_VERSION=$CUDA_VERSION" )
fi
if [[ -n "$BASE" ]]; then
    DOCKER_BUILD_ARGS+=( "--build-arg BASE=$BASE" )
fi

docker build --progress=plain --ssh default -t "rslethz/remote-gpu:$PYTHON_VERSION" `${DOCKER_BUILD_ARGS[@]}` -f "$PKGROOT/Dockerfile" "$PKGROOT/"

# EOF