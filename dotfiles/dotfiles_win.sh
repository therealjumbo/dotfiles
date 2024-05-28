#!/bin/bash
set -eu

this_script_dir="$(dirname "$(readlink -e "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}" )" )"

if [ "$OS" != "Windows_NT" ]; then
    echo "This script only works on Windows. Exiting."
    exit 1
fi

dploy stow "${this_script_dir}/dploy" "$HOME"

[ -f "$HOME/.gitconfig" ] && \
    mv "$HOME/.gitconfig" "$HOME/.gitconfig.old"
dploy stow "${this_script_dir}/git" "$HOME"

dploy stow "${this_script_dir}/nvim/.config" "$LOCALAPPDATA"

mkdir -p "$HOME/.ssh"
[ -f "$HOME/.ssh/config" ] && \
    mv "$HOME/.ssh/config" "$HOME/.ssh/config.old"
dploy stow "${this_script_dir}/ssh" "$HOME/.ssh"
# ~/.ssh/config includes the ~/.ssh/site_config file, so create it if it DNE,
# but we don't want to commit this file to the repo (site specific mods)
[ ! -f "$HOME/.ssh/site_config" ] && touch "$HOME/.ssh/site_config"

[ -f "$HOME/.profile" ] && \
    mv "$HOME/.profile" "$HOME/.profile.old"
dploy stow "${this_script_dir}/profile" "$HOME"

# we don't want stow to symlink anything besides the chrome subdir right now so
# create the directory above it first
mkdir -p "$HOME/.mozilla/firefox/profile.default"
dploy stow "${this_script_dir}/firefox" "$HOME"
