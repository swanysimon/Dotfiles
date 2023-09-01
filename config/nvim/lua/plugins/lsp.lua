local function lsp_settings(_, bufnr)

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

local function setup(options)
  local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

  require("neodev").setup()
  require("mason").setup()
  local lspconfig = require("mason-lspconfig")

  lspconfig.setup()
  lspconfig.setup_handlers({
    function(server_name)
      require("lspconfig")[server_name].setup {
        capabilities = capabilities,
        on_attach = lsp_settings,
        settings = {},
      }
    end,
  })

  require("fidget").setup()
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/neodev.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "j-hui/fidget.nvim",
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
    },
    event = "VeryLazy",
    config = function(_, opts) setup(opts) end,
  },
}
