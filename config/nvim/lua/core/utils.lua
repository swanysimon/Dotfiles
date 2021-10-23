local M = {}


function M.map(mode, keys, command, options)
  local opts = {noremap = true, silent = true}
  if options then
    vim.tbl_extend("force", opts, options)
  end

  vim.api.nvim_set_keymap(mode, keys, command, opts)
end


return M
