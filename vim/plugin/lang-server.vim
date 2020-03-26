" lang-server.vim
" Adds configurations to the language server.

if exists("g:loaded_my_lang_server_plugin")
  finish
endif
let g:loaded_my_lang_server_plugin=1

let s:language_servers = {"sourcekit-lsp": ["swift"], "pyls": ["python"]}

function! s:RegisterServers()
  for [s:executable, s:languages] in items(s:language_servers)
    if executable(s:executable)
      call lsp#register_server({
            \ "name": s:executable,
            \ "cmd": {server_info->[s:executable]},
            \ "whitelist": s:languages,
            \ })
    else
      echo "Executable not found " s:executable
    endif
  endfor
endfunction

function! s:ConfigureLangServer()
  "TODO: expand as I learn more about language servers
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=number

  " Language server control folding
  setlocal foldmethod=expr
  setlocal foldexpr=lsp#ui#vim#folding#foldexpr()
  setlocal foldtext=lsp#ui#vim#folding#foldtext()
endfunction

augroup lang_server
  autocmd!
  autocmd User lsp_buffer_enabled call s:ConfigureLangServer()
  autocmd User lsp_setup call s:RegisterServers()
augroup end
