" default spacing settings

let b:this_file_hash=checksum#Sha256(expand("%:p"))
if exists("g:loaded_my_spacing_plugin")
  if g:loaded_my_spacing_plugin == b:this_file_hash
    finish
  endif
endif
let g:loaded_my_spacing_plugin=b:this_file_hash

set backspace=eol,indent,start

set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4

set formatoptions=cjloqrt1
set nojoinspaces
