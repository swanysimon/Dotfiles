set history=1000

let mapleader=","
let mapleaderlocal="'"

set hidden

set expandtab
set shiftwidth=2
set softtabstop=2

set nojoinspaces

set lazyredraw
set timeoutlen=200

set cursorline
set laststatus=0
set noruler
set signcolumn=no
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

if "$COLORTERM" == "truecolor" || "$COLORTERM" == "24bit"
  set termguicolors
endif

nohlsearch