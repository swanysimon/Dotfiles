local cmp = require("cmp_nvim_lsp")
local coreutils = require("core.utils")
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
    virtual_text = {
      prefix = " ",
      spacing = 0,
    },
  }
)


local function on_attach(_, bufnr)

  local function bufmap(...)
    coreutils.bufmap(bufnr, ...)
  end

  local function setlocal(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end


  setlocal("omnifunc", "v:lua.vim.lsp.omnifunc")

  bufmap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
  bufmap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
  bufmap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  bufmap('n', '<localleader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
  bufmap('n', '<localleader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
  bufmap('n', '<localleader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
  bufmap('n', '<localleader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  bufmap('n', '<localleader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  bufmap('n', '<localleader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  bufmap('n', '<localleader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
  bufmap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
  bufmap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
  bufmap('n', '<localleader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
  bufmap("n", "<localleader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
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
