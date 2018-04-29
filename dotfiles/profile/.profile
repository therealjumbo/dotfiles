# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	# shellcheck source=/dev/null
	. "$HOME/.bashrc"
    fi
fi

# load this user's site modifications
if [ -d ~/.profile.d ]; then
    for filename in ~/.profile.d/*.sh; do
	if [ -r "$filename" ]; then
	    # shellcheck source=/dev/null
	    source "$filename"
	fi
    done
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

keychain id_rsa
[ -z "$HOSTNAME" ] && HOSTNAME=$(uname -n)

# shellcheck source=/dev/null
[ -f "$HOME/.keychain/$HOSTNAME-sh" ] && \
. "$HOME/.keychain/$HOSTNAME-sh"

# shellcheck source=/dev/null
[ -f "$HOME/.keychain/$HOSTNAME-sh-gpg" ] && \
. "$HOME/.keychain/$HOSTNAME-sh-gpg"
