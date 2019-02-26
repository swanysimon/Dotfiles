" after/syntax/python.vim

" allow folding on docstrings
syntax region pythonString
    \ start=+[uU]\=\z('''\|"""\)+ end="\z1" keepend fold
    \ contains=pythonEscape,pythonSpaceError,pythonDoctest,@Spell

syntax region pythonRawString
      \ start=+[uU]\=[rR]\z('''\|"""\)+ end="\z1" keepend fold
      \ contains=pythonSpaceError,pythonDoctest,@Spell

