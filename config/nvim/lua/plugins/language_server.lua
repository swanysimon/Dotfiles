local augroup = vim.api.nvim_create_augroup("LspFormat", {})

local function lsp_settings(client, buffer)

  vim.api.nvim_clear_autocmds({ group = augroup, buffer = buffer, })
  vim.api.nvim_create_autocmd(
    "BufWritePre",
    {
      group = augroup,
      buffer = buffer,
      callback = function()
        if client.supports_method("textDocument/formatting") then
          vim.lsp.buf.format()
        end
      end,
    })

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


local function setup(_, options)
  require("mason-lspconfig").setup_handlers({
    function(server_name)
      require("lspconfig")[server_name].setup({
        on_attach = lsp_settings,
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })
    end,
  })
end

return {

  {
    "dgagn/diagflow.nvim",
    event = "VeryLazy",
    opts = {},
  },

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
    "neovim/nvim-lspconfig",
    config = setup,
    dependencies = {
      "dgagn/diagflow.nvim",
      "folke/trouble.nvim",
      "j-hui/fidget.nvim",
      "saghen/blink.cmp",
      "stevearc/dressing.nvim",
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
    },
    event = "VeryLazy",
  },

  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    opts = {},
  },

}
