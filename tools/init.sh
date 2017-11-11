# Sane default for Home Sweet Home root
if [ ! -n "$HOME_SWEET_HOME" ]; then
    export HOME_SWEET_HOME=~/.home-sweet-home
fi

# Set up PATH
export PATH="${HOME_SWEET_HOME}/bin":$PATH
