local M = {}


function M.init()
  vim.g.startify_session_autoload = true
  vim.g.startify_session_persistence = true
  vim.g.startify_skiplist = {
    "/dev/null",
  }
end


return M
