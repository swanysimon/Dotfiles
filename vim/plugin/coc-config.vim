let b:this_file_hash=swanysimon#checksum#Sha256(expand("%:p"))
if exists("g:loaded_my_coc_config_plugin")
  if g:loaded_my_coc_config_plugin == b:this_file_hash
    finish
  endif
endif
let g:loaded_my_coc_config_plugin=b:this_file_hash

" todo
" inoremap <C-n> coc#refresh()
