#!/bin/bash

umask 022

mkdir -p ~/local/src/

### bash-completion
cd ~/local/src/
curl -k -L -O http://bash-completion.alioth.debian.org/files/bash-completion-2.0.tar.gz
tar xvfz bash-completion-2.0.tar.gz
cd bash-completion-2.0

./configure \
--prefix=$HOME/local

make && make install


### zsh-completion
cd ~/local/src/
curl -k -L https://github.com/zsh-users/zsh-completions/tarball/master -o zsh-completions.tar.gz
tar xvfz zsh-completions.tar.gz
cp -rp zsh-users-zsh-completions*/src/ $HOME/local/etc/profile.d/zsh-completions/


### git-completion
cd $HOME/local/etc/profile.d/

curl -k -L 'https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh' -o git-prompt.sh
curl -k -L 'https://raw.github.com/git/git/master/contrib/completion/git-completion.bash' -o git-completion.bash
curl -k -L 'https://raw.github.com/git/git/master/contrib/completion/git-completion.zsh' -o git-completion.zsh

chmod +x git-prompt.sh
chmod +x git-completion.bash
chmod +x git-completion.zsh


### diff-highlight
cd $HOME/local/bin/
curl -k -L 'https://raw.github.com/git/git/master/contrib/diff-highlight/diff-highlight' -o diff-highlight
chmod +x diff-highlight

