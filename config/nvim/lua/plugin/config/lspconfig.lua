local cmp = require("cmp_nvim_lsp")
local fn = vim.fn
local lsp = vim.lsp
local lspconfig = require("lspconfig")
local os = require("os")
local servers = require("plugin.langservers")
local symbol_types = {"Error", "Hint", "Information", "Warning"}


-- enable diagnostics
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, {border = "single"})
lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, {border = "single"})
lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(
  lsp.diagnostic.on_publish_diagnostics,
  {
    signs = true,
    underline = true,
    update_in_insert = true,
    virtual_text = true,
  }
)


local function on_attach(_, bufnr)

  local function bufmap(...)
    vim.keymap.set(..., {buffer = true})
  end

  local function setlocal(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end


  setlocal("omnifunc", "v:lua.vim.lsp.omnifunc")

  bufmap("n", "gD", vim.lsp.buf.declaration)
  bufmap("n", "gd", vim.lsp.buf.definition)
  bufmap("n", "K", vim.lsp.buf.hover)
  bufmap("n", "gi", vim.lsp.buf.implementation)
  bufmap("n", "<C-k>", vim.lsp.buf.signature_help)
  bufmap("n", "<localleader>wa", vim.lsp.buf.add_workspace_folder)
  bufmap("n", "<localleader>wr", vim.lsp.buf.remove_workspace_folder)
  bufmap("n", "<localleader>wl", print)
  bufmap("n", "<localleader>D", vim.lsp.buf.type_definition)
  bufmap("n", "<localleader>rn", vim.lsp.buf.rename)
  bufmap("n", "<localleader>ca", vim.lsp.buf.code_action)
  bufmap("n", "gr", vim.lsp.buf.references)
  bufmap("n", "<localleader>e", vim.lsp.diagnostic.show_line_diagnostics)
  bufmap("n", "[d", vim.lsp.diagnostic.goto_prev)
  bufmap("n", "]d", vim.lsp.diagnostic.goto_next)
  bufmap("n", "<localleader>q", vim.lsp.diagnostic.set_loclist)
  bufmap("n", "<localleader>f", vim.lsp.buf.formatting)
end


-- load servers from the list of known servers if they are currently installed
local capabilities = cmp.update_capabilities(lsp.protocol.make_client_capabilities())
for server, executable in pairs(servers) do
  local exit_code = os.execute("command -v " .. executable .. " >/dev/null 2>/dev/null")
  if exit_code == 0 then
    lspconfig[server].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end
end


-- override default symbols in signcolumn
for _, symbol_type in ipairs(symbol_types) do
  fn.sign_define(
    "LspDiagnosticsSign" .. symbol_type,
    {
      numhl = "LspDiagnosticsDefault" .. symbol_type,
      text = " ",
    }
  )
end
