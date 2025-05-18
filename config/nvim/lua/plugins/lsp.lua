local function set_lsp_keymaps(client, bufnr)
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

lsp_group = vim.api.nvim_create_augroup("lsp_attach_and_detach", { clear = true, })
vim.api.nvim_create_autocmd(
  { "LspAttach", },
  {
    group = lsp_group,
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client then
        return
      end

      local bufnr = args.buf
      set_lsp_keymaps(client, bufnr)

      if client:supports_method("textDocument/foldingRange") then
        vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
      end

      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr, })
      end
    end,
  }
)

return {

  {
    "j-hui/fidget.nvim",
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "j-hui/fidget.nvim",
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {},
  },

  {
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    "Olical/conjure",
    ft = "clojure",
  },

}
