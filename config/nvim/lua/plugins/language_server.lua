local function configure_lsp(client, buffer)
  require("autocmds").lsp_format_on_save(client, buffer)

  local function map(keys, func)
    vim.keymap.set("n", keys, func, { buffer = buffer })
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

return {

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    opts = {},
  },

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
        on_attach = configure_lsp,
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })
    end,
    dependencies = {
      "folke/trouble.nvim",
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
