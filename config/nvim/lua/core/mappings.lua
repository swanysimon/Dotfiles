local map = vim.keymap.set


-- shortcuts for window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")


-- don't copy when pasting over visual selection
map("v", "p", '"_dP')


-- toggle highlighting
map("n", "coh", ":set hlsearch! hlsearch?<cr>")
