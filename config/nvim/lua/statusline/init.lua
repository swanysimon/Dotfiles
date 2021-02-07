local M = {}

-- function M.active_statusline()
--   local left_side = load_section(
--   U.setlocal("statusline", )
-- end

-- function M.inactive_statusline()
-- end

-- local operations = {}
-- operations.activate = "lua require('statusline').active_statusline()"
-- operations.deactivate = "lua require('statusline').inactive_statusline()"

-- local events = {}
-- events.BufEnter = "activate"
-- events.BufLeave = "deactivate"
-- events.BufReadPost = "activate"
-- events.BufWinEnter = "activate"
-- events.BufWritePost = "activate"
-- events.ColorScheme = "activate"
-- events.FileChangedShellPost = "activate"
-- events.FileType = "activate"
-- events.TermOpen = "activate"
-- events.VimResized = "activate"
-- events.WinEnter = "activate"

-- local autocommands = {}
-- for event, op in ipairs(events) do
--   table.insert(autocommands, {event, "*", operations[op],})
-- end

-- U.augroup("statusline", autocommands)
-- U.set("laststatus", 2)
-- U.set("statusline", "lua require('statusline').activate_statusline()")

return M
