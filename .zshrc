# when root compinit doesn't like functions added by Homebrew - remove them
if [[ $UID -eq 0 ]]; then
    fpath=("${(@)fpath:#/usr/local/share/zsh/site-functions}")
fi

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="pierd"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

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
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  rust
  virtualenv
  virtualenvwrapper
  z
)

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
alias nt='nosetests -vv'
alias unquarantine='sudo xattr -d -r com.apple.quarantine'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias algrep='alias | grep'
alias unssh='ssh -o UserKnownHostsFile=/dev/null -o CheckHostIP=no -o StrictHostKeyChecking=no'

alias wrk='workon'
alias cdp='cdproject'
alias edit-wrk='mvim $VIRTUAL_ENV/bin/post{,de}activate'

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
export EDITOR='vim' # TODO: make it work for git and use mvim by default

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Google Cloud SDK
if [[ -d ~/google-cloud-sdk ]]; then
    source ~/google-cloud-sdk/path.zsh.inc
    #source ~/google-cloud-sdk/completion.zsh.inc
fi

# Java + Android Dev + Java GAE
use_java() {
    export JAVA_HOME=$(/usr/libexec/java_home $*)
    export PATH=$JAVA_HOME/bin:$PATH
}
use_java
if [[ -d ~/Library/Android/sdk ]]; then
    export ANDROID_HOME=~/Library/Android/sdk
    export ANDROID_SDK=$ANDROID_HOME
    export ANDROID_SDK_ROOT=$ANDROID_SDK
    export ANDROID_NDK=$ANDROID_SDK/ndk-bundle
    export ANDROID_NDK_HOME=$ANDROID_NDK
    export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_NDK:$PATH
    nuke_android_ndk() {
        export ANDROID_NDK=
        export ANDROID_NDK_HOME=
    }
fi
if [[ -d ~/appengine-java-sdk-1.9.38 ]]; then
    export APPENGINE_HOME=~/appengine-java-sdk-1.9.38
fi

# Homebrew
if [[ -f ~/.homebrew_github_api_token ]]; then
    export HOMEBREW_GITHUB_API_TOKEN="$(<~/.homebrew_github_api_token)"
fi

# Ruby
if [[ -d ~/.rvm ]]; then
    export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
fi

# Rust
if [[ -d ~/.cargo ]]; then
    source $HOME/.cargo/env
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
