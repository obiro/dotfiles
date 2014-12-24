"http://dotfiles.github.io/
"http://qiita.com/td2sk/items/2299a5518f58ffbfc5cf
"http://blog.takuma7.com/blog/2014/01/02/vim-setting/

" 使用するshellを設定
set shell=$SHELL

" インサートモード時にバックスペースを使う
set backspace=indent,eol,start

set nocompatible
filetype off
filetype plugin indent off


"""""""""""""""""""""""""""""""""""""""""""""""""
" plugin manager
"""""""""""""""""""""""""""""""""""""""""""""""""

" create directory
if !isdirectory(expand('~/.vim/tmp'))
  call mkdir(expand('~/.vim/tmp', 'p'))
endif
if !isdirectory(expand('~/.vim/bundle'))
  call mkdir(expand('~/.vim/bundle', 'p'))
endif

" NeoBundle
if has('vim_starting')
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "installing neobundle..."
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle/'))
  NeoBundleFetch 'Shougo/neobundle.vim'

  NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'windows' : 'tools\\update-dll-mingw',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'linux' : 'make',
    \     'unix' : 'gmake'
    \    }
    \ }
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'Shougo/neomru.vim'
  if ( has('lua') && (v:version > 703 || v:version == 703 && has('patch885')) )
    NeoBundle 'Shougo/neocomplete.vim'
  endif
  NeoBundle 'Shougo/neosnippet'
  NeoBundle 'Shougo/neosnippet-snippets'
  NeoBundle 'Shougo/vimfiler'
  NeoBundle 'Shougo/vimshell'
  NeoBundle 'thinca/vim-quickrun'
  NeoBundle 'ujihisa/unite-locate'
  NeoBundle 'lambdalisue/unite-grep-vcs'

  " sudo.vim
  NeoBundle 'vim-scripts/sudo.vim'
  NeoBundle 'vim-scripts/dbext.vim'
  NeoBundle 'vim-scripts/taglist.vim'

  " git
  " http://cohama.hateblo.jp/entry/20130517/1368806202
  " http://www.mk-mode.com/octopress/2013/08/12/vim-install-gitv/
  " http://www.mk-mode.com/octopress/2013/08/11/vim-install-fugitive/
  NeoBundle 'tpope/vim-fugitive'
  NeoBundle 'gregsexton/gitv'

  " vimdiff関連
  " http://koturn.hatenablog.com/entry/2013/08/10/034242
  " http://d.hatena.ne.jp/Ox8000ffff/20131225/1387978376
  NeoBundle 'vim-scripts/DirDiff.vim'

  " line
  NeoBundle 'itchyny/lightline.vim'

  " color scheme
  NeoBundle 'tomasr/molokai'
  NeoBundle 'vim-scripts/BusyBee'

  " indent file
  " delete warning message `Large indenting detected`
  NeoBundle '2072/PHP-Indenting-for-VIm'
  NeoBundle 'nathanaelkane/vim-indent-guides'

  " syntax
  "NeoBundle 'scrooloose/syntastic.git'
  NeoBundle 'othree/html5.vim'
  NeoBundle 'hail2u/vim-css3-syntax'
  NeoBundle 'jelera/vim-javascript-syntax'

  " ctags
  NeoBundle 'soramugi/auto-ctags.vim'

  " other
  NeoBundle 'tpope/vim-markdown'
  NeoBundle 'LeafCage/foldCC'
  NeoBundle 'editorconfig/editorconfig-vim'
  NeoBundle 'airblade/vim-rooter'


  "NeoBundle 'thinca/vim-ref'
call neobundle#end()

NeoBundleCheck

"""""""""""""""""""""""""""""""""""""""""""""""""
" plugins configuration
"""""""""""""""""""""""""""""""""""""""""""""""""

if neobundle#is_installed('vim-ref')
  let g:ref_cache_dir=$HOME.'/.vim/tmp/vim-ref'
  let g:ref_phpmanual_path = expand('~/local/man/php-chunked-xhtml')
endif

