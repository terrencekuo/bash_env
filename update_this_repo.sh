#!/bin/bash
#
# this script is used to take the vimrc and tmux.conf files in the
# home directory and move it into this repo.
#
# essentially, use this script to update this repo with the most
# currect vimrc and tmux.conf
cp ~/.vimrc .vimrc
cp ~/.tmux.conf .tmux.conf
