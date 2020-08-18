function! swanysimon#functions#setindentation(indentation)
  " handles indentation levels without having to remember which 2 to set
  setlocal shiftwidth=2
  setlocal softtabstop=2
endfunction

function! swanysimon#functions#nocode()
  " convenience for when you're writing in longer bursts
  setlocal concealcursor=nc
  setlocal spell

  " Credit: https://twitter.com/vimgifs/status/913390282242232320
  inoremap <buffer> ! !<C-g>u
  inoremap <buffer> , ,<C-g>u
  inoremap <buffer> . .<C-g>u
  inoremap <buffer> : :<C-g>u
  inoremap <buffer> ; ;<C-g>u
  inoremap <buffer> ? ?<C-g>u
endfunction

function! swanysimon#functions#wrap()
  " if wrapping is desired, this provides some nicer things
  setlocal wrap
  setlocal wrapmargin=0
  setlocal nolist

  nnoremap <buffer> j gj
  nnoremap <buffer> k gk
endfunction

function! swanysimon#functions#dynamiccolorcolumn()
  " Bases the color column on the value of textwidth. For multiple columns, set
  " textwidth before adding to the colorcolumn list
  if &textwidth <= 0
    setlocal colorcolumn=
  else
    setlocal colorcolumn=+1
  endif
endfunction
