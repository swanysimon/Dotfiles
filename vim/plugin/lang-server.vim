" lang-server.vim
" Adds configurations to the language server.

if exists("g:loaded_my_lang_server_plugin")
  finish
endif
let g:loaded_my_lang_server_plugin=1

function! s:ConfigureLangServer()

  setlocal omnifunc=lsp#complete

  " Language server control folding
  setlocal foldmethod=expr
  setlocal foldexpr=lsp#ui#vim#folding#foldexpr()
  setlocal foldtext=lsp#ui#vim#folding#foldtext()

  " language server mappings
  nmap <buffer> <leader>r <plug>(lsp-rename)

  nmap <buffer> <leader><Enter> <plug>(lsp-code-action)

  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> <leader>d <plug>(lsp-hover)

  nmap <buffer> gt <plug>(lsp-type-definition)

  nmap <buffer> ga <plug>(lsp-next-diagnostic)
  nmap <buffer> gA <plug>(lsp-previous-diagnostic)

  nmap <buffer> ge <plug>(lsp-next-error)
  nmap <buffer> gE <plug>(lsp-previous-error)

  " more mappings to explore
  "
  " lsp-declaration
  " lsp-implementation
  " lsp-type-definition
  " lsp-next-reference
  " lsp-previous-reference
  " lsp-references
  " lsp-type-hierarchy
  " lsp-next-error
endfunction

function! s:ShowDocumentation()

endfunction

function! s:RegisterPythonServer()
  if executable("pyls")
    call lsp#register_server({
          \ "name": "pyls",
          \ "cmd": {server_info->["pyls"]},
          \ "whitelist": ["python"],
          \ })
  endif
endfunction

function! s:RegisterSourcekitServer()
  if executable("sourcekit-lsp")
    call lsp#register_server({
          \ "name": "sourcekit-lsp",
          \ "cmd": {server_info->["sourcekit-lsp"]},
          \ "whitelist": ["swift"],
          \ })
  endif
endfunction

augroup lang_server
  autocmd!
  autocmd User lsp_buffer_enabled call s:ConfigureLangServer()
  autocmd User lsp_setup call s:RegisterPythonServer()
  autocmd User lsp_setup call s:RegisterSourcekitServer()
augroup end
