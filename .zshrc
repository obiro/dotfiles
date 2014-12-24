#export SHELL=`which zsh`


###############################################################################
# general
###############################################################################

bindkey -e
#bindkey -r '^?' # backspace無効

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

#oh-my-zsh   https://github.com/robbyrussell/oh-my-zsh/wiki/themes
#auto-fu

# emacs キーバインド
#http://mba-hack.blogspot.jp/2013/03/zsh.html
#http://news.mynavi.jp/column/zsh/004/index.html
#http://qiita.com/takc923/items/08792b7188b5c11e0f21

# vi キーバインド
#http://d.hatena.ne.jp/teramako/20080122/p2
#http://memo.officebrook.net/20100131.html

# faq
#http://wiki.fdiary.net/zsh/?FAQ%40zsh%A5%B9%A5%EC



setopt IGNORE_EOF # ^dの押しすぎでlogoutしないように
setopt no_beep           # ビープ音を鳴らさないようにする
setopt auto_cd           # ディレクトリ名の入力のみで移動する 
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
setopt equals            # =commandを`which command`と同じ処理にする

###############################################################################
# glob
###############################################################################

setopt extended_glob # グロブ機能を拡張する
unsetopt caseglob    # ファイルグロブで大文字小文字を区別しない


###############################################################################
# prompt
###############################################################################

# $fg[red]のように色を設定できるようにする
autoload -U colors; colors

local RESET="%{$reset_color%}"
#local BLUE="%{${fg[blue]}%}"
local LIGHT_BLUE=$'%{\e[1;36m%}'
local DARK_BLUE=$'%{\e[1;34m%}'

# プロンプトでエスケープシーケンスを展開する
setopt prompt_subst
setopt transient_rprompt
setopt prompt_percent

autoload -Uz add-zsh-hook
if [ -d $HOME/local/etc/profile.d ]; then
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM=true
  #GIT_PS1_DESCRIBE_STYLE=true
  GIT_PS1_SHOWCOLORHINTS=true

  export GIT_PROMPT=$HOME/local/etc/profile.d/git-prompt.sh
  . $GIT_PROMPT

  precmd_1 () {
    # git status is argument 3
    __git_ps1 "${LIGHT_BLUE}%n@%m ${DARK_BLUE}%~${RESET}" " %(!.#.$) " " (%s)"
  }

  add-zsh-hook precmd precmd_1
fi

PROMPT="${LIGHT_BLUE}%n@%m ${DARK_BLUE}%~ ${RESET}%(!.#.$) "
#RPROMPT="[%{[33m%}%~%{[m%}]"
#SPROMPT="%B%{^[[33m%}%r is correct? [n,y,a,e]:%{^[[m%}%b "





###############################################################################
# completion
###############################################################################

if [ -f $HOME/local/etc/profile.d/git-completion.zsh ]; then
  fpath=($HOME/local/etc/profile.d/git-completion.zsh $fpath)
fi

if [ -d $HOME/local/etc/profile.d/zsh-completions ]; then
  fpath=($HOME/local/etc/profile.d/zsh-completions $fpath)
fi



# clear .zcompdump is "rm -f $HOME/.zcompdump"
autoload -U compinit; compinit # 補完機能を有効にし、compファイルを作成
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}' # 補完時に大文字小文字を区別しない
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


###############################################################################
# history
###############################################################################

HISTFILE=$HOME/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=10000            # メモリに保存されるヒストリの件数
SAVEHIST=10000            # 保存されるヒストリの件数
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# すべてのヒストリを表示する
function history-all { history -E 1 }


show_buffer_stack() {
  POSTDISPLAY="
stack: $LBUFFER"
  zle push-line
}
zle -N show_buffer_stack
bindkey "^[q" show_buffer_stack

zshaddhistory() {
  local line=${1%%$'\n'}
  local cmd=${line%% *}
  [[ ${cmd} != (l|l[sl]) &&
     ${cmd} != (cd) &&
     ${cmd} != (mv) &&
     ${cmd} != (rm) &&
     ${cmd} != (history) &&
     ${cmd} != (exit)
  ]]
}


zle_highlight=(isearch:bold,fg=red region:bold,fg=yellow)
