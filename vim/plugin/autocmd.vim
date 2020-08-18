let b:this_file_hash=swanysimon#checksum#Sha256(expand("%:p"))
if exists("g:loaded_my_autocmd_plugin")
  if g:loaded_my_autocmd_plugin == b:this_file_hash
    finish
  endif
endif
let g:loaded_my_autocmd_plugin=b:this_file_hash

augroup colorcolumn
  autocmd!
  autocmd BufEnter * call swanysimon#functions#dynamiccolorcolumn()
  autocmd OptionSet textwidth call swanysimon#functions#dynamiccolorcolumn()
augroup end

augroup resizing
  autocmd!
  autocmd VimResized * execute "normal! \<C-w>="
augroup end
