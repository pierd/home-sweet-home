# bash skips .profile when this file exists
if [[ -f ~/.profile ]]; then
    source ~/.profile
fi
if [[ -f ~/.bashrc ]]; then
    source ~/.bashrc
fi
