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

FROM ros:noetic-perception-focal
ARG SSH_USERNAME=root
ARG SSH_PASSWORD=docker
ARG SSH_PORT=12346

LABEL maintainer="Jonas Frey" mail="jonfrey@ethz.ch"

SHELL ["/bin/bash", "--login", "-c"]
ENV TERM=xterm-256color

# To avoid tzdata asking for geographic location...
ARG DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_frontend noninteractive

#==
# System APT base dependencies and utilities
#==
COPY base.sh /home/base.sh
RUN chmod +x /home/base.sh
RUN /home/base.sh && rm /home/base.sh

RUN apt-get update && apt-get install -y openssh-server
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# ----------------------------------------------------------------------------
# Random number -> always builds.
ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache
RUN echo "source /opt/conda/bin/activate" >> /root/.bashrc

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD []