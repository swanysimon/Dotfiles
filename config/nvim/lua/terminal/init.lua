local map = vim.keymap.set

local term_config = require("terminal.terminal")
local term = term_config:new()

map({"n", "t", "v"}, "<leader>t", function() term:toggle() end)
