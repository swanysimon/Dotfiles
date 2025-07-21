local M = {}

function M.floaterm_keys()
  return {
    {
      "<leader>t",
      mode = { "n", "t", "v" },
      function() require("floaterm").toggle() end,
    },
  }
end

function M.floaterm_opts()
  return {
    size = { h = 75, w = 85, },
  }
end

return M
