local M = {}

function M.trouble_keys()
  return {
    { "<leader>dd", "<cmd>Trouble diagnostics toggle<cr>",              mode = "n", },
    { "<leader>dD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", mode = "n", },
    { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",      mode = "n", },
    { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", mode = "n", },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                  mode = "n", },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                   mode = "n", },
  }
end

return M
