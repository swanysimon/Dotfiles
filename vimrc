" vimrc
" Simon Swanson

" be iMproved
set nocompatible
filetype on
syntax   on

" standard settings I find helpful
set backspace=eol,indent,start
set clipboard=unnamed
set history=1000
set hlsearch
set ignorecase
set incsearch
set mouse=a
set ruler
set smartcase
set visualbell

" more logical line nagivation
nnoremap j  gj
nnoremap k  gk
nnoremap gj j
nnoremap gk k

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
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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
Plugin 'blueshirts/darcula'
Plugin 'gmarik/vundle'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()

" all plugins should be above this line
filetype indent plugin on

" font settings
set guifont=Menlo\ Regular\ for\ Powerline:h14

" basic color settings
set background=dark
colorscheme darcula
syntax on
highlight Normal ctermbg=none

" highlight extra trailing white
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" ctrlp settings
let g:ctrlp_custom_ignore='\.(DS_STORE|git|class|jar|gif|jpg|png|bz2|gz|tar|zip)$'

" NERDTree settings
nnoremap <C-N> :NERDTree<CR>

" airline settings
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline_theme='jellybeans'
let g:airline#extensions#tabline#enabled=1

