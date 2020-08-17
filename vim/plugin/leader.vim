" leader.vim
" Global mappings that involve the leader or localleader key.

let b:this_file_hash=checksum#Sha256(expand("%:p"))
if exists("g:loaded_my_leader_plugin")
  if g:loaded_my_leader_plugin == b:this_file_hash
    finish
  endif
endif
let g:loaded_my_leader_plugin=b:this_file_hash

" Leader-b: easier buffer navigation
nnoremap <leader>b :<C-U>buffers<CR>:buffer<Space>

" Leader-h: turn off search highlighting
nnoremap <leader>h :<C-U>nohlsearch<CR>
vnoremap <leader>h :<C-U>nohlsearch<CR>gv

" Leader-s: toggle spell checking
nnoremap <leader>s :<C-U>setlocal spell! spell?<CR>

" Leader-l: toggle ruler
nnoremap <leader>l :<C-U>setlocal ruler! ruler?<CR>
