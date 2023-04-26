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

FROM nvcr.io/nvidia/isaac-sim:2022.2.1 as base

LABEL pytorch_version=2.0+

SHELL ["/bin/bash", "--login", "-c"]
ENV TERM=xterm-256color

# To avoid tzdata asking for geographic location...
ARG DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_frontend noninteractive

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}

USER root
ENV HOME /root

COPY bashrc /root/.bashrc

#==
# System APT base dependencies and utilities
#==
COPY base.sh $HOME/base.sh
COPY python.sh $HOME/python.sh
COPY ros.sh $HOME/ros.sh
COPY env.sh $HOME/env.sh
RUN chmod +x $HOME/base.sh
RUN chmod +x $HOME/ros.sh
RUN chmod +x $HOME/python.sh
RUN chmod +x $HOME/env.sh
RUN $HOME/base.sh && rm $HOME/base.sh\
    && $HOME/ros.sh && rm $HOME/ros.sh
RUN $HOME/python.sh -py=${PYTHON_VERSION} -cuda=${CUDA_VERSION} && rm $HOME/python.sh


# Add this in your Dockerfile
RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir /var/run/sshd && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD []