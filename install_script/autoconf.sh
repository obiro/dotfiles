#!/bin/bash

umask 022

mkdir -p ~/local/src/

cd ~/local/src/

curl -k -L -O http://ftp.gnu.org/gnu/m4/m4-1.4.16.tar.gz
tar xvfz m4-1.4.16.tar.gz
cd m4-1.4.16/
./configure  --prefix=$HOME/local
make && make install


cd ~/local/src/
curl -k -L -O http://ftp.gnu.org/gnu/autoconf/autoconf-latest.tar.gz
tar xvfz autoconf-latest.tar.gz
cd autoconf-2.69/
./configure  --prefix=$HOME/local
make && make install