if neobundle#is_installed('vim-rooter')
  let g:rooter_use_lcd = 1
  let g:rooter_patterns = ['.git', '.git/', '_darcs/', '.hg/', '.bzr/', '.svn/']
endif

if neobundle#is_installed('auto-ctags.vim')
  "let g:auto_ctags = 1
  let g:auto_ctags_directory_list = ['.git', '.svn']
  let g:auto_ctags_tags_name = 'tags'
  let g:auto_ctags_tags_args = '--tag-relative --recurse --sort=yes'
  set tags+=.git/tags
endif

if neobundle#is_installed('unite.vim')
  " unite画面で<C-l>をすることでキャッシュを更新
  let g:unite_enable_start_insert = 0
  let g:unite_data_directory=expand('~/.vim/tmp/.unite')
  let g:unite_source_rec_min_cache_files = 100
  let g:unite_source_rec_max_cache_files = 10000
  let g:unite_source_file_ignore_pattern='\%(^\|/\)tmp/cache\%($\|/\)$\|\%(^\|/\)\.$\|\~$\|\.\%(o|exe|dll|bak|sw[po]\)$\|\%(^\|/\)\.\%(vim\|hg\|git\|bzr\|svn\)\%($\|/\)'
  let g:unite_source_file_rec_ignore_pattern='\%(^\|/\)tmp/cache\%($\|/\)$\|\%(^\|/\)\.$\|\~$\|\.\%(o|exe|dll|bak|sw[po]\)$\|\%(^\|/\)\.\%(vim\|hg\|git\|bzr\|svn\)\%($\|/\)'
  "call unite#custom#source('file_rec/async', 'ignore_pattern', '\(png\|gif\|jpeg\|jpg\)$')
  let g:unite_source_grep_search_word_highlight = 1
  if executable('pt')
    let g:unite_source_rec_async_command = 'pt --nocolor --nogroup -l ""'
    let g:unite_source_file_rec_async_command = 'pt --nocolor --nogroup -l ""'
    let g:unite_source_grep_command = 'pt'
    let g:unite_source_grep_default_opts = '--nocolor --nogroup'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_grep_max_candidates = 200
  endif
endif

if neobundle#is_installed('neomru.vim')
  let g:neomru#file_mru_path=expand('~/.vim/tmp/.neomru/file')
  let g:neomru#file_mru_ignore_pattern='\%(^\|/\)tmp/cache\%($\|/\)$\|\%(^\|/\)\.$\|\~$\|\.\%(o|exe|dll|bak|sw[po]\)$\|\%(^\|/\)\.\%(vim\|hg\|git\|bzr\|svn\)\%($\|/\)'
  let g:neomru#file_mru_limit=1000
  let g:neomru#directory_mru_path=expand('~/.vim/tmp/.neomru/direcroty')
  let g:neomru#directory_mru_ignore_pattern='\%(^\|/\)tmp/cache\%($\|/\)$\|\%(^\|/\)\.$\|\~$\|\.\%(o|exe|dll|bak|sw[po]\)$\|\%(^\|/\)\.\%(vim\|hg\|git\|bzr\|svn\)\%($\|/\)'
  let g:neomru#directory_mru_limit=1000
endif

if neobundle#is_installed('neocomplete.vim')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#max_list = 10
  let g:neocomplete#enable_ignore_case = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#enable_camel_case = 0
  let g:neocomplete#data_directory=expand('~/.vim/tmp/.neocomplte')
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns._ = '\h\w*'
endif

if neobundle#is_installed('vimfiler')
  ":e . vimデフォルトのエクスプローラをvimfilerで置き換える
  let g:vimfiler_data_directory=expand('~/.vim/tmp/.vimfiler')
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_enable_auto_cd = 1
  autocmd FileType vimfiler call unite#custom_default_action('directory', 'lcd')
endif

if neobundle#is_installed('vimshell')
  let g:vimshell_temporary_directory=expand('~/.vim/tmp/.vimshell')
  let g:vimshell_interactive_update_time = 10
  let g:vimshell_prompt = $USER."$ "
endif

