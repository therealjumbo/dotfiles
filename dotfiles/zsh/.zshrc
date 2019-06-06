# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  vi-mode
  docker
  docker-compose
)

# User configuration

export PATH="/home/jeff/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias nv="nvim"
alias vi="nvim"
alias ct=$'ctags -R --exclude=\".git\" --exclude=@.ctagsignore -L .srclist'
alias c='xclip'
alias v='xclip -o'
alias cs='xclip -selection clipboard'
alias vs='xclip -o -selection clipboard'
alias dirs='dirs -v'
alias psc='ps xawf -eo pid,user,cgroup,args'
alias info='info --vi-keys'
alias dr='docker'
alias g='git'
export WORKSPACE="$HOME/proj"
alias ws='cd $WORKSPACE && ls'
alias h='fc -li 1'
alias gdb-batch="gdb --batch --ex run --ex bt --ex q --args"
alias r='cd $(git rev-parse --show-toplevel)'

# go path
export GOPATH=~/proj/go

# history specific options
setopt hist_allow_clobber
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt extended_history
setopt inc_append_history

unsetopt pushdignoredups
unsetopt autopushd

HISTSIZE=500000
SAVEHIST=500000

if [ -d "$HOME/.zshrc.d" ]; then
  for filename in $HOME/.zshrc.d/*; do
    source "$filename"
  done
fi

# rust stuff
export PATH="$HOME/.cargo/bin:$PATH"
export RUST_SRC_PATH="$HOME/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"

# load zsh completion for docker-compose
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# decrease vi-mode switch time from 0.4 sec to 0.1 sec
export KEYTIMEOUT=1

[ -f ~/.ssh/id_rsa2 ] && \
  eval "$(keychain --eval id_rsa)"
[ -f ~/.ssh/id_rsa2 ] && \
  eval "$(keychain --eval id_rsa2)"
