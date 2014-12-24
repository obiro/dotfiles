#!/bin/bash

dotfiles=`find $(pwd) -name ".*" ! -path "*.git*" ! -path "*.install*"`

for dotfile in ${dotfiles[@]}
do
  ln -Fis "${dotfile}" "${HOME}"
done

ln -Fis `find $(pwd) -name ".gitconfig"` "${HOME}"
