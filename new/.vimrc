set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'wincent/command-t'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'

" python ハイライト
Plugin 'morhetz/gruvbox'
" ファイル種類によって自動comment out
Plugin 'scrooloose/nerdcommenter'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'https://github.com/Lokaltog/vim-powerline.git'

Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'

nmap <F9> :NERDTree<CR>
nmap <F10> :NERDTreeToggle<CR>

" let g:airline#extensions#tabline#show_splits = 0
" for vim-airline
" let g:airline#extensions#tabline#enabled = 1 " turn on buffer list
let g:airline_theme = 'molokai'
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'
set laststatus=2 " turn on bottom bar
"set rtp+=/home1/irteamsu/.local/lib/python3.6/site-packages/powerline/bindings/vim/
"set t_Co=256


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" for hightlight
"let python_highlight_all = 1
let g:airline_theme='gruvbox'
colorscheme gruvbox
set background=dark
"hi link pythonComment Operator
let g:gruvbox_italic=1
hi pythonComment ctermfg=2 gui=bold guifg=#408010

" インサートモード時にバックスペースを使う
set backspace=indent,eol,start

"開くとき最後のところで
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

" ファイル別intent
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.rb setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.sh setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.cpp setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=2
    autocmd BufNewFile,BufRead *.conf setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.yml setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=2
augroup END

""""" encode & line
"set termencoding=utf-8
"set encoding=utf-8
"set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp,default,latin,sjis,iso-8859-1
set ffs=unix,dos

" 不可視文字を可視化
set list
set listchars=tab:>-,nbsp:･,trail:･

" "全角スペースを　で表示
highlight JpSpace cterm=underline ctermfg=Yellow guifg=Yellow
au BufRead,BufNew * match JpSpace /　/

set autoindent
"set nosmartindent
set smartindent


""""" 見えない文字を視覚化
set list
set nolist

set listchars=extends:>
highlight SpecialKey cterm=NONE ctermfg=8 guifg=8
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
au BufRead,BufNew * match JpSpace /　/


""""" 行番号
set number
"set nonumber
set ruler


""""" ステータス行
set laststatus=2


""""" bom
set nobomb

""""" search
set hlsearch " 検索結果強調-:nohで解除
set incsearch " インクリメンタルサーチを有効

" マウス有効化
set mouse=a
set ttymouse=xterm2

" バックアップを取らない
set nobackup

" カーソルを行頭、行末でとまらないようにする
set whichwrap=b,s,h,s,<,>,[,]


" escの反応を素早くする
set timeout timeoutlen=1000 ttimeoutlen=75


" vimコマンド補完の強化
set wildmenu
set wildmode=list:full

set nowrap

" comment out 関連
" NERD Commenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" customize keymapping
map <Leader>cc <plug>NERDComToggleComment
map <Leader>c<space> <plug>NERDComComment

" Number line bg color
highlight LineNr ctermfg=grey ctermbg=black
" 背景を黒に
"highlight Normal ctermfg=grey ctermbg=233


noremap k h
noremap l j
noremap o k
noremap ; l

autocmd BufNewFile,BufRead *.nlu :setlocal filetype=nlu
autocmd BufNewFile,BufRead *.nlu0 :setlocal filetype=nlu0
autocmd BufNewFile,BufRead *.nlu1 :setlocal filetype=nlu1
autocmd BufNewFile,BufRead *.nlu2 :setlocal filetype=nlu2
autocmd BufNewFile,BufRead *.nlu3 :setlocal filetype=nlu3
