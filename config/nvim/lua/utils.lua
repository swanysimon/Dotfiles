local M = {}


function M.setopt(scope, option, value)
  if scope ~= "o" then
    vim[scope][option] = value
  end
  vim.o[option] = value
end


function M.appendopt(scope, option, value, delimiter)
  local current_value = vim[scope][option]
  if not current_value or not string.find(current_value, value) then
    M.setopt(scope, option, current_value .. delimiter .. value)
  end
end


function M.set_keymap(mode, trigger, mapping, options)
  local opts = {noremap = true, silent = true}
  if options then
    vim.tbl_extend("force", opts, options)
  end
  vim.api.nvim_set_keymap(mode, trigger, mapping, opts)
end


function M.buf_set_keymap(mode, trigger, mapping, options)
  local opts = {noremap = true, silent = true}
  if options then
    vim.tbl_extend("force", opts, options)
  end
  vim.api.nvim_buf_set_keymap(0, mode, trigger, mapping, opts)
end


function M.autocommand_group(group)
  vim.cmd("augroup " .. group.name)
  vim.cmd("autocmd!")

  for _, cmd in ipairs(group.autocommands) do
    local patterns = cmd.patterns
    if not patterns then
      patterns = "*"
    end
    vim.cmd(table.concat({"autocmd", cmd.events, patterns, cmd.cmd}, " "))
  end

  vim.cmd("augroup end")
end


local function highlight_cmd_part(config, key, fallback_key)
  local value = config[key]
  if not value then
    value = config[fallback_key]
  end

  if not value then
    return {}
  end

  return key .. "=" .. value
end


function M.highlight_group(group, config)
  local command = {"highlight!", group}
  table.insert(command, highlight_cmd_part(config, "ctermfg", "fg"))
  table.insert(command, highlight_cmd_part(config, "guifg", "fg"))
  table.insert(command, highlight_cmd_part(config, "ctermbg", "bg"))
  table.insert(command, highlight_cmd_part(config, "guibg", "bg"))
  table.insert(command, highlight_cmd_part(config, "cterm", "style"))
  table.insert(command, highlight_cmd_part(config, "gui", "style"))
  vim.cmd(table.concat(vim.tbl_flatten(command), " "))
end


function M.highlight_link(group, link_to)
  vim.cmd("highlight! link " .. group .. " " .. link_to)
end


function M.default_highlighting()
  M.highlight("Comment", {style="italic"})
  M.highlight("Search", {style="bold,italic,underline"})
end


return M