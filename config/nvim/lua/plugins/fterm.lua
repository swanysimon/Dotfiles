local map = vim.keymap.set


map("n", "cot", require("FTerm").toggle)
map("t", "<leader>cot", require("FTerm").toggle)
