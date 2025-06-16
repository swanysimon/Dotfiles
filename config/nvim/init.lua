local g = vim.g
local map = vim.keymap.set
local opt = vim.opt

-- leader
g.mapleader = ","
g.mapleaderlocal = "'"

-- system interactions
opt.clipboard = { "unnamed", "unnamedplus", }
opt.swapfile = false
opt.timeoutlen = 400

-- appearance
opt.colorcolumn = "+1"
opt.cursorline = true
opt.fillchars = { eob = " " } -- disable tildes below last line in buffer
opt.ignorecase = true
opt.list = true
opt.number = true
opt.termguicolors = true

-- editing
opt.breakindent = true
opt.expandtab = true
opt.foldcolumn = "0"
opt.foldenable = true
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldtext = ""
opt.shiftround = true
opt.shiftwidth = 4
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


-- display diagnostics
vim.diagnostic.config({
  virtual_lines = { severity = { min = "ERROR", }, },
  virtual_text  = {
    severity = {
      current_line = true,
      min = "INFO",
      max = "WARN",
    },
  },
  severity_sort = true,
})

-- configure plugins and autocmds
require("plugin_manager")
require("autocmds")
