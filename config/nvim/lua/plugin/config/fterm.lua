local map = require("core.utils").map


local toggle_cmd = "<cmd>lua require('FTerm').toggle()<cr>"
map("n", "cot", toggle_cmd)
map("t", "<leader>cot", toggle_cmd)
