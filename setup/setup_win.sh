#!/bin/bash
set -eu

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

# create tmp dirs for nvim for user
mkdir -p "$HOME/.vimtmp/tmp/backupdir"
mkdir -p "$HOME/.vimtmp/tmp/swapdir"
mkdir -p "$HOME/.vimtmp/tmp/undodir"
