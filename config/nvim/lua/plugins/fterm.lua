local map = require("utils").set_keymap

map("n", "cof", "<cmd>lua require('FTerm').toggle()<cr>")
map("t", "<leader>cof", "<cmd>lua require('FTerm').toggle()<cr>")
