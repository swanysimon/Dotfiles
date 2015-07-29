" vimrc
" Simon Swanson

" semicolon as colon
nnoremap ; :
vnoremap ; :

" be iMproved
set nocompatible
filetype off

" exit insert mode slightly more gracefully
inoremap jk <Esc>
set timeoutlen=100

" fix backspace
set backspace=indent,eol,start

" link to system clipboard
set clipboard=unnamed

" better paste in insert mode
inoremap <C-P> <Esc>pi

" stop stupid deletion going to clipboard
nnoremap d "_d
nnoremap x "_x
nnoremap s "_s
vnoremap d "_d
vnoremap x "_x
vnoremap s "_x

" better tabs
set autoindent
set expandtab
set shiftwidth=4
set smarttab
set softtabstop=4

" NERDTree as CTRL-n
inoremap <C-N> :NERDTree<CR>
nnoremap <C-N> :NERDTree<CR>

" manage plugins
set rtp+=$HOME/.vim/bundle/vundle/
call vundle#begin()
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

" visual sugar
colorscheme jellybeans
set hlsearch
set matchpairs+=<:>
set nowrap
set number
set wildmenu
syntax on
