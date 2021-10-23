local map = require("core.utils").map


-- shortcuts for window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")


-- -- fix backwards compatibility bug
map("n", "Y", "y$", {noremap = false})


-- -- don't copy when pasting over visual selection
map("v", "p", '"_dP')
