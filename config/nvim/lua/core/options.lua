local opt = vim.opt
local g = vim.g

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
