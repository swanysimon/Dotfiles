" lang-server.vim
" Adds configurations to the language server.

if exists("g:loaded_my_lang_server_plugin")
  finish
endif
let g:loaded_my_lang_server_plugin=1

let s:language_servers = {
\   "sourcekit-lsp": {
\     "name": "sourcekit-lsp",
\     "cmd": {server_info->["sourcekit-lsp"]},
\     "whitelist": ["swift"]
\   },
\ }
for [s:executable, s:config] in items(s:language_servers)
  if executable(s:executable)
    lsp#register_server(s:config)
  endif
endfor

function! s:ConfigureLangServer()
  "TODO: expand as I learn more about language servers
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
endfunction

augroup lang_server
  autocmd!
  autocmd User lsp_buffer_enabled call s:ConfigureLangServer()
augroup end
