local function lsp_settings(_, buffer)

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
      })
    end,
  })
end

local event = {
  "BufNewFile",
  "BufReadPre",
  "InsertEnter",
}


return {

  {
    "dgagn/diagflow.nvim",
    event = event,
    opts = {},
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = event,
    opts = {},
  },

  {
    "j-hui/fidget.nvim",
    event = event,
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
    config = setup,
    dependencies = {
      "dgagn/diagflow.nvim",
      "folke/trouble.nvim",
      "j-hui/fidget.nvim",
      "stevearc/dressing.nvim",
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
    },
    event = event,
  },

  {
    "stevearc/dressing.nvim",
    event = event,
    opts = {},
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = event,
    opts = {},
  },

  {
    "williamboman/mason.nvim",
    event = event,
    opts = {},
  },

}
