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
Plug 'tpope/vim-surround'

" navigation plugins
Plug 'scrooloose/nerdtree', { 'on': 'NERDTree' }

" language specific plugins
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffeescript' }
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'ElmCast/elm-vim', { 'for': 'elm' }
Plug 'vim-scripts/haskell.vim', { 'for': 'haskell' }

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

" enable folds
" TODO: fix foldmethod per language
set foldenable
set foldmethod=indent
set foldlevel=1

" line numbers
set relativenumber
set number

" buffer summary
set ruler

" use visual alerts
set novisualbell

" line wrap settings
set breakat=120
set linebreak

set splitbelow
set splitright

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

" trailing whitespace is highlighted in red
highlight ExtraWhitespace ctermbg=RED
match ExtraWhitespace /\s\+$/

""""
"" key remappings
""""

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

" indentation in visual mode
vnoremap < <gv
vnoremap > >gv

" single character deletions shouldn't go to the clipboard
nnoremap x "_x
vnoremap x "_x
nnoremap s "_s
vnoremap s "_s

" navigate between splits without prefixing
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

nnoremap <C-Left> bN
nnoremap <C-Right> bn

""""
"" plugin settings
""""

" NERDTree settings
nnoremap <C-N> :NERDTree<Enter>

let NERDTreeAutoDeleteBuffer=1

function! IsNERDTreeBufferOpen()
    return exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1
endfunction

function! SyncNERDTreeView()
    " only syncs NERDTree when the open buffer is modifiable, not a diff, has
    " a filename, and NERDTree is already open
    if &modifiable && !&diff && winnr("$") > 1 && IsNERDTreeBufferOpen() && expand("%:t") != ""
        let l:curwnum = winnr()
        NERDTreeFind
        execute l:curwnum . "wincmd w"
    endif
endfunction

""""
"" command settings
""""

" write file with sudo when you aren't runing sudoedit
cnoremap w!! w !sudo tee %

" always run commands
augroup alwaysgroup
    autocmd!

    " remove trailing whitespace on buffer write
    autocmd BufWritePre * %s/\s\+$//e

    " entering a buffer sync NERDTree view
    autocmd BufEnter,BufRead * call SyncNERDTreeView()

    " quit vim if NERDTree is the only thing open
    autocmd BufEnter * if winnr("$") == 1 && IsNERDTreeBufferOpen() | q | endif
augroup END

