#!/bin/bash
set -u

# git
sudo apt install -y git

# Slack deb版でないと日本語入力ができないためコメントアウト
# sudo snap install slack --classic
# VSCode
sudo snap install code --classic

sudo apt update

# general
sudo apt -y install cmake

# zsh
sudo apt -y install zsh git gawk curl
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
chsh -s $(which zsh)

sudo apt install fzy

# vim
sudo apt install -y vim curl
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
rm ./installer.sh

# direnv
sudo apt install -y direnv

# pyenv
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
curl https://pyenv.run | bash

# pipenv
sudo apt install -y pipenv virtualenv python3-venv

# pipx
sudo apt install -y pipx

# tmux
sudo apt install -y tmux
# tmux source ~/.tmux.conf

# Linux brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# trash-cli
sudo apt -y install trash-cli

# nodejs
sudo apt install -y nodejs npm
sudo npm install -g n
sudo n stable
sudo apt purge -y nodejs npm

# tig
sudo apt install -y tig

# ngrok
sudo snap install htop
sudo snap install discord
sudo snap install libreoffice
sudo snap install ngrok
sudo snap install tor
sudo snap install vlc
sudo snap install youtube-dl

# Docker
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# $(lsb_release -cs) → eoan
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs)  \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# 上記または以下のコメントアウト部
# sudo apt install -y docker.io
# sudo systemctl enable --now docker

sudo groupadd docker
sudo gpasswd -a $USER docker
sudo systemctl restart docker

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Lazy Docker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# CUDA
# https://developer.nvidia.com/cuda-downloads に従う
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /"
sudo apt-get update
sudo apt-get -y install cuda-10-1

# 上記または以下のコメントアウト部
# sudo apt install -y nvidia-cuda-toolkit

# cuDNN
# https://developer.nvidia.com/rdp/cudnn-download に従い3つのdebをinstallする

# nvtop
git clone https://github.com/Syllo/nvtop.git
mkdir -p nvtop/build && cd nvtop/build
cmake ..
sudo make install

cd ../../
rm -rf nvtop

# nvidia-docker2
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit nvidia-docker2
sudo systemctl restart docker

# xsel
sudo apt install -y xclip

# aria
sudo apt install -y aria2
