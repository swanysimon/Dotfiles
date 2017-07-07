" vimrc
" Simon Swanson

" be iMproved
set encoding=utf-8
set history=1000
set nocompatible

""""
"" install plugins
""""
call plug#begin()

" general purpose plugins
Plug 'sherifkandeel/vim-colors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'

" navigation plugins
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" language specific plugins
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffeescript' }
Plug 'ElmCast/elm-vim', { 'for': 'elm' }

call plug#end()

""""
"" system settings
""""

" autoload buffer on change
set autoread

" make backspace behave correctly
set backspace=eol,indent,start

" allow mouse usage
set mouse=a

set timeoutlen=200

" use system clipboard
if has('unnamedplus')
    set clipboard^=unnamedplus
else
    set clipboard^=unnamed
endif

" search settings
set ignorecase
set incsearch
set smartcase

" swapfile settings
set dir=/tmp/
set swapfile

" persist undo tree
set undodir=/tmp/
set undofile

" enable bash style tab completion
set wildmenu
set wildmode=longest,list

" insert mode completion
set completeopt=longest,menuone,preview

""""
"" visual settings
""""

" syntax highlighting on
filetype indent plugin on
syntax on

" show current line
set cursorline

" macros execute before triggering redraw
set lazyredraw

" line numbers
set number

" buffer summary
set ruler

" use visual alerts
set visualbell

" line wrap settings
set breakat=120
set linebreak

" pane split settings
set splitright
set splitbelow

" indentation settings
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4

" don't highlight search results
set nohlsearch

" set font
set guifont=Menlo\ Regular\ for\ Powerline:h14

" set colorscheme
set background=dark
colorscheme vimbrains
highlight Normal ctermbg=NONE

" trailing whitespace or tabs as red
highlight ExtraWhitespace ctermbg=RED
match ExtraWhitespace /\s\+$\|\t/

""""
"" key remappings
""""

" backspace acts normally
set backspace=eol,indent,start

" up-down navigation by visual line
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

" exit insert mode from home row
inoremap jk <ESC>
inoremap kj <ESC>

" beginning and end of row
nnoremap B ^
vnoremap B ^
nnoremap E $
vnoremap E $

" join with line above
nnoremap K kj

" indentation in visual mode
vnoremap < <gv
vnoremap > >gv

" single character deletions shouldn't go to the clipboard
nnoremap x "_x
vnoremap x "_x
nnoremap s "_s
vnoremap s "_s

" navigate between splits without prefixing
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

""""
"" plugin settings
""""

" ctrlp settings
let g:ctrlp_custom_ignore='\.(DS_STORE|git|class|jar|gif|jpg|png|bz2|gz|tar|zip)$'
let g:ctrlp_max_height=30
let g:ctrlp_switch_buffer=0
let g:ctrlp_working_path_mode=0

" use silver searcher with ctrlp
let g:ctrlp_user_command='ag %s -l --nocolor -g ""'

" NERDTree settings
nnoremap <C-N> :NERDTree<CR>

""""
"" autocmd settings
""""

" always run commands
augroup alwaysgroup
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END

