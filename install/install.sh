#!/bin/bash
set -e

# bring the system up to date
sudo apt-get -y update
sudo apt-get -y upgrade

# c dev tools
sudo apt-get -y install gcc gdb make automake cmake valgrind rr
sudo apt-get -y install llvm clang clang-tools
sudo apt-get -y install flawfinder splint
sudo apt-get -y install sloccount

# various system tools
sudo apt-get -y install perl cpanminus vim git zsh tmux stow dconf-cli git-email htop neovim
sudo apt-get -y libtool libtool-bin libcurl4-openssl-dev libssl-dev libgpgme11 libgpgme11-dev
sudo apt-get -y lsscsi pciutils
sudo apt-get -y sysstat iotop

# all python packages that we need
sudo apt-get -y install python3 python3-pip python3-dev python3-flake8 python3-mccabe python3-coverage
sudo apt-get -y install python3-venv
pip3 install --user --upgrade polysquare-cmake-linter
pip3 install --user --upgrade pynvim
pip3 install --user --upgrade python-language-server

# network tools
sudo apt-get -y install wget curl tshark wireshark lua5.1

# software engineering tools
sudo apt-get -y install umlet doxygen markdown

# debian packaging
sudo apt-get -y install dpkg dpkg-cross dpkg-dev dpkg-repack dpkg-sig

# stuff I picked up at work
sudo apt-get -y install graphviz tree ack-grep exuberant-ctags clang-format colordiff
sudo apt-get -y install jsonlint shellcheck

sudo apt-get -y install docker.io
sudo systemctl start docker
sudo systemctl enable docker

# programs for user convenience
sudo apt-get -y install keychain xclip keepassxc

# setup automatic security only updates
sudo apt-get install unattended-upgrades
sudo dpkg-reconfigure unattended-upgrades
