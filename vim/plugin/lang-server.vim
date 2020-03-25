" lang-server.vim
" Adds a convenience function for loading a language server

if exists('g:loaded-lang-server-plugin')
  finish
endif
let g:loaded-lang-server-plugin=1

function! InitLSP()
  packadd! vim-lsp
endfunction
