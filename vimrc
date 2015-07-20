" vimrc
" Simon Swanson

" semicolon as colon
nnoremap ; :
vnoremap ; :

" not vi compatible for more functionality
set nocompatible

" exit insert/replace mode slightly more gracefully
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
vnoremap d "_d
vnoremap x "_x

" tabs as 4 spaces
" set expandtab
set softtabstop=4
set shiftwidth=4

" smarter pair management; needs work still
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i
inoremap { {}<Esc>i
inoremap < <><Esc>i

" stupid preview
" autocmd CompleteDone * pclose

" manage plugins
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Plugin 'gmarik/vundle'
Plugin 'lambdatoast/elm.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'

" all plugins should be above this line
filetype plugin indent on

" visual sugar
colorscheme jellybeans
syntax on
set hlsearch
set matchpairs+=<:>
set number
set wildmenu=longest,list
