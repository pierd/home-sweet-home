setopt notify
setopt extended_glob
setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
setopt interactive_comments
setopt long_list_jobs
unsetopt flow_control
unsetopt beep
autoload zmv

# History
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history

# Key bindings
bindkey -v
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char
bindkey '^W' backward-kill-word
bindkey '^[[3~' delete-char
bindkey '^[OH' beginning-of-line
bindkey '^[[H' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[Z' reverse-menu-complete
bindkey '^R' history-incremental-search-backward
bindkey '^[[A' up-line-or-history
bindkey '^[OA' up-line-or-history
bindkey '^[[B' down-line-or-history
bindkey '^[OB' down-line-or-history
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# LS colors, made with http://geoff.greer.fm/lscolors/
export LSCOLORS='ExFxCxDxBxEGEDABAGACAD'
export LS_COLORS='di=1;34:ln=1;35:so=1;32:pi=1;33:ex=1;31:bd=1;34;1;46:cd=1;34;1;43:su=1;30;1;41:sg=1;30;1;46:tw=1;30;1;42:ow=1;30;1;43'

# Completion
setopt complete_in_word
setopt always_to_end
zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' glob 1
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=long-list select=1
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

# Aliases
alias ls='ls -FG'
alias l='ls -lah'
alias grep='grep --color=auto'
alias unquarantine='sudo xattr -d -r com.apple.quarantine'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias algrep='alias | grep'
alias unssh='ssh -o UserKnownHostsFile=/dev/null -o CheckHostIP=no -o StrictHostKeyChecking=no'

# Aliases (global)
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# Git
if [[ -f ~/.git_aliases.sh ]]; then
    source ~/.git_aliases.sh
fi

# Terminal title: current dir at the prompt, the command while it runs
autoload -Uz add-zsh-hook
_title_precmd() { print -Pn '\e]0;%~\a' }
_title_preexec() { print -rn -- $'\e]0;'"${1//[[:cntrl:]]/}"$'\a' }
add-zsh-hook precmd _title_precmd
add-zsh-hook preexec _title_preexec

# Global envs
export EDITOR='vim'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
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
    export PATH="/opt/homebrew/sbin:/opt/homebrew/bin:$PATH"
    fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
fi
if [[ -f ~/.homebrew_github_api_token ]]; then
    export HOMEBREW_GITHUB_API_TOKEN="$(<~/.homebrew_github_api_token)"
fi

# Rust (cargo completions come from Homebrew, rustup's are generated once)
if [[ -d ~/.cargo/bin ]]; then
    export PATH=~/.cargo/bin:$PATH
fi
if which rustup > /dev/null && [[ ! -f ~/.zsh/func/_rustup ]]; then
    mkdir -p ~/.zsh/func
    rustup completions zsh > ~/.zsh/func/_rustup
fi

# Node (from nvm's installs; nvm itself is only loaded on first use, it's slow)
if [[ -s ~/.nvm/nvm.sh ]]; then
    export NVM_DIR=~/.nvm
    () {
        local alias_default=node
        [[ -f $NVM_DIR/alias/default ]] && alias_default="$(<$NVM_DIR/alias/default)"
        alias_default=${alias_default#v}
        local -a versions
        versions=($NVM_DIR/versions/node/v${alias_default}(N/))
        [[ $#versions -eq 0 ]] && versions=($NVM_DIR/versions/node/v${alias_default}.*(N/nOn))
        [[ $#versions -eq 0 ]] && versions=($NVM_DIR/versions/node/v*(N/nOn))
        if [[ $#versions -gt 0 ]]; then
            export PATH=$versions[1]/bin:$PATH
        fi
    }
    nvm() {
        unset -f nvm
        source $NVM_DIR/nvm.sh
        nvm "$@"
    }
fi

# additional function
if [[ -d ~/.zsh/func ]]; then
    fpath=(~/.zsh/func $fpath)
fi
typeset -U fpath

# Home Sweet Home
if [[ -d ~/.home-sweet-home ]]; then
    source ~/.home-sweet-home/init.sh
fi

# Put ~/bin in very front of the PATH
export PATH=~/bin:$PATH

# Amoxide
#if which am > /dev/null; then
#    eval "$(am init zsh)"
#fi

# Run once, after all fpath changes
autoload -U compinit
compinit

# smolvm
if which smolvm > /dev/null; then
    source <(smolvm completion zsh)
fi

# Prompt
if which starship > /dev/null; then
    eval "$(starship init zsh)"
fi

# very local overrides
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi
