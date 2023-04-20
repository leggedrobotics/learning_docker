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
source $HOME/env.sh

# install python
pyenv install 3.11.2
pyenv global 3.11.2
# export to path 
export PATH="$HOME/.pyenv/versions/3.11.2/bin:$PATH"

# install pytorch
pip install torch torchvision torchaudio
pip install transformers
pip install timm
