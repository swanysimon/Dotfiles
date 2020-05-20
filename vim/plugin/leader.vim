" leader.vim
" Global mappings that involve the leader or localleader key.

if exists("g:loaded_my_leader_mappings_plugin")
  finish
endif
let g:loaded_my_leader_mappings_plugin=1

" Leader-b: easier buffer navigation
nnoremap <leader>b :<C-U>buffers<CR>:buffer<Space>

" Leader-h: turn off search highlighting
nnoremap <leader>h :<C-U>nohlsearch<CR>
vnoremap <leader>h :<C-U>nohlsearch<CR>gv

" Leader-s: toggle spell checking
nnoremap <leader>s :<C-U>setlocal spell! spell?<CR>

" Leader-/: easy vimgrep access
nnoremap <leader>/ :<C-U>vimgrep /\c/ **<S-Left><S-Left><Right>
