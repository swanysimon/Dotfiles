local M = {}


local function _map(set_keymap_fn, mode, keys, command, options)
  local opts = {noremap = true, silent = true}
  if options then
    vim.tbl_extend("force", opts, options)
  end

  set_keymap_fn(mode, keys, command, opts)
end


function M.map(mode, keys, command, options)
  _map(vim.api.nvim_set_keymap, mode, keys, command, opts)
end


function M.bufmap(bufnr, mode, keys, command, options)

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  _map(buf_set_keymap, mode, keys, command, opts)
end


return M
