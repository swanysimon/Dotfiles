" vimrc
" Simon Swanson

" be iMproved
set nocompatible
autocmd! bufwritepost .vimrc source %

" install plugins
call plug#begin()

" language specific plugins
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffeescript' }
Plug 'ElmCast/elm-vim', { 'for': 'elm' }

Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'sherifkandeel/vim-colors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

call plug#end()

" general settings
set backspace=eol,indent,start
set encoding=utf-8
set history=1000
set lazyredraw
set mouse=a
set number
set ruler
set showmatch
set showcmd
set visualbell

" buffer management settings
set autoread
set dir=/tmp/
set swapfile
set undodir=/tmp/
set undofile

" search settings
set ignorecase
set incsearch
set smartcase
nnoremap gV `[v`]

" clipboard settings
if has('unnamedplus')
    set clipboard^=unnamedplus
else
    set clipboard^=unnamed
endif

" single character deletions shouldn't go to the clipboard
nnoremap x "_x
vnoremap x "_x
nnoremap s "_s
vnoremap s "_x

" movement settings
inoremap jk <ESC>
inoremap kj <ESC>
nnoremap B ^
nnoremap E $
nnoremap j gj
nnoremap k gk
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" spacing settings
set autoindent
set expandtab
set shiftwidth=4
set smartindent
set softtabstop=4
set tabstop=4
vnoremap < <gv
vnoremap > >gv
autocmd BufWritePre * %s/\s\+$//e

" word wrap settings
set breakat=120
set linebreak
set nojoinspaces
set nowrap

" fold settings
set foldenable
set foldlevelstart=10
set foldmethod=indent
nnoremap <SPACE> za

" pane split settings
set splitright
set splitbelow

" menu settings
set completeopt=longest,menuone
set wildmenu
set wildmode=list

filetype indent plugin on
syntax on

" color settings
set background=dark
set colorcolumn=121
set guifont=Menlo\ Regular\ for\ Powerline:h14
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
colorscheme vimbrains
highlight Normal ctermbg=NONE
highlight ColorColumn ctermbg=BLACK
highlight ExtraWhitespace ctermbg=RED

" ctrlp settings
let g:ctrlp_custom_ignore='\.(DS_STORE|git|class|jar|gif|jpg|png|bz2|gz|tar|zip)$'
let g:ctrlp_max_height=30
let g:ctrlp_switch_buffer=0
let g:ctrlp_working_path_mode=0

" NERDTree settings
nnoremap <C-N> :NERDTree<CR>

