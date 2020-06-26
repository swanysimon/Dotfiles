" diff.vim
" Configures the diffing capabilities of vim

if exists("g:loaded_my_diff_plugin")
  finish
endif
let g:loaded_my_diff_plugin=1

set diffopt=closeoff,context:4,filler,internal,algorithm:minimal
