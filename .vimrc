syntax enable " 自動で色分けされるように
set number " 行番号を表示
set cursorline " 選択している行番に下線を表示
set mouse=a " マウスを使えるように
set title " terminalのタイトルがファイル名に
set ruler " カーソルが点滅
set encoding=utf-8
set fileencoding=utf-8 " 文字コードを指定
set backspace=indent,eol,start " バックスペースですべて削除できるように
set hlsearch " 検索時該当する文字をハイライト
set clipboard=unnamed,autoselect " ヤンクでクリップボードにコピー
set scrolloff=3 " 端に来たときスクロールをするのではなく指定行数余裕を持たせてスクロールする
set incsearch " インクリメンタルサーチ 確定しなくても検索する を有効にする
"set colorcolumn=80 " カラムラインを引く 長過ぎる行がわかるようになる
set expandtab " タブの代わりに空白を使う
"set tabstop=2 " タブの幅
"set shiftwidth=2 " 自動インデントでずれる幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する

if &compatible
  set nocompatible " Be iMproved
endif

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('jacoborus/tender.vim')
  call dein#add('itchyny/lightline.vim')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/deol.nvim', { 'rev': '01203d4c9' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Theme
syntax enable
colorscheme tender

set laststatus=2
if !has('gui_running')
  set t_Co=256
endif
set noshowmode

" set lighline theme inside lightline config
let g:lightline = { 'colorscheme': 'tender' }
