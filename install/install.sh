#!/bin/bash
echo "$0 is executing"

#bring the system up to date
sudo apt-get -y update
sudo apt-get -y upgrade

GNU="gcc gdb make automake valgrind"
LLVM="llvm clang"
CDEV="flawfinder splint" 
sudo apt-get -y install $GNU $LLVM $CDEV

SYSTEM="perl openssh-client vim git"
sudo apt-get -y install $SYSTEM

PYTHON="python python-pip python-virtualenv"
PYTHON3="python3 python3-pip"
sudo apt-get -y install $PYTHON $PYTHON3

NET="wget curl wireshark tshark"
sudo apt-get -y install $NET

WEB="rhino nodejs npm poedit"
sudo apt-get -y install $WEB

echo "$0 is exiting"
exit
