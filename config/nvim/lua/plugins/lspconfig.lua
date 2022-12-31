local server_settings = {
  sumneko_lua = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

local function on_attach(_, bufnr)

  local function map(keys, func)
    vim.keymap.set("n", keys, func, { buffer = bufnr })
  end

  -- navigation
  map("gD", vim.lsp.buf.declaration)
  map("gI", vim.lsp.buf.implementation)
  map("gT", vim.lsp.buf.type_definition)
  map("gd", vim.lsp.buf.definition)
  map("gr", vim.lsp.buf.references)

  -- documentation
  map("<leader>K", vim.lsp.buf.signature_help)
  map("K", vim.lsp.buf.hover)

  -- actions
  map("<leader><cr>", vim.lsp.buf.code_action)
  map("<leader>rn", vim.lsp.buf.rename)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- setup neodev for dotfile work
require("neodev").setup()

-- use mason to manage language servers
require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup()
mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = server_settings[server_name],
    }
  end,
})

-- enable LSP status information
require("fidget").setup()
