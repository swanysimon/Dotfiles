local g = vim.g
local map = vim.keymap.set
local opt = vim.opt

-- leader
g.mapleader = ","
g.mapleaderlocal = "'"

-- general editing behavior
opt.hidden = true
opt.timeoutlen = 400
opt.updatetime = 250  -- time to write to swap file, if that ever is enabled

-- system interactions
opt.clipboard = { "unnamed", "unnamedplus", }
opt.mouse = "a"
opt.swapfile = false
opt.title = true

-- appearance
opt.colorcolumn = "+1"
opt.cursorline = true
opt.fillchars = { eob = " ", }  -- disable tildes below last line in buffer
opt.ignorecase = true
opt.laststatus = 3
opt.list = true
opt.number = true
opt.ruler = true
opt.termguicolors = true

-- editing
opt.breakindent = true
opt.expandtab = true
opt.foldlevelstart = 99
opt.shiftround = true
opt.shiftwidth = 2
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true

-- shortcuts for window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- move visual blocks around with J/K/up/down
map("v", "<Down>", ":m '>+1<CR>gv=gv")
map("v", "<Up>", ":m '<-2<CR>gv=gv")
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- keep search terms centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- configure plugins
require("plugin_manager").setup()

-- enable floating terminal
local terminal = require("terminal"):new()
map({"n", "t", "v"}, "<leader>t", function() terminal:toggle() end)
