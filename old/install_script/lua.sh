#!/bin/bash

umask 022

mkdir -p ~/local/src/

cd ~/local/src/
curl -k -L -O http://www.lua.org/ftp/lua-5.2.3.tar.gz

tar xvfz lua-5.2.3.tar.gz
cd lua-5.2.3/

make linux
#make test
make install INSTALL_TOP=$HOME/local
