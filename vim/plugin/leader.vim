" leader.vim
" Mappings that involve the leader or localleader key.

if exists("g:loaded_my_leader_mappings_plugin")
  finish
endif
let g:loaded_my_leader_mappings_plugin=1

" Leader-b: easier buffer navigation
nnoremap <Leader>b :<C-U>buffers<CR>:buffer<Space>

" Leader-h: turn off search highlighting
nnoremap <Leader>h :<C-U>nohlsearch<CR>
vnoremap <Leader>h :<C-U>nohlsearch<CR>gv

" Leader-s: toggle spell checking
nnoremap <Leader>s :<C-U>setlocal spell! spell?<CR>

" Leader-/: easy vimgrep access
nnoremap <Leader>/ :<C-U>vimgrep /\c/ **<S-Left><S-Left><Right>
