#!/bin/bash

function file_exists_and_is_reg() {
    if [ -e "$1" ] && [ -f "$1" ]; then
        local ret="1"
    else
        local ret="0"
    fi
    echo $ret
}

# run a script
# Input:
#   $1 is the name (including absolute or relative path) of the script to run
#   $2 boolean, if true script will return and not abort, if false will abort
#       if error
function run_script() {
    if [ $(file_exists_and_is_reg $1) -eq "1" ]; then
        echo "The script: $1 exists"
        chmod a+x "$1"
        "$1"
    else
        echo "The script $1 does not exist"
        if [ $2 -ne "1" ]; then
            exit 1
        fi
    fi
    echo $ret
}

# ask for password upfront
sudo -v

# keep-alive; update existing sudo time stamp if set, otherwise do nothing
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# run the generic install script
# if the install.sh script does not exist, or is not a regular file then abort 
INSTALL="./install/install.sh"
run_script $INSTALL "0" 

# attempt to run each argument as an install script
# example $1=xfce4, so file=./install/install_xfce4.sh
# if the file does not exist do NOT abort, go to next arg
PREFIX="./install/install_"
EXT=".sh"
for ARG in $@; do
    file="$PREFIX$ARG$EXT"
    run_script $file "1" 
done

# run the generic setup script
# if the setup.sh script does not exist, or is not a regular file then abort
SETUP="./setup/setup.sh"
run_script $SETUP "0" 

# attempt to run each argument as a setup script
# example $1=xfce4, so file=./setup/setup_xfce4.sh
# if the file does not exist do NOT abort, go to next arg
PREFIX="./setup/setup_"
EXT=".sh"
for ARG in $@; do
    file="$PREFIX$ARG$EXT"
    run_script $file "1" 
done

# run the generic dotfiles setup script
# if the setup.sh script does not exist, or is not a regular file then abort
DOTFILES="./dotfiles/dotfiles.sh"
run_script $DOTFILES "0"

# attempt to run each argument as a dotfiles script
# example $1=xfce4, so file=./dotfiles/dotfiles_xfce4.sh
# if the file does not exist do NOT abort, go to next arg
PREFIX="./dotfiles/dotfiles_"
EXT=".sh"
for ARG in $@; do
    file="$PREFIX$ARG$EXT"
    run_script $file "1" 
done
