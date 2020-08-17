let b:this_file_hash=checksum#Sha256(expand("%:p"))
if exists("g:loaded_my_autocmd_plugin")
  if g:loaded_my_autocmd_plugin == b:this_file_hash
    finish
  endif
endif
let g:loaded_my_autocmd_plugin=b:this_file_hash

augroup colorcolumn
  autocmd!
  autocmd BufEnter * call s:SetColorColumn()
  autocmd OptionSet textwidth call s:SetColorColumn()
augroup end

augroup resizing
  autocmd!
  autocmd VimResized * execute "normal! \<C-w>="
augroup end

function! s:SetColorColumn()
  if &textwidth <= 0
    setlocal colorcolumn=
  else
    setlocal colorcolumn=+1
  endif
endfunction
