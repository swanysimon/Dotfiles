local M = {}

function M.statusline()
  require("lualine").setup {
    options = {
      -- TODO: detect if a patched font is active
      icons_enabled = false,
      theme = vim.g.colors_name,
    },
  }
end

return M
