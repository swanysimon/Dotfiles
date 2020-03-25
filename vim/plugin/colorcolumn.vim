" colorcolumn.vim
" When textwidth is set to a positive number, sets the colorcolumn to highlight
" the next column for editing sanity. Filetype plugins should therefore set
" their own texwidth values.

if exists("g:loaded_my_colorcolumn_plugin")
  finish
endif
let g:loaded_my_colorcolumn_plugin=1

set textwidth=0

function! s:SetColorColumn()
  if &textwidth <= 0
    setlocal colorcolumn=
  else
    setlocal colorcolumn=+1
  endif
endfunction

augroup colorcolumn
  autocmd!
  autocmd BufEnter * call s:SetColorColumn()
  autocmd OptionSet textwidth call s:SetColorColumn()
augroup end
