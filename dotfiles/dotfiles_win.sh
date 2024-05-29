#!/bin/bash
set -eu

this_script_dir="$(dirname "$(readlink -e "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}" )" )"

if [ "$OS" != "Windows_NT" ]; then
    echo "This script only works on Windows. Exiting."
    exit 1
fi

dploy stow "${this_script_dir}/dploy" "$USERPROFILE"

[ -f "$USERPROFILE/.gitconfig" ] && \
    mv "$USERPROFILE/.gitconfig" "$USERPROFILE/.gitconfig.old"
dploy stow "${this_script_dir}/git" "$USERPROFILE"

dploy stow "${this_script_dir}/nvim/.config" "$LOCALAPPDATA"

mkdir -p "$USERPROFILE/.ssh"
[ -f "$USERPROFILE/.ssh/config" ] && \
    mv "$USERPROFILE/.ssh/config" "$USERPROFILE/.ssh/config.old"
dploy stow "${this_script_dir}/ssh" "$USERPROFILE/.ssh"
# ~/.ssh/config includes the ~/.ssh/site_config file, so create it if it DNE,
# but we don't want to commit this file to the repo (site specific mods)
[ ! -f "$USERPROFILE/.ssh/site_config" ] && touch "$USERPROFILE/.ssh/site_config"

[ -f "$USERPROFILE/.bash_profile" ] && \
    mv "$USERPROFILE/.bash_profile" "$USERPROFILE/.bash_profile.old"
dploy stow "${this_script_dir}/bash" "$USERPROFILE"

# we don't want stow to symlink anything besides the chrome subdir right now so
# create the directory above it first
mkdir -p "$USERPROFILE/.mozilla/firefox/profile.default"
dploy stow "${this_script_dir}/firefox" "$USERPROFILE"
