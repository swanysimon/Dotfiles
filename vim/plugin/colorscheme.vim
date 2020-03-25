" colorscheme.vim
" For managing my colorscheme

if !has('syntax')
    || exists('g:syntax_on')
    || exists('g:loaded-colorscheme-plugin')
  finish
endif
let g:loaded-colorscheme-plugin=1

syntax enable
set background=dark

try
  colorscheme darcula
catch
  echo "Failed to load colorcheme 'darcula'"
endtry
