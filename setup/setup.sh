#!/bin/bash
set -e

# create tmp dirs for nvim
mkdir -p "$HOME/.vimtmp/tmp/backupdir"
mkdir -p "$HOME/.vimtmp/tmp/swapdir"
mkdir -p "$HOME/.vimtmp/tmp/undodir"

sudo groupadd docker
sudo groupadd wireshark
sudo usermod -aG docker "$(whoami)"
sudo usermod -aG wireshark "$(whoami)"
sudo setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap

# install source code pro
mkdir /tmp/adobefont
cd /tmp/adobefont || exit 1
wget https://github.com/adobe-fonts/source-code-pro/archive/1.017R.zip
unzip 1.017R.zip
mkdir -p ~/.fonts
cp source-code-pro-1.017R/OTF/*.otf ~/.fonts/
fc-cache -f -v

# set zsh as the default shell
echo "Enter $(whoami)'s password for chsh"
chsh -s "$(which zsh)"

# create main zsh function dir
mkdir -p "$HOME/.zfunc"
# add rustup completions to zsh
rustup completions zsh > ~/.zfunc/_rustup

# create my GOPATH and github username subpath
mkdir -p "$HOME/proj/go/src/github.com/therealjumbo"
