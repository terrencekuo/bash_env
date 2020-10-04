#!/bin/bash
#
# NOTE: this script assumes that the user already has vim and tmux
#
# copy the vimrc and tmux.conf files to the home directory
cp .vimrc ~/.vimrc
cp .tmux.conf ~/.tmux.conf

# use vim-plug as the plugin manager
# https://github.com/junegunn/vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install vim plugins via the command line
vim -E -s -u "~/.vimrc" +PlugInstall +qall
vim +PluginInstall +qall

# install tmux plugins via the command line
~/.tmux/plugins/tpm/scripts/install_plugins.sh
