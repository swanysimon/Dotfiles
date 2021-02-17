local M = {}

function M.sync_lualine()
  local lualine = require("lualine")
  lualine.theme = vim.g.colors_name
  -- TODO: detect if a patched font is active
  lualine.options.icons_enabled = false
  lualine.status()
end

return M
