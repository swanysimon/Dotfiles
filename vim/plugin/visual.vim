" visual.vim
" Configures the appearance of vim.

if exists("g:loaded_my_visual_plugin")
  finish
endif
let g:loaded_my_visual_plugin=1

set cursorline
set number
set signcolumn=number

set breakindent
set linebreak
set showbreak=...

set hidden
set lazyredraw

set cmdheight=2

set splitbelow
set splitright

set listchars=eol:$,extends:→,precedes:←,nbsp:·,tab:»·,trail:·

syntax enable
set background=dark

try
  colorscheme darcula
catch
  echo "Failed to load colorcheme 'darcula'"
endtry
