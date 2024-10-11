#!/bin/bash
set -eu

this_script_dir="$(dirname "$(readlink -e "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}" )" )"

NATIVE_LINUX=false
WSL=false
if [ "$OS" = "Windows_NT" ]; then
    echo "This script does not work on Windows. Exiting."
    exit 1
elif grep -q Microsoft /proc/version; then
  WSL=true
else
  NATIVE_LINUX=true
fi

export WINDOWS_NT
export NATIVE_LINUX
export WSL

if [ "$NATIVE_LINUX" = "true" ] || [ "$WSL" = "true" ]; then
  # ask for password upfront
  sudo -v
  # keep-alive; update existing sudo time stamp if set, otherwise do nothing
  while true;
    do sudo -n true;
    sleep 60;
    kill -0 "$$" || exit;
  done 2>/dev/null &

  "${this_script_dir}/install/install.sh" || exit 1
  "${this_script_dir}/setup/setup.sh" || exit 1
  "${this_script_dir}/dotfiles/dotfiles.sh" || exit 1
  "${this_script_dir}/usr/usr.sh" || exit 1

else
  echo "Unsupported OS. Exiting."
  exit 1
fi
