" ftplugin/python.vim

" PEP-8 line lengths
setlocal textwidth=80

" there is some documented bad interactions with smartindent in python
setlocal nosmartindent

" folding is enabled for python files
setlocal foldenable

" with my after/syntax file I want to fold on syntax so I get docstring folding
setlocal foldmethod=syntax

