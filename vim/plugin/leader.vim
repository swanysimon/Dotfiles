" Leader-b: easier buffer navigation
nnoremap <leader>b :<C-U>buffers<CR>:buffer<Space>

" Leader-h: turn off search highlighting
nnoremap <leader>h :<C-U>nohlsearch<CR>
vnoremap <leader>h :<C-U>nohlsearch<CR>gv

" Leader-s: toggle spell checking
nnoremap <leader>s :<C-U>setlocal spell! spell?<CR>

" Leader-l: toggle ruler
nnoremap <leader>l :<C-U>setlocal ruler! ruler?<CR>
