#!/bin/bash
set -e

this_script_dir="$(dirname "$(readlink -e "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}" )" )"

# symlink user made scripts to /usr/local/bin so they are available on the PATH
sudo stow --target=/usr/local/bin "${this_script_dir}/bin"