if neobundle#is_installed('vim-indent-guides')
  let g:indent_guides_enable_on_vim_startup=1
  let g:indent_guides_start_level=2
  let g:indent_guides_guide_size=1
  let g:indent_guides_auto_colors=0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=242
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=240
endif

if neobundle#is_installed('lightline.vim')
  let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ }
endif

if neobundle#is_installed('foldCC')
  "set foldtext=foldCC#foldtext()
endif

" editorconfig
if neobundle#is_installed('editorconfig-vim')
  silent! call editorconfig#ApplyHooks(a:config)
endif


"""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd
"""""""""""""""""""""""""""""""""""""""""""""""""

"""""" skel
augroup SkeletonAu
  autocmd!
  autocmd BufNewFile *.sh 0r ~/.vim/skel/skel.sh
augroup END

" 貼り付け時のコメントでるのを改善
autocmd FileType * set formatoptions-=ro

" insetモードから抜けるときにnopaste
autocmd InsertLeave * set nopaste


""""" session
augroup SessionManage
  if argc() == 0 && !&readonly
    let s:last_session = expand('~/.vim/tmp/session.vim')

    autocmd VimLeave *
    \ if &ft != 'git' && &ft != 'gitcommit' |
    \   exe "mksession! " . s:last_session |
    \ endif

    if filereadable(s:last_session)
      autocmd VimEnter * nested
      \ if &ft != 'git' && &ft != 'gitcommit' |
      \   exe "source " . s:last_session |
      \ endif
    endif
  endif
augroup END


" when change buffer, cd
"function! ChangeCurrentDirectoryToProjectRoot()
"  let root = unite#util#path2project_directory(expand('%'))
"  execute 'lcd' root
"endfunction
"au BufEnter * :call ChangeCurrentDirectoryToProjectRoot()

" help
"set keywordprg=:help " Open Vim internal help by K command

autocmd FileType ref-phpmanual,help nnoremap <buffer> q <C-w>c




"""""""""""""""""""""""""""""""""""""""""""""""""
" configuration
"""""""""""""""""""""""""""""""""""""""""""""""""

""""" filetype
filetype on
filetype plugin on
filetype indent on

""""" encode & line
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp,default,latin
set ffs=unix,dos,mac

""""" タブとインデント
set noexpandtab
set tabstop=4
set softtabstop=4 "equal tabstop
set shiftwidth=4 "equal tabstop

""""" タブとインデント
set expandtab
set tabstop=2
set softtabstop=2 "equal tabstop
set shiftwidth=2 "equal tabstop







"set noautoindent
set autoindent
"set nosmartindent
set smartindent
"set nocindent
"set cindent
"set indentexpr=""



""""" colorscheme
set t_Co=256

colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1


""""" 構文ハイライト
syntax on

"set cursorline
"highlight CursorLine ctermbg=Black
"highlight CursorLine ctermfg=Blue
"set cursorcolumn
"highlight CursorColumn ctermbg=Blue
"highlight CursorColumn ctermfg=Green

" 重いときに括弧のハイライトを削除
"let loaded_matchparen = 1


""""" 折りたたみの設定
set nofoldenable
"set foldmethod=manual
"set foldlevel=1
"set foldnestmax=2


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

if (v:version > 703)
  set textwidth=120
  set colorcolumn=+1
endif

""""" 行の折り返し
"set wrap
set nowrap
"set guioptions+=b


""""" ステータス行
set laststatus=2


""""" bom
set nobomb


""""" 文字コードと改行コード
"set encoding=utf-8
set fileencodings=utf-8,cp932,shift-jis,euc-jp,iso-2022-jp
set fileformats=unix,dos


""""" clipbord
set clipboard=unnamed


