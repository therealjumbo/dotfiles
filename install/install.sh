#!/bin/bash
set -e

this_script_dir="$(dirname "$(readlink -e "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}" )" )"

if [ "$NATIVE_LINUX" = "true" ]; then
    packages=(\
        avahi-utils \
        docker-compose \
        docker.io \
        fd-find \
        fzf \
        keepassxc \
        tshark \
        wireshark
        )
fi

# bring the system up to date
sudo apt-get -y update
sudo apt-get -y upgrade

# install all apt packages
sudo apt-get -y install \
    "${packages[@]}" \
    artha \
    automake \
    build-essential \
    ca-certificates \
    clang \
    clang-format \
    clang-tidy \
    clang-tools \
    cmake \
    colordiff \
    cpanminus \
    cscope \
    curl \
    dconf-cli \
    dnsutils \
    dos2unix \
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
    git-gui \
    gnupg2 \
    graphviz \
    htop \
    iftop \
    info \
    iotop \
    jq \
    jsonlint \
    keychain \
    libbz2-dev \
    libffi-dev \
    libgpgme11 \
    libgpgme11-dev \
    liblzma-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
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
    net-tools \
    nethogs \
    openssh-server \
    pciutils \
    perl \
    rclone \
    ripgrep \
    rr \
    screen \
    shellcheck \
    sloccount \
    software-properties-common \
    splint \
    sshfs \
    stow \
    sysstat \
    tk-dev \
    tldr \
    tmux \
    tree \
    unattended-upgrades \
    valgrind \
    vim \
    wget \
    xclip \
    xz-utils \
    zlib1g-dev \
    zsh

# use unattended-upgrades (i.e. automatic security updates) --priority medium
# suppresses the interactive question
sudo dpkg-reconfigure unattended-upgrades --priority medium

# create this user's local bin
mkdir -p "$HOME/.local/bin"

# add several of the git contrib scripts to /usr/local/bin
# This doesn't exist on the windows distribution of git, but since we have
# rerere enabled by default it shouldn't be too big of a deal
sudo chmod +x /usr/share/doc/git/contrib/rerere-train.sh
sudo ln -sf /usr/share/doc/git/contrib/rerere-train.sh /usr/local/bin/rerere-train

# also not available on windows :(
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

py3_version=3.12.3
if ! grep -qF "$py3_version" <(pyenv versions); then
    pyenv install "$py3_version"
fi

if ! [ -e "$HOME/.cargo/bin" ]; then
    (tempdir=$(mktemp -d)
    cd "$tempdir"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustinstall.sh
    chmod +x ./rustinstall.sh
    ./rustinstall.sh -y
    cd "$tempdir/.."
    rm -rf "$tempdir"
    )
else
    "$HOME/.cargo/bin/rustup" update
fi

# Install vim-plug
if ! [ -e "$HOME/.local/share/nvim/site/autoload/plug.vim" ]; then
    curl -sfLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# install and update all nvim plugins
nvim -Es -u "${this_script_dir}/../dotfiles/nvim/.config/nvim/init.vim" +PlugInstall +qall
nvim -Es -u "${this_script_dir}/../dotfiles/nvim/.config/nvim/init.vim" +PlugUpdate +qall

# install oh-my-zsh
if ! [ -e "$HOME/.oh-my-zsh" ]; then
    curl -sL https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash
fi
