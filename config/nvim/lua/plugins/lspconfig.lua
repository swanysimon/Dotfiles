local cmp = require("cmp_nvim_lsp")
local fn = vim.fn
local lsp = vim.lsp
local lspconfig = require("lspconfig")
local map = vim.keymap.set
local os = require("os")
local setlocal = vim.api.nvim_buf_set_option
local symbol_types = {"Error", "Hint", "Information", "Warning"}


local servers = {
  clojure_lsp = "clojure-lsp",
  pyright = "pyright",
  rust_analyzer = "rust-analyzer",
  tsserver = "typescript-language-server",
}


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

  setlocal(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  map("n", "gD", vim.lsp.buf.declaration, {buffer = true})
  map("n", "gd", vim.lsp.buf.definition, {buffer = true})
  map("n", "K", vim.lsp.buf.hover, {buffer = true})
  map("n", "gi", vim.lsp.buf.implementation, {buffer = true})
  map("n", "<C-k>", vim.lsp.buf.signature_help, {buffer = true})
  map("n", "<localleader>wa", vim.lsp.buf.add_workspace_folder, {buffer = true})
  map("n", "<localleader>wr", vim.lsp.buf.remove_workspace_folder, {buffer = true})
  map("n", "<localleader>wl", print, {buffer = true})
  map("n", "<localleader>D", vim.lsp.buf.type_definition, {buffer = true})
  map("n", "<localleader>rn", vim.lsp.buf.rename, {buffer = true})
  map("n", "<localleader>ca", vim.lsp.buf.code_action, {buffer = true})
  map("n", "gr", vim.lsp.buf.references, {buffer = true})
  map("n", "<localleader>e", vim.lsp.diagnostic.show_line_diagnostics, {buffer = true})
  map("n", "[d", vim.lsp.diagnostic.goto_prev, {buffer = true})
  map("n", "]d", vim.lsp.diagnostic.goto_next, {buffer = true})
  map("n", "<localleader>q", vim.lsp.diagnostic.set_loclist, {buffer = true})
  map("n", "<localleader>f", vim.lsp.buf.formatting_sync, {buffer = true})
end


-- load servers from the list of known servers if they are currently installed
local capabilities = cmp.default_capabilities()
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
