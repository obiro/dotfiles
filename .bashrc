export SHELL=`which bash`

dev_servers=("ubuntu" "oshiete-02-dev-web-001")

dev=0
for dev_server in ${dev_servers[@]}; do
if [ "${HOSTNAME}" == "${dev_server}" ]; then
  dev=1
  break
fi
done




if [ -d $HOME/local/etc/profile.d ]; then
  # git-prompt.sh configuration
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWSTASHSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWUPSTREAM="auto git"
  GIT_PS1_DESCRIBE_STYLE="branch"
  GIT_PS1_SHOWCOLORHINTS=1

  . $HOME/local/etc/profile.d/bash_completion.sh
  . $HOME/local/etc/profile.d/git-prompt.sh
  . $HOME/local/etc/profile.d/git-completion.bash

  #export PROMPT_COMMAND='__git_ps1 "\[\033[1;31m\]\u@\h\[\e[00m\] \[\e[1;34m\]\w\[\e[00m\]" " \$ "'
  export PROMPT_COMMAND='__git_ps1 "\[\033[1;36m\]\u@\h\[\e[00m\] \[\e[1;34m\]\w\[\e[00m\]" " \$ "'
fi
#export PS1='\[\e[01;31m\]\u@\h\[\e[00m\] \[\e[01;34m\]\w\[\e[00m\] \$ '
export PS1='\[\e[01;36m\]\u@\h\[\e[00m\] \[\e[01;34m\]\w\[\e[00m\] \$ '

# PROMPT_COMMAND
# example:
#   export PROMPT_COMMAND='__git_ps1 "\u@\h:\w" " \$ "'
#
# user: \u
# host: \h
# dir:  \w
#
# color
# red:    \[\033[1;31m\]
# blue:   \[\033[1;36m\]
# kaizyo: \[\e[00m\]


#if [ ${dev} -eq 1 ]; then
#  export PROMPT_COMMAND='__git_ps1 "\[\033[1;36m\]\u@\h\[\e[00m\] \[\e[1;34m\]\w\[\e[00m\]" " \$ "'
#  export PS1='\[\e[01;36m\]\u@\h\[\e[00m\] \[\e[01;34m\]\w\[\e[00m\] \$ '
#fi

