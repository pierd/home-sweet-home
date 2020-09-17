prompt_status() {
    local symbols
    symbols=()
    [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
    [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"
    symbols+="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})➜ "
    echo -n "$symbols"
}
PROMPT='$(prompt_status) %{$fg[blue]%}%~ $(virtualenv_prompt_info)$(git_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}±"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_VIRTUALENV_PREFIX="🐍 %{$fg_bold[cyan]%}"
ZSH_THEME_VIRTUALENV_SUFFIX="%{$reset_color%} "

# LS colors, made with http://geoff.greer.fm/lscolors/
export LSCOLORS='ExFxCxDxBxEGEDABAGACAD'
export LS_COLORS='di=1;34:ln=1;35:so=1;32:pi=1;33:ex=1;31:bd=1;34;1;46:cd=1;34;1;43:su=1;30;1;41:sg=1;30;1;46:tw=1;30;1;42:ow=1;30;1;43'
