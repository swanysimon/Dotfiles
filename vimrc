" vimrc
" Simon Swanson

" be iMproved
set nocompatible
filetype off
syntax   on
autocmd! bufwritepost .vimrc source %

" standard settings I find helpful
set backspace=eol,indent,start
set clipboard=unnamed
set encoding=utf-8
set history=1000
set ignorecase
set incsearch
set mouse=a
set ruler
set smartcase
set timeoutlen=250
set visualbell
inoremap jk <Esc>

" unlink single character deletion from clipboard
nnoremap x "_x
vnoremap x "_x
nnoremap s "_s
vnoremap s "_x

" better movement
nnoremap j  gj
nnoremap k  gk
nnoremap gj j
nnoremap gk k
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" file improvements
set autoread
set dir=/tmp/
set hidden
set swapfile
set undodir=/tmp/
set undofile

" indentation improvements
set autoindent
set expandtab
set shiftround
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4
set tabstop=4
vnoremap < <gv
vnoremap > >gv

" smarter line behavior
set colorcolumn=121
set foldlevel=99
set foldmethod=indent
set linebreak
set nojoinspaces
set nowrap
set number
set textwidth=120
nnoremap <Space> za

" smarter pane splitting
set splitright
set splitbelow

" better autocompletion
set completeopt=longest,menuone
set wildmenu
set wildmode=list

" manage plugins
set rtp+=$HOME/.vim/bundle/vundle/
call vundle#begin()

" all plugins. run :BundleInstall to install once vundle set up
Plugin 'blueshirts/darcula'
Plugin 'davidhalter/jedi-vim'
Plugin 'gmarik/vundle'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()

" all plugins should be above this line
filetype indent plugin on
syntax on

" set colorscheme to darcula
set background=dark
set guifont=Menlo\ Regular\ for\ Powerline:h14
colorscheme darcula
highlight Normal ctermbg=none
highlight ColorColumn ctermbg=black

" ctrlp settings
let g:ctrlp_custom_ignore='\.(DS_STORE|git|class|jar|gif|jpg|png|bz2|gz|tar|zip)$'
let g:ctrlp_max_height=30

" NERDTree settings
nnoremap <C-N> :NERDTree<CR>

" airline settings
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline_theme='jellybeans'
let g:airline#extensions#tabline#enabled=1

