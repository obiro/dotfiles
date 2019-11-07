export SHELL=`which bash`

if [ -d $HOME/local/etc/profile.d ]; then
  # git-prompt.sh configuration
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWSTASHSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWUPSTREAM="auto git"
  GIT_PS1_DESCRIBE_STYLE="branch"
  GIT_PS1_SHOWCOLORHINTS=1

  . $HOME/local/etc/profile.d/git-prompt.sh
  . $HOME/local/etc/profile.d/git-completion.bash

  export PROMPT_COMMAND='__git_ps1 "\[\033[1;36m\]\u@\h\[\e[00m\] \[\e[1;34m\]\w\[\e[00m\]" " \$ "'
fi
export PS1='\[\e[01;36m\]\u@\h\[\e[00m\] \[\e[01;34m\]\w\[\e[00m\] \$ '
