local os = require("os")
local wo = vim.wo
local bo = vim.bo
local lspconfig = require("lspconfig")


local servers = {
  hls = "haskell-language-server-wrapper",
  pyright = "pyright",
  rust_analyzer = "rust-analyzer",
}


local function default_attach(client, bufnr)
  wo.signcolumn = "yes"
  bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  local function bufmap(...)
    require("utils").buf_set_keymap(bufnr, ...)
  end

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


for server, executable in pairs(servers) do
  local exit_code = os.execute("command -v " .. executable .. " >/dev/null 2>/dev/null")
  if exit_code == 0 then
    lspconfig[server].setup {on_attach = default_attach}
  end
end

enable_diagnostics()
