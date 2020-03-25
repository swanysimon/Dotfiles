" lang-server.vim
" Adds a convenience function for loading a language server

if exists("g:loaded_my_lang_server_plugin")
  finish
endif
let g:loaded_my_lang_server_plugin=1

function! InitLSP()
  packadd! vim-lsp
endfunction
