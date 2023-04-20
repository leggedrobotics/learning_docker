#!/bin/bash

apt update && apt install -y \
  sudo \
  lsb-release \
  ca-certificates \
  apt-utils \
  gnupg2 \
  locate \
  curl \
  wget \
  git \
  vim \
  nano \
  gedit \
  tmux \
  unzip \
  iputils-ping \
  net-tools \
  htop \
  iotop \
  iftop \
  nmap \
  software-properties-common \
  build-essential \
  gdb \
  pkg-config \
  cmake \
  zsh \
  tzdata \
  clang-format \
  clang-tidy \
  xterm \
  gnome-terminal \
  dialog \
  tasksel \
  meld \
  figlet \
  wmctrl \
  tmux \
  usbutils \
  && \
  rm -rf /var/lib/apt/lists/*

# TMUX
echo """# Make mouse useful in copy mode \
      setw -g mouse on """ >> ~/.tmux.conf

# install python 
apt update
apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

#install curl 
apt install -y curl

curl https://pyenv.run | bash

echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc

# Source env.sh to set environment variables
source /home/env.sh

# install python
pyenv install 3.11.2
pyenv global 3.11.2

# install pytorch
pip install torch torchvision torchaudio
pip install transformers
pip install timm
