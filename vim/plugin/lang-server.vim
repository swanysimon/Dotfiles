" lang-server.vim
" Adds configurations to the language server.

if exists("g:loaded_my_lang_server_plugin")
  finish
endif
let g:loaded_my_lang_server_plugin=1

let s:sourcekitServerConfig = {
        \ "name": "sourcekit-lsp",
        \ "cmd": lsp_settings#exec_path("sourcekit-lsp"),
        \ "root_uri": lsp_settings#root_uri([
              \ "Package.swift",
              \ ".xcodeproj",
              \ ".xcworkspace",
              \ "Cartfile",
              \ "Podfile",
              \ ])
        \ "initialization_options": {},
        \ "whitelist": ["swift"],
        \ "blacklist": [],
        \ "config": lsp_settings#server_config("sourcekit-lsp"),
        \ "workspace_config": {},
        \ }

function! s:ConfigureLangServer()
  "TODO: expand as I learn more about language servers
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=number

  " Language server control folding
  setlocal foldmethod=expr
  setlocal foldexpr=lsp#ui#vim#folding#foldexpr()
  setlocal foldtext=lsp#ui#vim#folding#foldtext()

  " mappings I know I want
  "
  " lbs-code-action
  " lsp-hover
  " lsp-rename
  "
  " lsp-declaration
  " lsp-peek-declaration
  " lsp-definition
  " lsp-peek-definition
  " lsp-implementation
  " lsp-peek-implementation
  " lsp-type-definition
  " lsp-peek-type-definition
  " lsp-next-reference
  " lsp-previous-reference
  " lsp-references
  " lsp-type-hierarchy
  "
  " lsp-next-diagnostic
  " lsp-previous-diagnostic
  " lsp-next-error
  " lsp-previous-error
endfunction

function! s:RegisterServer(server)
  if !executable(a:server.cmd[0])
    return
  endif

  call lsp#register_server({
        \ "name": a:server.name,
        \ "cmd": {server_info->s:ConfigValue(a:server, "cmd")},
        \ "root_uri": {server_info->s:ConfigValue(a:server, "root_uri")},
        \ "initialization_options": s:ConfigValue(a:server, "initialization_options"),
        \ "whitelist": s:ConfigValue(a:server, "whitelist"),
        \ "blacklist": s:ConfigValue(a:server, "blacklist"),
        \ "config": s:ConfigValue(a:server, "config"),
        \ "workspace_config": s:ConfigValue(a:server, "workspace_config"),
        \ })
endfunction

function s:ConfigValue(server, config_key)
  return lsp_settings#get(a:server.name, a:config_key, a:server[a:config_key])
endfunction

augroup lang_server
  autocmd!
  autocmd User lsp_buffer_enabled call s:ConfigureLangServer()
  autocmd User lsp_setup call s:RegisterServer(s:sourcekitServerConfig)
augroup end
