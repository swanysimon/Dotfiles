local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local g = vim.g
local map = vim.keymap.set
local opt = vim.opt

-- leader
g.mapleader = ","
g.mapleaderlocal = "'"

-- general editing behavior
opt.hidden = true
opt.lazyredraw = true
opt.timeoutlen = 400
opt.updatetime = 250  -- time to write to swap file

-- system interactions
opt.clipboard = {"unnamed", "unnamedplus"}
opt.mouse = "a"
opt.swapfile = false
opt.title = true
opt.undofile = true

-- appearance
opt.cmdheight = 1
opt.colorcolumn = "+1"
opt.cursorline = true
opt.fillchars = {eob = " "}  -- disable tildes below last line in buffer
opt.laststatus = 3
opt.list = true
opt.number = true
opt.ruler = false
opt.signcolumn = "yes"
opt.termguicolors = true

-- editing
opt.breakindent = true
opt.completeopt = {"menu", "menuone", "noselect"}  -- necessary for completion engine
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 2
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.whichwrap:append "<>[]hl"  -- navigate lines with left/right arrows or h/l

-- shortcuts for window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- don't copy when pasting over visual selection
map("v", "p", '"_dP')

-- toggle highlighting
map("n", "coh", ":set hlsearch! hlsearch?<CR>")

-- move visual blocks around with J and K
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '>-2<CR>gv=gv")

-- keep search terms centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- disable line numbers in terminal and set floating terminal to correct filetype
autocmd("TermOpen", {
  group = augroup("Terminal", {clear = true}),
  pattern = "term://*",
  callback = function()
    setfiletype = "terminal"
    vim.wo.number = false
    vim.wo.relativenumber = false
  end,
})
