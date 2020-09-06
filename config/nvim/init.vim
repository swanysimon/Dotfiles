set history=1000

let mapleader=","
let mapleaderlocal="'"

set hidden

set expandtab
set shiftwidth=2
set softtabstop=2

set nojoinspaces

set lazyredraw

set cursorline
set noruler
set number
set signcolumn=auto
set textwidth=0

set ignorecase

set wildignorecase
set wildmode=list:full

set splitbelow
set splitright

set comments=
set include=
set path-=/usr/include

if has("mouse")
  set mouse=a
endif

if has("unnamedplus")
  set clipboard^=unnamedplus
elseif has("unnamed")
  set clipboard^=unnamed
endif

nohlsearch
