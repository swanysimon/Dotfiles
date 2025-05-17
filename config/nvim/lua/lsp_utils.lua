local M = {}

function M.set_default_keymaps(client, bufnr)
  local function map(keys, func)
    vim.keymap.set("n", keys, func, { buffer = bufnr })
  end

  local lsp = vim.lsp.buf

  -- navigation
  map("gD", lsp.declaration)
  map("gd", lsp.definition)
  map("gi", lsp.implementation)
  map("gr", lsp.references)
  map("gt", lsp.type_definition)

  -- documentation
  map("<leader>K", lsp.signature_help)
  map("K", lsp.hover)

  -- actions
  map("<leader><cr>", lsp.code_action)
  map("<leader>rn", lsp.rename)
end

function M.on_attach(client, bufnr)
  M.set_default_keymaps(client, bufnr)
end

return M
