#!/bin/bash
set -e

this_script_dir="$(dirname "$(readlink -e "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}" )" )"

stow --target="$HOME" "${this_script_dir}/stow"

stow --target="$HOME" "${this_script_dir}/ack"

[ -f "$HOME/.gitconfig" ] && \
mv "$HOME/.gitconfig" "$HOME/.gitconfig.old"
stow --target="$HOME" "${this_script_dir}/git"

stow --target="$HOME" "${this_script_dir}/nvim"

stow --target="$HOME" "${this_script_dir}/tmux"

stow --target="$HOME" "${this_script_dir}/vim"

[ -f "$HOME/.zshrc" ] && \
mv "$HOME/.zshrc" "$HOME/.zshrc.old"
stow --target="$HOME" "${this_script_dir}/zsh"

stow --target="$HOME/.ssh/" "${this_script_dir}/ssh"

[ -f "$HOME/.profile" ] && \
mv "$HOME/.profile" "$HOME/.profile.old"
stow --target="$HOME" "${this_script_dir}/profile"

stow --target="$HOME" "${this_script_dir}/pyenv"
