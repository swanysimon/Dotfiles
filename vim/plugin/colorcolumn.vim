" When textwidth is set to a positive number, sets the colorcolumn to highlight
" the next column for editing sanity. Filetype plugins should therefore set
" their own texwidth values.

let b:this_file_hash=checksum#Sha256(expand("%:p"))
if exists("g:loaded_my_colorcolumn_plugin")
  if g:loaded_my_colorcolumn_plugin == b:this_file_hash
    finish
  endif
endif
let g:loaded_my_colorcolumn_plugin=b:this_file_hash

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
