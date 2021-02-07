local api = vim.api

api.nvim_set_option("background", "dark")
api.nvim_command("colorscheme lucario")

-- Italicize comments. Must be run after loading colorscheme.
api.nvim_command("highlight Comment cterm=italic gui=italic")

-- Search in Lucario is only underlined by default, which isn't super visible
api.nvim_command("highlight Search cterm=bold,italic,underline gui=bold,italic,underline")
