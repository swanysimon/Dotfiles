local M = {}

function M.treesitter_opts()
  return {
    ensure_installed = "all",
    highlight = { enable = true },
    indent = { enable = true },
    matchup = { enable = true },
  }
end

return M
