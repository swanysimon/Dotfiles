-- aliases
local cmd = vim.cmd
local let = vim.g
local opt = vim.opt
local map = require("utils").set_keymap


-- load plugins
require("plugins")


-- leader
let.mapleader = ","
let.mapleaderlocal = "'"


-- fix backwards compatibility bug
map("n", "Y", "y$", { noremap = false })


-- shortcuts for navigating between buffers
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")


-- move by visual lines by default
map("n", "gj", "j")
map("n", "gk", "k")
map("n", "j", "gj")
map("n", "k", "gk")


-- toggle highlighting
map("n", "coh", ":set hlsearch! hlsearch?<CR>")


-- general editor behavior
opt.hidden = true
opt.history = 10000
opt.include = ""
opt.lazyredraw = true
opt.shortmess = "filnxtToOFc"
opt.timeoutlen = 200


-- search and completion behavior
opt.completeopt = {"menuone", "noinsert", "noselect"}
opt.ignorecase = true
opt.incsearch = true
opt.wildignorecase = true
opt.wildmode = {"list", "longest"}


-- text manipulation
opt.joinspaces = false
opt.comments = ""
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 2
opt.softtabstop = -1
opt.breakindent = true


-- appearance
opt.background = "dark"
opt.laststatus = 2
opt.showtabline = 2
opt.termguicolors = true
opt.title = true
opt.colorcolumn = "+1"
opt.cursorline = true
opt.list = true
opt.listchars = "trail:»,tab:»-"
opt.number = true
opt.relativenumber = true
opt.signcolumn = "auto"
opt.splitbelow = true
opt.splitright = true
opt.wrap = true


-- system interactions
opt.clipboard = {"unnamed", "unnamedplus"}
opt.mouse = "a"
opt.sessionoptions = {"buffers", "curdir", "folds", "tabpages"}


-- load autocommands
require("autocmds")


-- completion
let.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}


-- load modules dependent on plugins
cmd("colorscheme gruvbox")
require("plugins.lsp")
require("plugins.startify")
require("plugins.telescope").setup()
