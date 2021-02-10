local M = {}

M.focus_gained_events = {
}

M.focus_lost_events = {
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
  M.create_group({
    name = "autoresize",
    autocommands = {{
      events = "VimResized",
      patterns = "*",
      cmd = "execute 'normal! \\<C-w>='",
    }},
  })
end

function M.numbering_augroup()
  local focus_gained = {"BufEnter", "FocusGained", "InsertLeave", "UIEnter", "VimEnter", "VimResume", "WinEnter"}
  local focus_lost = {"BufLeave", "FocusLost", "WinLeave"}

  M.create_group({
    name = "numbertoggle",
    autocommands = {
      {
        events = focus_gained,
        patterns = "*",
        cmd = "if &number | setlocal relativenumber | endif",
      },
      {
        events = focus_lost,
        patterns = "*",
        cmd = "setlocal norelativenumber",
      },
    },
  })
end

function M.init()
  M.resizing_augroup()
  M.numbering_augroup()
end

return M
