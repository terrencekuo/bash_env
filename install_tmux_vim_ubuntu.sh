# NOTES: install tmux and vim for Ubuntu
#
# update the ubuntu system
sudo apt-get update

# install latest version of vim
sudo apt-get install vim -y

# install tmux package dependencies
sudo apt-get install libevent-dev ncurses-dev build-essential bison pkg-config -y

# install tmux latest version of tmux
rm -fr /tmp/tmux
git clone https://github.com/tmux/tmux.git /tmp/tmux
cd /tmp/tmux
sh autogen.sh
./configure && make
sudo make install
cd -
rm -fr /tmp/tmux

# install tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
