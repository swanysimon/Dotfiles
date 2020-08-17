" Configures the appearance of vim.

let b:this_file_hash=checksum#Sha256(expand("%:p"))
if exists("g:loaded_my_visual_plugin")
  if g:loaded_my_visual_plugin == b:this_file_hash
    finish
  endif
endif
let g:loaded_my_visual_plugin=b:this_file_hash

filetype plugin indent on
syntax enable

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

set foldenable
set foldmethod=syntax
set foldlevel=99

set listchars=eol:$,extends:→,precedes:←,nbsp:·,tab:»·,trail:·

set background=dark
try
  colorscheme darcula
catch
  echo "Failed to load colorcheme 'darcula'"
endtry
