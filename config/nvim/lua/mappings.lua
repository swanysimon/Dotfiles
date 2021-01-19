local U = require("./utils")

U.let("mapleader", ",")
U.let("mapleaderlocal", "'")

-- Toggle common settings on and off
U.map("n", "coh", ":set hlsearch hlsearch?<CR>")
U.map("n", "con", ":setlocal number! number?<CR>")
U.map("n", "cor", ":setlocal ruler! ruler?<CR>")
U.map("n", "cos", ":setlocal spell! spell?<CR>")
U.map("n", "cow", ":setlocal wrap! wrap?<CR>")

-- Fix backwards compatibility bug
U.map("n", "Y", "y$", { noremap = false })
--

-- Window navigation
U.map("n", "<C-h>", "<C-w>h")
U.map("n", "<C-j>", "<C-w>j")
U.map("n", "<C-k>", "<C-w>k")
U.map("n", "<C-l>", "<C-w>l")
--

-- Map ESC to exit terminal's insert mode
U.map("t", "ESC", "<C-\\><C-n>")
--
