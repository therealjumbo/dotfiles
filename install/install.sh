#!/bin/bash
echo "$0 is executing"

#bring the system up to date
sudo apt-get -y update
sudo apt-get -y upgrade

GNU="gcc gdb make automake valgrind"
LLVM="llvm clang"
CDEV="flawfinder splint" 
sudo apt-get -y install $GNU $LLVM $CDEV

SYSTEM="perl openssh-client vim git ssh-askpass ssh-askpass-gnome"
sudo apt-get -y install $SYSTEM

PYTHON="python python-pip python-virtualenv python-dev"
PYTHON3="python3 python3-pip python3-dev"
sudo apt-get -y install $PYTHON $PYTHON3

NET="wget curl wireshark tshark"
sudo apt-get -y install $NET

WEB="rhino nodejs npm poedit"
sudo apt-get -y install $WEB

OTHER="docker.io"
sudo apt-get -y install $OTHER

echo "$0 is exiting"
exit
