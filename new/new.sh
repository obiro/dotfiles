# 1. Install a package with repository for your system:
# On CentOS, install package centos-release-scl available in CentOS repository:
#sudo yum install -y centos-release-scl

# On RHEL, enable RHSCL repository for you system:
#sudo yum-config-manager --enable rhel-server-rhscl-7-rpms

# 2. Install the collection:
#sudo yum install -y devtoolset-6

cp ../.bashrc $HOME/.bashrc
cp ../new/.vimrc $HOME/.vimrc

mkdir -p $HOME/local/etc/profile.d


curl -k -L 'https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh' -o git-prompt.sh
curl -k -L 'https://raw.github.com/git/git/master/contrib/completion/git-completion.bash' -o git-completion.bash

mv git-prompt.sh  $HOME/local/etc/profile.d/git-prompt.sh
mv git-completion.bash  $HOME/local/etc/profile.d/git-completion.bash
#cp ../.gitconfig $HOME/.gitconfig

source $HOME/.bashrc

mkdir -p ~/.vim/bundle/
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim +PluginInstall +qall

# 3. Start using software collections:
#scl enable devtoolset-6 bash
