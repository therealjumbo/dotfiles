#!/bin/bash
set -e

pushd ./dotfiles
stow --target="$HOME" stow

stow --target="$HOME" ack

[ -f "$HOME/.gitconfig" ] && \
mv "$HOME/.gitconfig" "$HOME/.gitconfig.old"
stow --target="$HOME" git

stow --target="$HOME" nvim

stow --target="$HOME" tmux

stow --target="$HOME" vim

[ -f "$HOME/.zshrc" ] && \
mv "$HOME/.zshrc" "$HOME/.zshrc.old"
stow --target="$HOME" zsh

stow --target="$HOME/.ssh/" ssh

[ -f "$HOME/.profile" ] && \
mv "$HOME/.profile" "$HOME/.profile.old"
stow --target="$HOME" profile

stow --target="$HOME" pyenv
popd
