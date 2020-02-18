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
  docker
  docker-compose
  git
  safe-paste
  vi-mode
)

# User configuration

# only allow unique entries in path
typeset -U path
# some programs or scripts add to PATH directly instead of path, so force that
# also to only have unique entries
typeset -U PATH
# /bin and /sbin are now symlinks to /usr/bin and /usr/sbin, respectively, so
# we don't need to add them to the path any longer
path+=(/usr/bin /usr/sbin)
test -d "/usr/local/go/bin" && path+="/usr/local/go/bin"
test -d "$HOME/.local/bin" && path+="$HOME/.local/bin"

# local dev additions to path
test -d "$HOME/.cargo/bin" && path+="$HOME/.cargo/bin"

test -d "$HOME/proj/go" && export GOPATH="$HOME/proj/go"
test -d "$GOPATH/bin" && path+="$GOPATH/bin"

test -d "$HOME/.pyenv" && export PYENV_ROOT="$HOME/.pyenv"
test -d "$PYENV_ROOT/bin" && path+="$PYENV_ROOT/bin"

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
alias fd="fdfind"
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

# history specific options
setopt extended_history
setopt hist_allow_clobber
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_save_no_dups
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

# load zsh completion for rust and for user
# load zsh completion for docker-compose, systemd etc.
fpath=(
  ~/.zfunc
  /usr/share/zsh/vendor-completions
  $fpath
  )
autoload -Uz compinit && compinit -i

# allow zsh tab completion for `docker exec` see:
# https://github.com/moby/moby/commit/402caa94d23ea3ad47f814fc1414a93c5c8e7e58
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

export EDITOR='nvim'
# decrease vi-mode switch time from 0.4 sec to 0.1 sec
export KEYTIMEOUT=1

[ -f ~/.ssh/id_rsa ] && \
  eval "$(keychain --eval id_rsa)"
[ -f ~/.ssh/id_rsa2 ] && \
  eval "$(keychain --eval id_rsa2)"

if command -v pyenv 1> /dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if command -v pyenv virtualenv-init - 1> /dev/null 2>&1; then
  eval "$(pyenv virtualenv-init -)"
fi

# This adds the fzf ctrl-t, ctrl-r, and alt-c keybindings
source /usr/share/doc/fzf/examples/key-bindings.zsh
export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --hidden --glob '!.git/'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fdfind --type d --no-ignore-vcs --hidden --exclude '.git'"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
