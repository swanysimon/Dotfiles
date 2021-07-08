local M = {}


function M.set_keymap(mode, trigger, mapping, options)
  local opts = {noremap = true, silent = true}
  if options then
    vim.tbl_extend("force", opts, options)
  end
  vim.api.nvim_set_keymap(mode, trigger, mapping, opts)
end


function M.buf_set_keymap(buf_number, mode, trigger, mapping, options)
  local opts = {noremap = true, silent = true}
  if options then
    vim.tbl_extend("force", opts, options)
  end
  vim.api.nvim_buf_set_keymap(buf_number, mode, trigger, mapping, opts)
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
