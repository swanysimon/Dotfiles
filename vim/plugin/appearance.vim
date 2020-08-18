filetype plugin indent on
syntax enable

set cmdheight=2
set cursorline
set number
set signcolumn=number
set textwidth=0

set lazyredraw
set splitbelow
set splitright

set breakindent
set linebreak
set showbreak=...

set listchars=eol:$,extends:→,precedes:←,nbsp:·,tab:»·,trail:·

set background=dark
try
  colorscheme darcula
catch
  echo "Failed to load colorcheme 'darcula'"
endtry
