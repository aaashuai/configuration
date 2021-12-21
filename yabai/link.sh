#!/bin/bash

# link config files to $HOME

pwd=`pwd`
if [ ! -d "~/.config/spacebar" ]; then
    mkdir ~/.config/spacebar
fi
ln -sf ${pwd}/spacebarrc ~/.config/spacebar/spacebarrc
ln -sf ${pwd}/yabairc ~/.yabairc
ln -sf ${pwd}/skhdrc ~/.skhdrc
