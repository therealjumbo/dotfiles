#!/bin/bash
set -eu

this_script_dir="$(dirname "$(readlink -e "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}" )" )"

if [ $OS != "Windows_NT"]; then
  # symlink user made scripts to /usr/local/bin so they are available on the PATH
  sudo stow --dir="${this_script_dir}" --target=/usr/local/bin bin
fi
