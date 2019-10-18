#!/bin/bash
set -e

this_script_dir="$(dirname "$(readlink -e "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}" )" )"

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
