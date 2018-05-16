# Sane default for Home Sweet Home root
if [ ! -n "$HOME_SWEET_HOME" ]; then
    export HOME_SWEET_HOME=~/.home-sweet-home
fi

# Set up aliases
alias home="git --work-tree=$HOME --git-dir=${HOME_SWEET_HOME}/.git"
