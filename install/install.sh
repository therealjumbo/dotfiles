#!/bin/bash
echo "$0 is executing"

#bring the system up to date
sudo apt-get -y update
sudo apt-get -y upgrade

CONTIKI="build-essential binutils-msp430 gcc-msp430 msp430-libc binutils-avr gcc-avr gdb-avr avr-libc avrdude openjdk-7-jdk openjdk-7-jre ant libncurses5-dev doxygen git"
sudo apt-get -y install $CONTIKI

GNU="gcc gdb make automake valgrind"
LLVM="llvm clang"
CDEV="flawfinder splint" 
sudo apt-get -y install $GNU $LLVM $CDEV

SYSTEM="perl openssh-server openssh-client vim git ssh-askpass ssh-askpass-gnome"
RANDOM="dconf-cli"
sudo apt-get -y install $SYSTEM $RANDOM

PYTHON="python python-pip python-dev python-flake8 python-mccabe python-coverage"
PYTHON3="python3 python3-pip python3-dev python3-flake8 python-mccabe python3-coverage"
MORE_PYTHON="python-virtualenv pylint"
sudo apt-get -y install $PYTHON $PYTHON3 $MORE_PYTHON

NET="wget curl tshark wireshark"
sudo apt-get -y install $NET

WEB="rhino nodejs npm poedit"
sudo apt-get -y install $WEB

sudo apt-get -y install apparmor # bug fix
sudo apt-get -y install docker.io 

# the default vim does not support the system clipboard, alias is in .bashrc
sudo apt-get -y install vim.gtk

ZSH="zsh"
sudo apt-get -y install $ZSH

echo "$0 is exiting"
