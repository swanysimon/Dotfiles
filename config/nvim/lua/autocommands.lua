require("utils")

augroup(
  "resizing",
  {
    { "VimResized", "*", "execute 'normal! \\<C-w>='", },
  }
)
