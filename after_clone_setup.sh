#!/bin/bash

if [ ! -d "${HOME}/.vim/bundle/neobundle.vim" ]; then
  git clone https://github.com/Shougo/neobundle.vim.git ${HOME}/.vim/bundle/neobundle.vim
fi

vim -c "NeoBundleInstall!"

tee ${HOME}/.vim/bundle/vimproc/.git/hooks/post-merge <<'EOS' >/dev/null 2>&1
#!/bin/sh --
set -e

echo ""
echo "START POST-MERGE HOOK"
echo ""

HOOK_DIR=`dirname $0`              #git_hooks directory
PROC_DIR=$HOME/.vim/bundle/vimproc #vimproc directory

case `uname -s` in
	Darwin)
		MAKE_FILE="make_mac.mak"
		PROC_FILE="proc.so"
		;;
	Linux)
		MAKE_FILE="make_unix.mak"
		PROC_FILE="proc.so"
		;;
	FreeBSD)
		MAKE_FILE="make_unix.mak"
		PROC_FILE="proc.so"
		;;
	CYGWIN*)
		MAKE_FILE="make_cygwin.mak"
		PROC_FILE="proc_cygwin.dll"
		;;
	*)
		echo "This type of OS is not supported"
		exit 1
		;;
esac


cd $PROC_DIR

if [ -f autoload/$PROC_FILE ]; then
	echo "deleting previous $PROC_FILE ..."
	rm autoload/$PROC_FILE
	echo "done"
	echo ""
fi

echo "compiling $PROC_FILE ..."
make -f $MAKE_FILE
echo "done"
echo ""

echo "vimproc: build success!"
echo ""

echo "END POST-MERGE HOOK"
EOS

chmod 755 ${HOME}/.vim/bundle/vimproc/.git/hooks/post-merge

sh ${HOME}/.vim/bundle/vimproc/.git/hooks/post-merge

vim -c "NeoBundleList"
