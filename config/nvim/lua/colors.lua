local M = {}

local api = vim.api

function M.highlight_group_values(group)
  local values = {}
  values.group = group

  local output = api.nvim_eval("highlight " .. group)
  for property, value in string.gmatch(output, "(%w+)=(%w+)") do
    values[property] = value
  end

  return values
end

local function command_part(config, key, fallback_key)
  local value = config[key]
  if not value then
    value = config[fallback_key]
  end

  if not value then
    return {}
  end

  return key .. "=" .. value
end

function M.highlight(group, config)
  local command = {"highlight", group}
  table.insert(command, command_part(config, "ctermfg", "fg"))
  table.insert(command, command_part(config, "guifg", "fg"))
  table.insert(command, command_part(config, "ctermbg", "bg"))
  table.insert(command, command_part(config, "guibg", "bg"))
  table.insert(command, command_part(config, "cterm", "style"))
  table.insert(command, command_part(config, "gui", "style"))

  api.nvim_command(table.concat(vim.tbl_flatten(command), " "))
end

function M.highlight_link(group, link_to)
  api.nvim_command("highlight! link " .. group .. " " .. link_to)
end

function M.lucario()
  api.nvim_command("colorscheme gruvbox")
  M.highlight("Comment", {style="italic"})
  M.highlight("Search", {style="bold,italic,underline"})
end

function M.init()
  vim.o.background = "dark"
  M.lucario()
end

return M
