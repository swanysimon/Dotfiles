" vimrc
" Simon Swanson

" be iMproved
set nocompatible
filetype on
syntax   on

" standard settings
set backspace=eol,indent,start
set clipboard+=unnamed
set history=1000
set hlsearch
set ignorecase
set incsearch
set mouse=a
set ruler
set smartcase
set visualbell

" file improvements
set autoread
set dir=/tmp/
set hidden
set swapfile
set undodir=/tmp/
set undofile

" exit insert mode slightly more gracefully
inoremap jk <Esc>
set timeoutlen=250

" unlink single character deletion from clipboard
nnoremap x "_x
vnoremap x "_x
nnoremap s "_s
vnoremap s "_x

" indentation improvements
set autoindent
set expandtab
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4
set tabstop=4

" smarter line behavior
set colorcolumn=+1
set linebreak
set nojoinspaces
set number
set textwidth=120

" smarter pane splitting
set splitright
set splitbelow

" better autocompletion
set completeopt=longest,menuone
set wildmenu
set wildmode=list
inoremap <expr> <Tab>   pumvisible() ? "\<C-N>" : "\<C-X>\<C-N>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<C-X>\<C-P>"
"inoremap <expr> <CR>  pumvisible() ? "\<C-Y>" : "\<C-g>u\<CR>"
"inoremap <expr> <Esc> pumvisible() ? "\<C-E>" : "\<C-g>u\<Esc>"

" manage plugins
set rtp+=$HOME/.vim/bundle/vundle/
call vundle#begin()

" all plugins. run :BundleInstall to install once vundle set up
"Plugin 'blueshirts/darcula'
Plugin 'gmarik/vundle'
Plugin 'kien/ctrlp.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'lambdatoast/elm.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()

" all plugins should be above these lines
filetype indent on
filetype plugin on

" airline settings
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline_theme='jellybeans'
let g:airline#extensions#tabline#enabled=1

" ctrlp settings
let g:ctrlp_custom_ignore='\.(DS_STORE|git)$'
let g:ctrlp_custom_ignore+='\.(class|jar)$'
let g:ctrlp_custom_ignore+='\.(gif|jpg|png)$'
let g:ctrlp_custom_ignore+='\.(bz2|gz|zip)$'

" NERDTree settings
nnoremap <C-N> :NERDTree<CR>

" color settings
"colorscheme darcula
syntax on
highlight ColorColumn ctermbg=black
highlight NonText ctermbg=NONE
highlight Normal ctermbg=NONE
