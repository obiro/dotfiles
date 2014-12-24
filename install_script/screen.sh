#!/bin/bash

umask 022

mkdir -p ~/local/src/

# need autoconf-2.69

cd ~/local/src/
git clone git://git.savannah.gnu.org/screen.git
cd screen/src/
$HOME/local/autoconf-2.69/bin/autoheader
$HOME/local/autoconf-2.69/bin/autoconf
./configure --enable-colors256 --prefix=$HOME/local/screen-4.1
make && make install
