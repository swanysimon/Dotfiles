let b:this_file_hash=swanysimon#checksum#Sha256(expand("%:p"))
if exists("g:loaded_my_color_plugin")
  if g:loaded_my_color_plugin == b:this_file_hash
    finish
  endif
endif
let g:loaded_my_color_plugin=b:this_file_hash

syntax enable

set background=dark
try
  colorscheme darcula
catch
  echo "Failed to load colorcheme 'darcula'"
endtry
