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

# Add to PATH
if [ -d "/usr/local/go/bin" ]; then
    export PATH="/usr/local/go/bin:$PATH"
fi
if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
fi
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi
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

alias vi="nvim"
alias ct=$'ctags -R --exclude=\".git\" --exclude=@.ctagsignore -L .srclist'
alias cs='xclip -selection clipboard'
alias vs='xclip -o -selection clipboard'
alias dirs='dirs -v'
alias psc='ps xawf -eo pid,user,cgroup,args'
alias info='info --vi-keys'
alias dr='docker'
export WORKSPACE="$HOME/proj"
alias ws='cd $WORKSPACE && ls'
alias his='fc -li 1'
alias gdb-batch="gdb --batch --ex run --ex bt --ex q --args"
alias r='cd $(git rev-parse --show-toplevel)'
alias fzv='fzf | xargs nvim'

# history specific options
setopt hist_allow_clobber
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt extended_history
setopt inc_append_history

HISTSIZE=500000
SAVEHIST=500000

# search and navigate history with up/down arrow
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search # Up
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search # Down

if [ -d "$HOME/.zshrc.d" ]; then
  for filename in $HOME/.zshrc.d/*; do
    source "$filename"
  done
fi

# go stuff
export GOPATH="$HOME/proj/go"
export PATH=$PATH:$(go env GOPATH)/bin

# load zsh completion for docker-compose
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i
# load zsh completion for rust
fpath+=~/.zfunc

# allow zsh tab completion for `docker exec` see:
# https://github.com/moby/moby/commit/402caa94d23ea3ad47f814fc1414a93c5c8e7e58
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

export EDITOR='nvim'
# decrease vi-mode switch time from 0.4 sec to 0.1 sec
export KEYTIMEOUT=1

[ -f ~/.ssh/id_rsa2 ] && \
  eval "$(keychain --eval id_rsa)"
[ -f ~/.ssh/id_rsa2 ] && \
  eval "$(keychain --eval id_rsa2)"

if command -v pyenv 1> /dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if command -v pyenv virtualenv-init - 1> /dev/null 2>&1; then
  eval "$(pyenv virtualenv-init -)"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --hidden"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
