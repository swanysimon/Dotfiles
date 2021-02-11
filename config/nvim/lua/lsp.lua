local M = {}

-- All overrides for language servers should be put in here
M.overrides = {}

M.servers = {
  "rust_analyzer",
}

local function default_attach(client)
  require("completion").on_attach(client)
end

local function enable_servers()
  lsp = require("lspconfig")
  for _, server in ipairs(M.servers) do
    local options = {on_attach=default_attach}
    if M.overrides[server] then
      vim.tbl_extend(options, M.overrides[server])
    end
    lsp[server].setup(options)
  end
end

local function enable_diagnostics()
  local lsp = vim.lsp
  lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(
    lsp.diagnostic.on_publish_diagnostics, {
      signs = true,
      update_in_insert = true,
      virtual_text = true,
    }
  )
end

function M.init()
  if not string.find(vim.o.shortmess, "c") then
    vim.o.shortmess = vim.o.shortmess .. "c"
  end
  vim.o.completeopt = "menuone,noinsert,noselect"

  enable_servers()
  enable_diagnostics()
end

return M
