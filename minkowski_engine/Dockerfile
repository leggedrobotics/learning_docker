FROM pytorch/pytorch:1.10.0-cuda11.3-cudnn8-devel

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
RUN apt-get install -y git ninja-build cmake build-essential libopenblas-dev \
    xterm xauth openssh-server tmux wget mate-desktop-environment-core
RUN apt-get clean

# You should modify this to match your GPU compute capability
ENV TORCH_CUDA_ARCH_LIST="6.0 6.1 7.0+PTX"
##############################################
ENV TORCH_NVCC_FLAGS="-Xfatbin -compress-all"


RUN apt install -y build-essential python3-dev libopenblas-dev

ENV MAX_JOBS=4
RUN pip3 install -U git+https://github.com/NVIDIA/MinkowskiEngine -v --no-deps \
    --install-option="--force_cuda" \
    --install-option="--blas=openblas"

# For open CV needed
RUN apt -y install libgl1-mesa-glx
RUN apt -y install libglib2.0-0

RUN pip3 install vedo  
RUN pip3 install cython 
RUN pip3 install scikit-image 
RUN pip3 install neptune-client 
RUN pip3 install pytorch-lightning==1.5.7 
RUN pip3 install opencv-python
RUN pip3 install kornia 
RUN pip3 install coloredlogs 
RUN pip3 install open3d

RUN mkdir /home/code
RUN mkdir /home/dataset_occ
RUN mkdir /home/dataset_trav
RUN mkdir /home/results
RUN mkdir /home/dataset_robot


RUN apt-get update -y \
    && apt-get -y install \
    xvfb \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*