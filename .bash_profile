#export SHELL=`which bash`
source $HOME/.commonrc
source $HOME/.commonalias

# bashrc
which zsh 1>/dev/null 2>&1 || source $HOME/.bashrc

# change zsh and exit is server exit
#([ -n "$SSH_TTY" ] && which zsh 1>/dev/null 2>&1 && exec zsh -l) && exit
