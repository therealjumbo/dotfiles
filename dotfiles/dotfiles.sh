#!/bin/bash
# This script creates symlinks from the home directory to any desired dotfiles
# in ~/setup_home/dotfiles/

pushd ~/setup_home/dotfiles

stow --target=$HOME stow

stow --target=$HOME ack

stow --target=$HOME git

stow --target=$HOME nvim

stow --target=$HOME tmux

stow --target=$HOME vim

stow --target=$HOME zsh

popd

exit
