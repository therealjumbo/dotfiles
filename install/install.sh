#!/bin/bash
set -e

this_script_dir="$(dirname "$(readlink -e "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}" )" )"

# bring the system up to date
sudo apt-get -y update
sudo apt-get -y upgrade

# install all apt packages
sudo apt-get -y install \
    apt-transport-https \
    automake \
    ca-certificates \
    clang \
    clang-format \
    clang-tidy \
    clang-tools \
    cmake \
    colordiff \
    cpanminus \
    curl \
    dconf-cli \
    doxygen \
    dpkg \
    dpkg-cross \
    dpkg-dev \
    dpkg-repack \
    dpkg-sig \
    exuberant-ctags \
    flawfinder \
    gcc \
    gdb \
    git \
    git-email \
    gnupg2 \
    graphviz \
    htop \
    iotop \
    jq \
    jsonlint \
    keepassxc \
    keychain \
    libcurl4-openssl-dev \
    libgpgme11 \
    libgpgme11-dev \
    libssl-dev \
    libtool \
    libtool-bin \
    lldb \
    llvm \
    lsscsi \
    lua5.1 \
    make \
    markdown \
    moreutils \
    neovim \
    pciutils \
    perl \
    rr \
    shellcheck \
    sloccount \
    software-properties-common \
    splint \
    stow \
    sysstat \
    tmux \
    tree \
    tshark \
    umlet \
    unattended-upgrades \
    valgrind \
    vim \
    wget \
    wireshark \
    xclip \
    zsh \
    zshdb

# use unattended-upgrades (i.e. automatic security updates) --priority medium
# suppresses the interactive question
sudo dpkg-reconfigure unattended-upgrades --priority medium

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

if ! go version >/dev/null 2>&1; then
    # as per the documentation, previous versions of go should be removed before
    # the new one is installed
    sudo rm -rf /usr/local/go
    # install go
    curl -s https://dl.google.com/go/go1.13.1.linux-amd64.tar.gz \
        | sudo tar -C /usr/local -xz
    mkdir -p "$HOME/proj/go/src/github.com/therealjumbo"
fi

if ! rustc --version >/dev/null 2>&1; then
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
mkdir -p "$HOME/.zfunc"
rustup completions zsh > ~/.zfunc/_rustup

# TODO replace with apt in 20.04
# install ripgrep deb
if ! rg --version >/dev/null 2>&1; then
    (tempdir=$(mktemp -d)
    cd "$tempdir"
    curl -sLO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
    sudo dpkg --install ripgrep_11.0.2_amd64.deb
    cd "$tempdir/.."
    rm -rf "$tempdir"
    )
fi

# install all nvim plugins
nvim -Es -u "${this_script_dir}/../dotfiles/nvim/.config/nvim/init.vim" +PlugInstall +qall
nvim -Es -u "${this_script_dir}/../dotfiles/nvim/.config/nvim/init.vim" +PlugUpdate +qall
