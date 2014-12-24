#!/bin/bash

# yum install install build-essential libevent-devel libncurses5-devel

umask 022

mkdir -p ~/local/src/

cd ~/local/src/
curl -k -L -O
http://downloads.sourceforge.net/project/tmux/tmux/tmux-1.6/tmux-1.6.tar.gz
tar xzvf tmux-1.6.tar.gz

cd tmux-1.6
./configure \
--prefix=$HOME/local

make && make install
