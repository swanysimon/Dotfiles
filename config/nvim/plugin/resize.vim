" Autoresize splits when the window running vim is resized
augroup resizing
  autocmd!
  autocmd VimResized * execute "normal! \<C-w>="
augroup end
