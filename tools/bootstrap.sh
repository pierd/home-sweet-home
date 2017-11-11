#!/bin/bash

if [ ! -n "$HOME_SWEET_HOME" ]; then
    HOME_SWEET_HOME=~/.home-sweet-home
fi

git clone git@github.com:pierd/home-sweet-home.git $HOME_SWEET_HOME
