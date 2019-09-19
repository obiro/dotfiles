# 1. Install a package with repository for your system:
# On CentOS, install package centos-release-scl available in CentOS repository:
#sudo yum install -y centos-release-scl

# On RHEL, enable RHSCL repository for you system:
#sudo yum-config-manager --enable rhel-server-rhscl-7-rpms

# 2. Install the collection:
#sudo yum install -y devtoolset-6

cp ../../vim/bashrc_new $HOME/.bashrc
cp ../../vim/vimrc_new $HOME/.vimrc

mkdir -p $HOME/local/etc/profile.d
mkdir -p $HOME/local/lib/bazel/bin/
cp ../../vim/bash_completion.sh $HOME/local/etc/profile.d/bash_completion.sh
sudo cp ../../vim/bazel-complete.bash $HOME/local/lib/bazel/bin/bazel-complete.bash
cp ../../vim/git-prompt.sh $HOME/local/etc/profile.d/git-prompt.sh
cp ../../vim/gitconfig $HOME/.gitconfig

source $HOME/.bashrc

mkdir -p ~/.vim/bundle/
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim +PluginInstall +qall

# 3. Start using software collections:
#scl enable devtoolset-6 bash
