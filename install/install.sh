#!/bin/bash
echo "$0 is executing"

#bring the system up to date
sudo apt-get -y update
sudo apt-get -y upgrade

# packages required to build contiki
CONTIKI="build-essential binutils-msp430 gcc-msp430 msp430-libc binutils-avr gcc-avr gdb-avr avr-libc avrdude openjdk-7-jdk openjdk-7-jre ant libncurses5-dev doxygen git"
sudo apt-get -y install $CONTIKI

# c dev tools
GNU="gcc gdb make automake valgrind"
LLVM="llvm clang"
CDEV="flawfinder splint" 
sudo apt-get -y install $GNU $LLVM $CDEV

# various system tools
SYSTEM="perl openssh-server openssh-client vim git zsh tmux stow"
RANDOM="dconf-cli"
sudo apt-get -y install $SYSTEM $RANDOM

# all python packages that we need
PYTHON="python python-pip python-dev python-flake8 python-mccabe python-coverage"
PYTHON3="python3 python3-pip python3-dev python3-flake8 python-mccabe python3-coverage"
MORE_PYTHON="python-virtualenv pylint"
PYTHON_DATABASE="postgresql-server-dev-all libpq-dev"
sudo apt-get -y install $PYTHON $PYTHON3 $MORE_PYTHON $PYTHON_DATABASE

# network tools
NET="wget curl tshark wireshark lua5.2"
sudo apt-get -y install $NET

# heroku and dependencies
HEROKU="ruby ruby2.0"
sudo apt-get -y $HEROKU 
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# tools for web dev
WEB="postgresql rhino nodejs npm poedit"
sudo apt-get -y install $WEB

# software engineering tools
SE="umlet"
sudo apt-get -y install $SE

sudo apt-get -y install apparmor # bug fix
sudo apt-get -y install docker.io

# the default vim does not support the system clipboard, alias is in .bashrc
sudo apt-get -y install vim.gtk

# necessary for google drive client
sudo apt-get -y install golang
sudo add-apt-repository -y ppa:twodopeshaggy/drive
sudo apt-get update
sudo apt-get install drive

# programs for user convenience
USER="ssh-askpass ssh-askpass-gnome firefox"
sudo apt-get -y install $USER

# ruby programs
sudo gem install dpl
sudo gem install tmuxinator

# add gitlab repo's to apt-get 
sudo curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh | sudo bash
# Install gitlab-ci-multi-runner:
sudo apt-get install gitlab-ci-multi-runner

echo "$0 is exiting"

