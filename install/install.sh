#!/bin/bash
echo "$0 is executing"

#bring the system up to date
sudo apt-get -y update
sudo apt-get -y upgrade

GNU="gcc gdb make automake valgrind"
LLVM="llvm clang"
CDEV="flawfinder splint" 
sudo apt-get -y install $GNU $LLVM $CDEV

SYSTEM="perl openssh-server openssh-client vim git ssh-askpass ssh-askpass-gnome"
sudo apt-get -y install $SYSTEM

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

echo "$0 is exiting"
