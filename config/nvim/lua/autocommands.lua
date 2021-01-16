local U = require("utils")

U.augroup(
  "resizing",
  {
    { "VimResized", "*", "execute 'normal! \\<C-w>='", },
  }
)
