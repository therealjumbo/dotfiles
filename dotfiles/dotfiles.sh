#!/bin/bash
set -e

this_script_dir="$(dirname "$(readlink -e "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}" )" )"

stow --dir="${this_script_dir}" --target="$HOME" stow

stow --dir="${this_script_dir}" --target="$HOME" ack

[ -f "$HOME/.gitconfig" ] && \
mv "$HOME/.gitconfig" "$HOME/.gitconfig.old"
stow --dir="${this_script_dir}" --target="$HOME" git

stow --dir="${this_script_dir}" --target="$HOME" nvim

stow --dir="${this_script_dir}" --target="$HOME" tmux

stow --dir="${this_script_dir}" --target="$HOME" vim

[ -f "$HOME/.zshrc" ] && \
mv "$HOME/.zshrc" "$HOME/.zshrc.old"
stow --dir="${this_script_dir}" --target="$HOME" zsh

stow --dir="${this_script_dir}" --target="$HOME/.ssh/" ssh

[ -f "$HOME/.profile" ] && \
mv "$HOME/.profile" "$HOME/.profile.old"
stow --dir="${this_script_dir}" --target="$HOME" profile

stow --dir="${this_script_dir}" --target="$HOME" pyenv
