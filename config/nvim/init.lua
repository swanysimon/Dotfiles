vim.o.comments = ""
vim.o.hidden = true
vim.o.history = 1000
vim.o.include = ""
vim.o.lazyredraw = true
vim.o.timeoutlen = 200

local default_indentation = 2
vim.o.expandtab = true
vim.o.shiftwidth = default_indentation
vim.o.softtabstop = default_indentation

vim.o.cursorline = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = false
vim.o.signcolumn = "no"
vim.o.textwidth = 0

vim.o.joinspaces = false

vim.o.ignorecase = true
vim.o.wildignorecase = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.mouse = "a"
vim.o.clipboard = "unnamed"

require("autocommands").init()
require("colors").init()
require("lsp")
require("mappings").init()
require("statusline")
