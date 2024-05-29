#!/bin/bash
set -eu

this_script_dir="$(dirname "$(readlink -e "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}" )" )"

WINDOWS_NT=false
NATIVE_LINUX=false
WSL=false
if [ "$OS" = "Windows_NT" ]; then
  WINDOWS_NT=true
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

elif [ "$WINDOWS_NT" = "true" ]; then
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

  "${this_script_dir}/install/install_win.sh" || exit 1
  "${this_script_dir}/setup/setup_win.sh" || exit 1
  "${this_script_dir}/dotfiles/dotfiles_win.sh" || exit 1
  "${this_script_dir}/usr/usr.sh" || exit 1

else
  echo "Unsupported OS. Exiting."
  exit 1
fi
