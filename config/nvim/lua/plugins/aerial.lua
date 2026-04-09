local M = {}

function M.aerial_keys()
  return {
    { "<leader>o",  function() require("aerial").toggle() end },
    { "<leader>so", function() Snacks.picker.aerial() end },
  }
end

function M.aerial_opts()
  return {
    backends = { "lsp", "treesitter" },
    layout = {
      default_direction = "prefer_right",
    },
  }
end

return M
