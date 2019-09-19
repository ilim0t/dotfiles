#!/bin/bash
set -u

# chrome
sudo snap install chromium
# Jetbrains Toolbox
# Slack
sudo snap install slack --classic
# VSCode
sudo snap install code-insiders --classic

sudo apt update

# general
sudo apt -y install htop cmake

# zsh
sudo apt -y install zsh git gawk curl
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
chsh -s $(which zsh)

sudo apt install fzy

# vim
sudo apt install -y vim curl
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein

# direnv
sudo apt install -y direnv

# pyenv

# Ubuntu 19以下なら実行
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
curl https://pyenv.run | bash

# pipenv
# Ubuntu 19.04
sudo apt -y install pipenv
# それ以外
sudo apt install -y python3-pip
pip3 install --user pipenv

# tmux
sudo apt install -y tmux
# tmux source ~/.tmux.conf

# trash-cli
sudo apt -y install trash-cli

# nodejs
sudo apt install -y nodejs npm
sudo npm install -g n
sudo n stable
sudo apt purge nodejs npm

# tig
sudo apt install -y tig

# Docker
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo groupadd docker
sudo gpasswd -a $USER docker
sudo systemctl restart docker

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# nvidia-docker2
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker
sudo apt install -y nvidia-docker2

# CUDA
# https://developer.nvidia.com/cuda-downloads ni sitagau
sudo apt isntall -y cuda-10-0

# nvtop
# Ubuntu 19.04
sudo apt install -y nvttop

# else
git clone https://github.com/Syllo/nvtop.git
mkdir -p nvtop/build && cd nvtop/build
cmake ..

sudo make install
