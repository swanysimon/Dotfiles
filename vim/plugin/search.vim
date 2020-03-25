" search.vim
" Default search settings.

if exists("g:loaded_my_search_plugin")
  finish
endif
let g:loaded_my_search_plugin=1

set ignorecase
set incsearch
set hlsearch
set smartcase

" Clear highlights when this plugin is loaded.
nohlsearch
