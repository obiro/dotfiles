#!/bin/bash

umask 022

mkdir -p ~/local/src/
mkdir -p ~/local/bin/

cd ~/local/src/
curl -k -L -O http://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
curl -k -L -O http://ftp.jp.vim.org/pub/vim/extra/vim-7.2-extra.tar.gz
curl -k -L -O http://ftp.vim.org/pub/vim/extra/vim-7.2-lang.tar.gz
tar jxvf vim-7.4.tar.bz2
tar zxvf vim-7.2-extra.tar.gz
tar zxvf vim-7.2-lang.tar.gz
mv vim72/ vim74/

cd vim74/
mkdir patches/

cd patches/
wget http://ftp.vim.org/pub/vim/patches/7.4/7.4.{001..404}

cd ../
cat patches/7.4.* | patch -p0

cd src/
./configure \
--with-features=huge \
--enable-multibyte \
--enable-xim \
--enable-fontset \
--enable-cscope \
--enable-luainterp=yes \
--with-lua-prefix=$HOME/local \
--disable-gui \
--disable-selinux \
--enable-fail-if-missing \
--prefix=$HOME/local

make && make install
