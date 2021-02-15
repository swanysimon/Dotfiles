local append = require("utils").appendopt
local augroup = require("utils").autocommand_group
local map = require("utils").map
local set = require("utils").setopt


-- leader
vim.g.mapleader = ","
vim.g.mapleaderlocal = "'"


-- fix backwards compatibility bug
map("n", "Y", "y$", { noremap = false })


-- general
append("o", "shortmess", "c", "")
set("o", "hidden", true)
set("o", "lazyredraw", true)
set("o", "timeoutlen", 200)
set("o", "updatetime", 100)


-- appearance
set("o", "background", "dark")
set("o", "laststatus", 2)
set("o", "showtabline", 2)
set("o", "termguicolors", true)
set("o", "title", true)
set("wo", "colorcolumn", "+1")
set("wo", "cursorline", true)
set("wo", "list", true)
set("wo", "listchars", "trail:»,tab:»-")
set("wo", "number", true)
set("wo", "relativenumber", true)
set("wo", "signcolumn", "auto")

vim.cmd("colorscheme gruvbox")

augroup({
  name = "autocolorsync",
  autocommands = {
    {events = "Colorscheme,VimEnter", cmd = "lua require('lualineconfig').sync_lualine()"},
    {events = "Colorscheme,VimEnter", cmd = "lua require('utils').highlight_group('Comment', {style='italic'})"},
  },
})


-- system interactions
set("o", "clipboard", "unnamed,unnamedplus")
set("o", "include", "")
set("o", "mouse", "a")

augroup({
  name = "autoresize",
  autocommands = {{events = "VimResized", cmd = "execute 'normal! \\<C-w>='"}},
})


-- search settings
set("o", "history", 1000)
set("o", "ignorecase", true)
set("o", "incsearch", true)
set("o", "smartcase", true)
set("o", "wildignorecase", true)


-- text manipulation
local default_indentation = 2

set("o", "joinspaces", false)
set("bo", "comments", "")
set("bo", "copyindent", true)
set("bo", "expandtab", true)
set("bo", "shiftwidth", default_indentation)
set("bo", "softtabstop", default_indentation)
set("bo", "textwidth", 0)
set("wo", "breakindent", true)


-- movement
set("o", "scrolljump", 5)
set("o", "splitbelow", true)
set("o", "splitright", true)


-- toggles
map("n", "coh", ":set hlsearch! hlsearch?<CR>")
map("n", "cos", ":setlocal list! list?<CR>")
map("n", "cos", ":setlocal spell! spell?<CR>")
map("n", "cow", ":setlocal wrap! wrap?<CR>")

augroup({
  name = "autonumbertoggle",
  autocommands = {
    {
      events = "BufEnter,FocusGained,InsertLeave,UIEnter,VimEnter,VimResume,WinEnter",
      cmd = "if &number | setlocal relativenumber | endif",
    },
    {events = "BufLeave,FocusLost,WinLeave", cmd = "setlocal norelativenumber"},
  },
})


-- navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")


-- language server
require("lsp").init()
