function! swanysimon#ft_functions#indent_4()
  setlocal shiftwidth=4
  setlocal softtabstop=4
endfunction


function! swanysimon#ft_functions#nocode()
  call swanysimon#ft_functions#indent_4()
  setlocal concealcursor=nc
  setlocal spell

  " Create undotree entries when doing longer-form writing
  " Credit: https://twitter.com/vimgifs/status/913390282242232320
  inoremap <buffer> ! !<C-g>u
  inoremap <buffer> , ,<C-g>u
  inoremap <buffer> . .<C-g>u
  inoremap <buffer> : :<C-g>u
  inoremap <buffer> ; ;<C-g>u
  inoremap <buffer> ? ?<C-g>u
endfunction


function! swanysimon#ft_functions#wrap()
  setlocal wrap
  setlocal wrapmargin=0
  setlocal nolist

  nnoremap <buffer> j gj
  nnoremap <buffer> k gk
endfunction
