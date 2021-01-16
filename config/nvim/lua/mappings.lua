require("./utils")

let("mapleader", ",")
let("mapleaderlocal", "'")

-- Toggle common settings on and off
map("n", "coh", ":set hlsearch hlsearch?<CR>")
map("n", "con", ":setlocal number! number?<CR>")
map("n", "cor", ":setlocal ruler! ruler?<CR>")
map("n", "cos", ":setlocal spell! spell?<CR>")
map("n", "cow", ":setlocal wrap! wrap?<CR>")

-- Fix backwards compatibility bug
map("n", "Y", "y$", { noremap = false })
--

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
--
