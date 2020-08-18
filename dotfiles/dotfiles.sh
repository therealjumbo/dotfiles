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

mv "$HOME/.ssh/config" "$HOME/.ssh/config.old"
stow --dir="${this_script_dir}" --target="$HOME/.ssh/" ssh
# ~/.ssh/config includes the ~/.ssh/site_config file, so create it if it DNE,
# but we don't want to commit this file to the repo (site specific mods)
[ ! -f "$HOME/.ssh/site_config" ] && touch "$HOME/.ssh/site_config"

[ -f "$HOME/.profile" ] && \
mv "$HOME/.profile" "$HOME/.profile.old"
stow --dir="${this_script_dir}" --target="$HOME" profile

stow --dir="${this_script_dir}" --target="$HOME" pyenv

if [ "$NATIVE_LINUX" = "true" ]; then
  # we don't want stow to symlink anything besides the chrome subdir right now so
  # create the directory above it first
  mkdir -p "$HOME/.mozilla/firefox/profile.default"
  stow --dir="${this_script_dir}" --target="$HOME" firefox
fi
