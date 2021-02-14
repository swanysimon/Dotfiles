local M = {}

function M.sync_lualine()
  local lualine = require("lualine")
  lualine.theme = vim.g.colors_name
  lualine.status()
end

return M
