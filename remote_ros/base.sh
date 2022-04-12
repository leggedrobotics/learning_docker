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