return {

  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },

  {
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("*", {
        on_attach = require("lsp_utils").on_attach,
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })
    end,
    dependencies = {
      "j-hui/fidget.nvim",
      "mason-org/mason.nvim",
      "saghen/blink.cmp",
    },
  },

  {
    "Olical/conjure",
    event = "VeryLazy",
  },

}
