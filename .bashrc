# Interactive shells only
[[ $- == *i* ]] || return

# Git
if [[ -f ~/.git_aliases.sh ]]; then
    source ~/.git_aliases.sh
fi

# very local overrides
if [[ -f ~/.bashrc.local ]]; then
    source ~/.bashrc.local
fi
