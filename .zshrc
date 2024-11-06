# when root compinit doesn't like functions added by Homebrew - remove them
if [[ $UID -eq 0 ]]; then
    fpath=("${(@)fpath:#/usr/local/share/zsh/site-functions}")
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="pierd"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git rust virtualenv)

source $ZSH/oh-my-zsh.sh

######################
# User configuration #
######################

setopt notify
setopt extended_glob
setopt autocd
unsetopt beep
autoload zmv

# Key bindings
bindkey -v
bindkey '^[[3~' delete-char
bindkey '^[OH' beginning-of-line
bindkey '^[[H' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^R' history-incremental-search-backward
bindkey '^[[A' up-line-or-history
bindkey '^[OA' up-line-or-history
bindkey '^[[B' down-line-or-history
bindkey '^[OB' down-line-or-history
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# Completion
zstyle ':completion:*' glob 1
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=long-list select=1
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

# Aliases
alias ls='ls -FG'
alias unquarantine='sudo xattr -d -r com.apple.quarantine'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias algrep='alias | grep'
alias unssh='ssh -o UserKnownHostsFile=/dev/null -o CheckHostIP=no -o StrictHostKeyChecking=no'

# Aliases (global)
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# additional function
if [[ -d ~/.zsh/func ]]; then
    fpath=(~/.zsh/func $fpath)
    typeset -U fpath
fi

# Global envs
export EDITOR='vim'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# local sbin for Homebrew
if [[ -d /usr/local/sbin ]]; then
    export PATH=/usr/local/sbin:$PATH
fi

# Google Cloud SDK
if [[ -d ~/google-cloud-sdk ]]; then
    source ~/google-cloud-sdk/path.zsh.inc
    #source ~/google-cloud-sdk/completion.zsh.inc
fi

# Java
if [[ -f /usr/libexec/java_home ]]; then
    use_java() {
        export JAVA_HOME=$(/usr/libexec/java_home $*)
        export PATH=$JAVA_HOME/bin:$PATH
    }
    use_java
fi

# Homebrew
if [[ -d /opt/homebrew/bin ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi
if [[ -f ~/.homebrew_github_api_token ]]; then
    export HOMEBREW_GITHUB_API_TOKEN="$(<~/.homebrew_github_api_token)"
fi

# Home Sweet Home
if [[ -d ~/.home-sweet-home ]]; then
    source ~/.home-sweet-home/init.sh
fi

# Put ~/bin in very front of the PATH
export PATH=~/bin:$PATH

# very local overrides
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi
