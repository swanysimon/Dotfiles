local M = {}

function M.create(name, definitions)
  vim.api.nvim_command("augroup " .. name)
  vim.api.nvim_command("autocmd!")

  for _, def in ipairs(definitions) do
    local command = table.concat(vim.tbl_flatten{"autocmd", def}, " ")
    vim.api.nvim_command(command)
  end

  vim.api.nvim_command("augroup end")
end

function M.init()
  M.augroup("resizing", { { "VimResized", "*", "execute 'normal! \\<C-w>='", }, })
end

return M
