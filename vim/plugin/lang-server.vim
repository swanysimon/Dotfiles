" lang-server.vim
" Adds configurations to the language server.

if exists("g:loaded_my_lang_server_plugin")
  finish
endif
let g:loaded_my_lang_server_plugin=1

function! s:RegisterServers()
  if executable("sourcekit-lsp")
    call lsp#register_server({
          \ "name": "sourcekit-lsp",
          \ "cmd": {server_info->["sourcekit-lsp"]},
          \ "whitelist": ["swift"],
          \ })
  endif
endfunction

function! s:ConfigureLangServer()
  "TODO: expand as I learn more about language servers
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=number
endfunction

augroup lang_server
  autocmd!
  autocmd User lsp_buffer_enabled call s:ConfigureLangServer()
  autocmd User lsp_setup call s:RegisterServers()
augroup end
