local M = {}


local set = vim.api.nvim_set_var


function M.init()
  set("startify_session_autoload", 1)
  set("startify_session_persistence", 1)
end


return M
