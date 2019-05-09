# NOTES: install tmux and vim for Ubuntu

# update the ubuntu system
sudo apt-get update

# install latest version of vim
sudo apt-get install vim

# install tmux
# 1. download the tmux repo into /tmp/tmux
# 2. go to the /tmp/tmux directory
# 3. checkout the correct version. look at NOTE for more info
# 4. download tmux
# 5. download tmux
# 6. go back to last dir
# 7. clean up
#
# NOTE: checkout the tmux version that you want.
# tmux does not use branches, therefore instead of
# of the origin/ prefix, use the tags/ prefix.
# in this case we are using version 2.8
git clone https://github.com/tmux/tmux.git /tmp/tmux
cd /tmp/tmux
git checkout tags/2.8
sh autogen.sh
./configure && make
sudo make install
cd -
rm -fr /tmp/tmux

# install tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
