local M = {}

function M.trouble_keys()
  return {
    {
      "<leader>xx",
      mode = "n",
      "<cmd>Trouble diagnostics toggle<cr>",
    },
    {
      "<leader>xX",
      mode = "n",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    },
    {
      "<leader>cs",
      mode = "n",
      "<cmd>Trouble symbols toggle focus=false<cr>",
    },
    {
      "<leader>cl",
      mode = "n",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    },
    {
      "<leader>xL",
      mode = "n",
      "<cmd>Trouble loclist toggle<cr>",
    },
    {
      "<leader>xQ",
      mode = "n",
      "<cmd>Trouble qflist toggle<cr>",
    },
  }
end

return M
