function! swanysimon#colorcolumn#totextwidth()
  if &textwidth <= 0
    setlocal colorcolumn=
  else
    setlocal colorcolumn=+1
  endif
endfunction
