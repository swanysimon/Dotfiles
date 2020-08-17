" Settings for the various menus and searches in vim

let b:this_file_hash=checksum#Sha256(expand("%:p"))
if exists("g:loaded_my_menu_plugin")
  if g:loaded_my_menu_plugin == b:this_file_hash
    finish
  endif
endif
let g:loaded_my_menu_plugin=b:this_file_hash

set ignorecase
set incsearch
set hlsearch
set smartcase

set completeopt=longest,menuone,preview

set wildignorecase
set wildmenu
set wildmode=list:longest
