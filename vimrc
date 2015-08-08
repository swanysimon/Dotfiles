" vimrc
" Simon Swanson

" be iMproved
set nocompatible
filetype off

" semicolon as colon
nnoremap ; :
vnoremap ; :

" exit insert mode slightly more gracefully
inoremap jk <Esc>
set timeoutlen=100

" fix backspace
set backspace=indent,eol,start

" attach clipboard to system, make more useful
set clipboard=unnamed
inoremap <C-P> <Esc>pi
nnoremap d "_d
nnoremap x "_x
nnoremap s "_s
vnoremap d "_d
vnoremap x "_x
vnoremap s "_x

" more useful tabs
" TODO: detect file tab width and adjust
set autoindent
set expandtab
set shiftwidth=4
set smarttab
set softtabstop=4

" pair matching
set matchpairs+=<:>

" NERDTree as CTRL-n
inoremap <C-N> :NERDTree<CR>
nnoremap <C-N> :NERDTree<CR>

" manage plugins
set rtp+=$HOME/.vim/bundle/vundle/
call vundle#begin()
" all plugins. run :BundleInstall to install once vundle set up
Plugin 'gmarik/vundle'
Plugin 'hukl/Smyck-Color-Scheme'
Plugin 'kchmck/vim-coffee-script'
Plugin 'lambdatoast/elm.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()

" all plugins should be above this line
filetype plugin indent on

" improved search
nnoremap <CR> :noh<CR>
set hlsearch
set ignorecase
set incsearch
set smartcase
set wildmenu
set wildmode=longest:full,full

" visual sugar
colorscheme jellybeans
set nowrap
set number
set wildmenu
syntax on
