" completion.vim
" Settings for the various completion menus in vim

if exists("g:loaded_my_completion_plugin")
  finish
endif
let g:loaded_my_completion_plugin=1

set completeopt=longest,menuone,preview

set wildignorecase
set wildmenu
set wildmode=list:longest
