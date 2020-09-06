set history=1000

let mapleader=","
let mapleaderlocal="'"

set hidden

set comments=
set include=
set path-=/usr/include

if has("unnamedplus")
  set clipboard^=unnamedplus
elseif has("unnamed")
  set clipboard^=unnamed
endif
