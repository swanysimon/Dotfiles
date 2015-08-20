" vimrc
" Simon Swanson

" be iMproved
set nocompatible
filetype off

" more command history
set history=1000

" disable ear destruction
set visualbell

" reload on file change
set autoread

" semicolon as colon
nnoremap ; :
vnoremap ; :

" exit insert mode slightly more gracefully
inoremap jk <Esc>
set timeoutlen=100

" fix backspace
set backspace=indent,eol,start

" attach clipboard to system
set clipboard+=unnamed

" better pasting? Don't actually know what this does
nnoremap p p=`]<C-o>
vnoremap p p=`[<C-o>

" unlink deletion from clipboard
" TODO: add in way to still cut
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
set smartindent
set smarttab
set softtabstop=4
set tabstop=4

" smarter lines
set linebreak
set nowrap
set number

" improved search
nnoremap <Esc> :noh<CR>
set hlsearch
set ignorecase
set incsearch
set smartcase
set wildmenu
set wildmode=longest:full,full

" pair matching
set matchpairs+=<:>

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
filetype indent on
filetype plugin on

" NERDTree as CTRL-n
inoremap <C-N> :NERDTree<CR>
nnoremap <C-N> :NERDTree<CR>

" visual sugar
colorscheme jellybeans
syntax on