""""" search
set hlsearch " 検索結果強調-:nohで解除
set incsearch " インクリメンタルサーチを有効


" screenでvimホイール有効化
" マウス有効化
set mouse=a
set ttymouse=xterm2


" スワップを作らない
"set noswapfile


" バックアップを取らない
set nobackup


" カーソルを行頭、行末でとまらないようにする
set whichwrap=b,s,h,s,<,>,[,]


" escの反応を素早くする
set timeout timeoutlen=1000 ttimeoutlen=75


" vimコマンド補完の強化
set wildmenu
set wildmode=list:full


"""""""""""""""""""""""""""""""""""""""""""""""""
" key mapping
"""""""""""""""""""""""""""""""""""""""""""""""""
" check filetype
" :verbose :setlocal filetype?

" default mapping check
" :help index.txt

" user mapping check
" :map or :nmap or :vap :vervose nmap ...

"http://blog.paz-para.com/?p=1794


"""""" unite vim
" The prefix key.
nnoremap [unite] <Nop>
nmap <Space>u [unite]

" バッファと最近使ったファイル
noremap [unite]u :Unite buffer file_mru<CR>

" バッファとブックマーク
noremap [unite]b :Unite buffer bookmark<CR>

" バッファとファイル一覧
noremap [unite]o :Unite buffer file<CR>

" クリップボード一覧
noremap [unite]y :Unite -buffer-name=register register<CR>

" 下位ディレクトリ検索
"nnoremap <silent> <C-p> :<C-u>call DispatchUniteFileRecAsyncOrGit()<CR>
noremap [unite]f :<C-u>call DispatchUniteFileRecAsyncOrGit()<CR>
function! DispatchUniteFileRecAsyncOrGit()
  if isdirectory(getcwd()."/.git")
    Unite -start-insert file_rec/git
  else
    Unite -start-insert file_rec/async:!
  endif
endfunction

" grep
noremap [unite]g :<C-u>call <SID>unite_smart_grep()<CR>
"nnoremap <silent> [unite]gg :<C-u>call <SID>unite_smart_grep()<CR>
function! s:unite_smart_grep()
  if unite#sources#grep_git#is_available()
    Unite -no-quit -winheight=15 grep/git:. -buffer-name=search-buffer
  "elseif unite#sources#grep_hg#is_available()
  "  Unite grep/hg:. -buffer-name=search-buffer
  else
    Unite -no-quit -winheight=15 grep:. -buffer-name=search-buffer
  endif
endfunction


noremap [unite]w :<C-u>call <SID>unite_smart_grep()<CR>
"nnoremap <silent> [unite]gg :<C-u>call <SID>unite_smart_grep()<CR>
function! s:unite_smart_grep()
  if unite#sources#grep_git#is_available()
    UniteWithCursorWord -winheight=15 grep/git:. -buffer-name=search-buffer
  "elseif unite#sources#grep_hg#is_available()
  "  Unite grep/hg:. -buffer-name=search-buffer
  else
    UniteWithCursorWord -winheight=15 grep:. -buffer-name=search-buffer
  endif
endfunction







" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')

" unite+vimfiler
"autocmd FileType vimfiler call unite#custom_default_action('directory', 'lcd')
"autocmd FileType vimfiler call unite#custom_default_action('directory', 'cd')



" vimfiler
"F2: ide風に起動
nnoremap <F2> :VimFiler -buffer-name=explorer -split -winwidth=45 -toggle<CR>



" vim-fugitive
" status
noremap <C-G><C-S> :Gstatus<CR>
" autocmd FileType git setlocal nofoldenable
autocmd FileType git setlocal foldenable foldlevel=0
function! s:toggle_git_folding()
  if &filetype ==# 'git'
    setlocal foldenable!
  endif
endfunction



" gitv
" ブラウザモードで起動
noremap <C-G><C-B> :Gitv<CR>
" ファイルモードで起動
noremap <C-G><C-F> :Gitv!<CR>
"augroup gitv
  autocmd FileType gitv call s:my_gitv_settings()
"augroup END
function! s:my_gitv_settings()
  " Gitvはqで終了
  setlocal iskeyword+=/,-,.
  nnoremap <buffer> G :<C-u>Gbrowse <C-r>=<SID>gitv_get_current_hash()<CR><CR>
  nnoremap <silent><buffer> t :<C-u>windo call <SID>toggle_git_folding()<CR>1<C-w>w

endfunction
" commit hashを取得
function! s:gitv_get_current_hash()
  return matchstr(getline('.'), '\[\zs.\{7\}\ze\]$')
endfunction


" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

