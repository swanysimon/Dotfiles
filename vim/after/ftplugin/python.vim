" ftplugin/python.vim

" PEP-8 line lengths
setlocal textwidth=79
setlocal colorcolumn=80

" to help with line lengths, turn on the ruler
setlocal ruler

" there is some documented bad interactions with smartindent in python
setlocal nosmartindent

" folding is enabled for python files and can be done via syntax
setlocal foldenable
setlocal foldlevel=2
setlocal foldmethod=syntax
setlocal foldnestmax=2

" enable jedi for python
packadd! jedi-vim

