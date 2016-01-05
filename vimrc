" vimrc
" Simon Swanson

" be iMproved
set nocompatible
filetype off

" more command history
set history=1000

" disable ear destruction
set visualbell

" file improvements
set autoread
set hidden

" fix backspace
set backspace=indent,eol,start

" exit insert mode slightly more gracefully
inoremap jk <Esc>
set timeoutlen=100

" improved copy-paste
set clipboard+=unnamed

" sometimes you just need the mouse
set mouse=a

" unlink character deletion from clipboard
" TODO: add in way to still cut
nnoremap x "_x
nnoremap s "_s
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
set number

" improved search
set hlsearch
set ignorecase
set incsearch
set smartcase
set wildmenu
set wildmode=longest:full,full

" manage plugins
set rtp+=$HOME/.vim/bundle/vundle/
call vundle#begin()

" all plugins. run :BundleInstall to install once vundle set up
Plugin 'altercation/vim-colors-solarized'
Plugin 'gmarik/vundle'
Plugin 'kien/ctrlp.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'lambdatoast/elm.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()

" all plugins should be above these lines
filetype indent on
filetype plugin on

" NERDTree as CTRL-n
nnoremap <C-N> :NERDTree<CR>

" ctrlp settings
let g:ctrlp_custom_ignore='\.(DS_STORE|git)$'
let g:ctrlp_custom_ignore+='\.(class|jar)$'
let g:ctrlp_custom_ignore+='\.(gif|jpg|png)$'
let g:ctrlp_custom_ignore+='\.(bz2|gz|zip)$'

" visual sugar
syntax on
set background=dark
colorscheme solarized
hi Normal ctermbg=None
hi NonText ctermbg=None

