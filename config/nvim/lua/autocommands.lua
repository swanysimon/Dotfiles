local M = {}

M.focus_gained_events = {
  "BufEnter",
  "FocusGained",
  "UIEnter",
  "VimEnter",
  "VimResume",
  "WinEnter",
}

M.focus_lost_events = {
  "BufLeave",
  "FocusLost",
  "WinLeave",
}

function M.create_group(group)
  vim.api.nvim_command("augroup " .. group.name)
  vim.api.nvim_command("autocmd!")

  for _, autocommand in ipairs(group.autocommands) do
    M.create_autocommand(autocommand)
  end

  vim.api.nvim_command("augroup end")
end

function M.create_autocommand(autocommand)
  if type(autocommand) == "string" then
    vim.api.nvim_command(autocommand)
    return
  end

  local events = autocommand.events
  if type(autocommand.events) == "table" then
    events = table.concat(autocommand.events, ",")
  end

  local patterns = autocommand.patterns
  if type(autocommand.patterns) == "table" then
    patterns = table.concat(autocommand.patterns, ",")
  end

  local command = {
    "autocmd",
    events,
    patterns,
    autocommand.cmd,
  }
  vim.api.nvim_command(table.concat(command, " "))
end

function M.resizing_augroup()
  local resize_cmd = {}
  resize_cmd.events = "VimResized"
  resize_cmd.patterns = "*"
  resize_cmd.cmd = "execute 'normal! \\<C-w>='"

  local group = {}
  group.name = "resizing"
  group.autocommands = { resize_cmd, }

  M.create_group(group)
end

function M.numbering_augroup()
  local focus_gained_cmd = {}
  focus_gained_cmd.events = vim.tbl_flatten({ M.focus_gained_events, "InsertLeave", })
  focus_gained_cmd.patterns = "*"
  focus_gained_cmd.cmd = "if &number | setlocal relativenumber | endif"

  local focus_lost_cmd = {}
  focus_lost_cmd.events = vim.tbl_flatten({ M.focus_lost_events, "InsertEnter", })
  focus_lost_cmd.patterns = "*"
  focus_lost_cmd.cmd = "if &number | setlocal norelativenumber | endif"

  local group = {}
  group.name = "numbertoggle"
  group.autocommands = { focus_gained_cmd, focus_lost_cmd, }

  M.create_group(group)
end

function M.init()
  M.resizing_augroup()
  M.numbering_augroup()
end

return M
