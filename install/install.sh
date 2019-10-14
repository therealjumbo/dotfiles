#!/bin/bash
set -e

# bring the system up to date
sudo apt-get -y update
sudo apt-get -y upgrade

# install packages to allow apt to use a repository over HTTPS
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

# c dev tools
sudo apt-get -y install gcc gdb make automake cmake valgrind rr
sudo apt-get -y install llvm lldb clang clang-tools clang-format clang-tidy
sudo apt-get -y install flawfinder splint
sudo apt-get -y install sloccount

# various system tools
sudo apt-get -y install perl cpanminus vim git zsh tmux stow dconf-cli git-email htop neovim moreutils
sudo apt-get -y install libtool libtool-bin libcurl4-openssl-dev libssl-dev libgpgme11 libgpgme11-dev
sudo apt-get -y install lsscsi pciutils
sudo apt-get -y install sysstat iotop

# network tools
sudo apt-get -y install wget curl tshark wireshark lua5.1

# software engineering tools
sudo apt-get -y install umlet doxygen markdown

# debian packaging
sudo apt-get -y install dpkg dpkg-cross dpkg-dev dpkg-repack dpkg-sig

# stuff I picked up at work
sudo apt-get -y install graphviz tree exuberant-ctags colordiff jq
sudo apt-get -y install jsonlint shellcheck zshdb

# ubuntu 18.04 doesn't have bashdb in the repo anymore
if ! bashdb --version; then
    (tempdir=$(mktemp -d)
    cd "$tempdir"
    curl --silent -L https://sourceforge.net/projects/bashdb/files/bashdb/4.4-1.0.1/bashdb-4.4-1.0.1.tar.gz | tar -xz
    cd bashdb-4.4-1.0.1/
    ./configure --prefix=/usr/local
    make
    sudo make install
    cd "$tempdir/.."
    rm -rf "$tempdir"
    )
fi

if ! docker --version; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
           "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
           $(lsb_release -cs) \
           stable"
    sudo apt-get update
    sudo apt-get -y install docker-ce
    sudo systemctl start docker
    sudo systemctl enable docker
fi

# programs for user convenience
sudo apt-get -y install keychain xclip keepassxc

# setup automatic security only updates
sudo apt-get -y install unattended-upgrades
sudo dpkg-reconfigure unattended-upgrades --priority medium

# add several of the git contrib scripts to PATH
sudo chmod +x /usr/share/doc/git/contrib/rerere-train.sh
sudo ln -sf /usr/share/doc/git/contrib/rerere-train.sh /usr/local/bin/rerere-train
sudo chmod +x /usr/share/doc/git/contrib/diff-highlight/diff-highlight
sudo ln -sf /usr/share/doc/git/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight
sudo chmod +x /usr/share/doc/git/contrib/git-jump/git-jump
sudo ln -sf /usr/share/doc/git/contrib/git-jump/git-jump /usr/local/bin/git-jump

# install pyenv from github
if [ ! -d "$HOME/.pyenv" ]; then
    git clone https://github.com/pyenv/pyenv.git "$HOME/.pyenv"
fi

if [ ! -d "$HOME/.pyenv/plugins/pyenv-virtualenv" ]; then
    git clone https://github.com/pyenv/pyenv-virtualenv.git "$HOME/.pyenv/plugins/pyenv-virtualenv"
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

if ! grep -qF "2.7.16" <(pyenv versions); then
    pyenv install 2.7.16
fi

if ! grep -qF "3.7.4" <(pyenv versions); then
    pyenv install 3.7.4
fi

if ! grep -qF "neovim2" <(pyenv versions); then
    pyenv virtualenv 2.7.16 neovim2
    pyenv activate neovim2
    pip install neovim
    pyenv deactivate
fi

if ! grep -qF "neovim3" <(pyenv versions); then
    pyenv virtualenv 3.7.4 neovim3
    pyenv activate neovim3
    pip install neovim flake8 pynvim python-language-server polysquare-cmake-linter
    ln -sf "$(pyenv which flake8)" ~/bin/flake8
    ln -sf "$(pyenv which polysquare-cmake-linter)" ~/bin/polysquare-cmake-linter
    pyenv deactivate
fi

if ! go version; then
    # as per the documentation, previous versions of go should be removed before
    # the new one is installed
    sudo rm -rf /usr/local/go
    # install go
    curl -s https://dl.google.com/go/go1.13.1.linux-amd64.tar.gz \
        | sudo tar -C /usr/local -xz
    mkdir -p "$HOME/proj/go/src/github.com/therealjumbo"
fi

if ! rustc --version; then
    (tempdir=$(mktemp -d)
    cd "$tempdir"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustinstall.sh
    chmod +x ./rustinstall.sh
    ./rustinstall.sh -y
    cd "$tempdir/.."
    rm -rf "$tempdir"
    )
else
    rustup update
fi
