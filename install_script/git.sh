#!/bin/bash

umask 022

mkdir -p ~/local/src/

cd ~/local/src/

# need autoconf 2.6.9

curl -k -L -O https://www.kernel.org/pub/software/scm/git/git-2.1.0.tar.gz
tar xvfz git-2.1.0.tar.gz

cd git-2.1.0/

make configure

if [ $(cat /etc/redhat-release | grep "Red Hat Linux release 9") != "" ]; then
  CPPFLAGS="-I/usr/kerberos/include" ./configure --prefix=${HOME}/local
else
  ./configure --prefix=${HOME}/local
fi

make && make install

