local M = {}


-- All overrides for language servers should be put in here
function M.overrides()
  return {}
end


function M.servers()
  return {
    "pyright",
    "rust_analyzer",
  }
end


function M.default_attach(client, bufnr)
  vim.wo.signcolumn = "yes"
  vim.wo.omnifunc = "v:lua.vim.lsp.omnifunc"

  require("completion").on_attach(client)

  local map = require("mappings").buf_set_keymap

  map(0, "i", "<C-n>", "<Plug>(completion_smart_tab)")
  map(0, "i", "<C-p>", "<Plug>(completion_smart_s_tab)")

  map(0, "n", "gd", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  map(0, "n", "gD", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  map(0, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")

  map(0, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
end


function M.enable_servers(servers, overrides)
  lsp = require("lspconfig")
  for _, server in ipairs(servers) do
    local options = {on_attach=default_attach}
    if overrides[server] then
      vim.tbl_extend(options, overrides[server])
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
  M.enable_servers(M.servers(), M.overrides())
  enable_diagnostics()
end


return M
