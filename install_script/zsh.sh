#!/bin/bash

umask 022

mkdir -p $HOME/local/src/
mkdir -p $HOME/local/bin/

cd ~/local/src/
curl -k -L -O http://downloads.sourceforge.net/project/zsh/zsh/5.0.5/zsh-5.0.5.tar.gz
tar xvfz zsh-5.0.5.tar.gz
cd zsh-5.0.5

./configure \
--enable-multibyte \
--prefix=$HOME/local

make && make install
