local U = require("utils")

U.set("background", "dark")
vim.api.nvim_command("colorscheme lucario")

-- Italicize comments. Must be run after loading colorscheme.
vim.api.nvim_command("highlight Comment cterm=italic gui=italic")

-- Search in Lucario is only underlined by default, which isn't super visible
vim.api.nvim_command("highlight Search cterm=bold,italic,underline gui=bold,italic,underline")
