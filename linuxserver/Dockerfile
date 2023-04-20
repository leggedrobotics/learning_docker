#=============================================================================
# Copyright (C) 2022, Robotic Systems Lab, ETH Zurich
# All rights reserved.
# http://www.rsl.ethz.ch
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# Authors: Jonas Frey, jonfrey@ethz.ch
#=============================================================================

#==
# Foundation
#==

ARG PYTHON_VERSION=3.11.2
ARG CUDA_VERSION=11.8
ARG SSH_USERNAME=root
ARG SSH_PASSWORD=docker
ARG SSH_PORT=22

FROM linuxserver/rdesktop:mate-focal as base

LABEL maintainer="Jonas Frey" mail="jonfrey@ethz.ch"
LABEL pytorch_version=2.0+

SHELL ["/bin/bash", "--login", "-c"]
ENV TERM=xterm-256color

# To avoid tzdata asking for geographic location...
ARG DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_frontend noninteractive

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

USER root
ENV HOME /root

COPY bashrc /root/.bashrc

#==
# System APT base dependencies and utilities
#==
COPY base.sh /home/base.sh
COPY env.sh /home/env.sh
RUN chmod +x /home/base.sh
RUN chmod +x /home/env.sh
RUN /home/base.sh -py=${PYTHON_VERSION} -cuda=${CUDA_VERSION} && rm /home/base.sh

RUN apt-get update && apt-get install -y fuse

# Add this in your Dockerfile
RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir /var/run/sshd && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

# add entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
