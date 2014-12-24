#!/bin/bash

umask 022

mkdir -p $HOME/local/bin/

cd $HOME/local/bin/
curl -k -L -O https://drone.io/github.com/monochromegane/the_platinum_searcher/files/artifacts/bin/linun_amd64/pt
chmod +x ./pt
