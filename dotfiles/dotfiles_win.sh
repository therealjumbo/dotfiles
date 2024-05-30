#!/bin/bash
set -eu

this_script_dir="$(dirname "$(readlink -e "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}" )" )"

if [ "$OS" != "Windows_NT" ]; then
    echo "This script only works on Windows. Exiting."
    exit 1
fi

# https://www.msys2.org/docs/filesystem-paths/#automatic-unix-windows-path-conversion
home_test="$(cygpath -u $(readlink -e $HOME))"
profile_test="$(cygpath -u $(readlink -e $USERPROFILE))"
if [ "$home_test" != "$profile_test" ]; then
    echo "The env var: HOME is: '$HOME', the env var: USERPROFILE is: '$USERPROFILE'."
    echo "In order for git bash to work right, these must be the same."
    echo "Fix this by going to 'Edit the system environment variables' in the start menu."
    echo "Add a system-wide environment variable 'HOME' that is set to %USERPROFILE%".
    echo "Alternatively you could set a user specific environment variable 'HOME' set to %USERPROFILE%, or the path therein."
    echo "Then restart bash and try again. Exiting."
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

[ -f "$HOME/.bash_profile" ] && \
    mv "$HOME/.bash_profile" "$HOME/.bash_profile.old"
[ -f "$HOME/.bashrc" ] && \
    mv "$HOME/.bashrc" "$HOME/.bashrc.old"
dploy stow "${this_script_dir}/bash" "$HOME"

[ -f "$HOME/.inputrc" ] && \
    mv "$HOME/.inputrc" "$HOME/.inputrc.old"
dploy stow "${this_script_dir}/inputrc" "$HOME"

# we don't want stow to symlink anything besides the chrome subdir right now so
# create the directory above it first
mkdir -p "$HOME/.mozilla/firefox/profile.default"
dploy stow "${this_script_dir}/firefox" "$HOME"
