" colorcolumn.vim
" Sets colorcolumn to be textwidth, if it's set and greater than 0
" Simon Swanson

if exists('g:loaded_colorcolumn_plugin')
  finish
endif
let g:loaded_colorcolumn_plugin=1

function! s:SetColorColumn()
  if &textwidth == 0
    setlocal colorcolumn=
    setlocal ruler
  else
    setlocal colorcolumn=+0
    setlocal noruler
  endif
endfunction

augroup colorcolumn
  autocmd!
  autocmd BufEnter * call s:SetColorColumn()
  autocmd OptionSet textwidth call s:SetColorColumn()
augroup end
