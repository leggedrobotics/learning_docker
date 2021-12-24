FROM nvidia/cuda:11.4.2-runtime-ubuntu20.04

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics
LABEL maintainer="Jonas Frey" mail="jonfrey@ethz.ch"

SHELL ["/bin/bash", "--login", "-c"]

# To avoid tzdata asking for geographic location...
ARG DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_frontend noninteractive

RUN apt-get -y update
RUN apt-get install -y git wget vim



RUN apt-get -y install python3-pip
RUN pip3 install torch==1.10.0+cu113 torchvision==0.11.1+cu113 torchaudio==0.10.0+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html


# Random number -> always builds.
ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache 

# # Install IsaacGym with LeggedGym
# RUN mkdir -p /root/.ssh && ssh-keyscan github.com bitbucket.org 2> /dev/null >> /root/.ssh/known_hosts
COPY build_script.sh /home/build_script.sh 
RUN sh -c "chmod +x /home/build_script.sh"
RUN --mount=type=cache,target=/home/,source=/home/jonfrey/git/isaac /home/build_script.sh 

