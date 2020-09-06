function! s:dynamiccolorcolumn()
  " Sets the colorcolumn based on the value of &textwidth
  if &textwidth <= 0
    setlocal colorcolumn=
  else
    setlocal colorcolumn=+1
  endif
endfunction


" Automatically set the colorcolumn to be relative to textwidth
augroup colorcolumn
  autocmd!
  autocmd BufEnter * call s:dynamiccolorcolumn()
  autocmd OptionSet textwidth call s:dynamiccolorcolumn()
augroup end
