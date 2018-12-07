" leader.vim
" Simon Swanson

if exists('g:loaded_leader_mappings')
    finish
endif
let g:loaded_leader_mappings=1

" navigate buffers faster with Leader-b
nnoremap <Leader>b :<C-U>buffers<CR>:buffer<Space>

" turn off current search highlighting with Leader-h
nnoremap <Leader>h :<C-U>nohlsearch<CR>
vnoremap <Leader>h :<C-U>nohlsearch<CR>gv

" toggle cursorline with Leader-c
nnoremap <Leader>c :<C-U>setlocal cursorline! cursorline?<CR>

" toggle list with Leader-l
nnoremap <Leader>l :<C-U>setlocal list! list?<CR>
vnoremap <Leader>l :<C-U>setlocal list! list?<CR>gv

" toggle line number display with Leader-n
nnoremap <Leader>n :<C-U>setlocal number! number?<CR>
vnoremap <Leader>n :<C-U>setlocal number! number?<CR>gv

" toggle wrapping with Leader-w
nnoremap <Leader>w :<C-U>setlocal wrap! wrap?<CR>
vnoremap <Leader>w :<C-U>setlocal wrap! wrap?<CR>gv

" toggle spellcheck with Leader-s
nnoremap <Leader>s :<C-U>setlocal spell! spell?<CR>

" toggle incremental search with Leader-i
nnoremap <Leader>i :<C-U>setlocal incsearch! incsearch?<CR>

" adjust indentation of last edit with Leader-> or Leader-<
nnoremap <Leader><lt> :<C-U>'[,']<lt><CR>
nnoremap <Leader>> :<C-U>'[,']><CR>

" get preloaded case-insensitive vimgrep command with Leader-/
nnoremap <Leader>/ :<C-U>vimgrep /\c/ **<S-Left><S-Left><Right>

