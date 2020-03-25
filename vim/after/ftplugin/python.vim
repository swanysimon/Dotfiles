" ftplugin/python.vim

" PEP-8 line lengths
setlocal textwidth=79
setlocal colorcolumn=80

" there is some documented bad interactions with smartindent in python
setlocal nosmartindent

setlocal foldenable
setlocal foldlevel=1

" enable jedi for python
packadd! jedi-vim

