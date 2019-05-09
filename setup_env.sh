# copy the vimrc and tmux.conf files to the home directory
cp .vimrc ~/.vimrc
cp .tmux.conf ~/.tmux.conf

# install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install bundles using vundle with vim
vim +PluginInstall +qall
