#!/bin/bash

umask 022

mkdir -p ~/local/bin/

cd ~/local/bin/

curl -k -L -O http://stedolan.github.io/jq/download/linux64/jq

chmod +x jq

