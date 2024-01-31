local function lsp_settings(_, bufnr)
  local lsp = vim.lsp.buf

  local function map(keys, func)
    vim.keymap.set("n", keys, func, { buffer = bufnr })
  end

  -- navigation
  map("gD", lsp.declaration)
  map("gI", lsp.implementation)
  map("gT", lsp.type_definition)
  map("gd", lsp.definition)
  map("gr", lsp.references)

  -- documentation
  map("<leader>K", lsp.signature_help)
  map("K", lsp.hover)

  -- actions
  map("<leader><cr>", lsp.code_action)
  map("<leader>rn", lsp.rename)
end


local function setup(_)
  require("fidget").setup({})
  require("mason").setup()
  require("neodev").setup()

  require("mason-lspconfig").setup_handlers({
    function(server_name)
      require("lspconfig")[server_name].setup {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        on_attach = lsp_settings,
      }
    end,
  })
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
    event = { "BufReadPre", "BufNewFile", "InsertEnter", },
    config = function(_, opts) setup(opts) end,
  },
}
