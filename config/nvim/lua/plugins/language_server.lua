local augroup = vim.api.nvim_create_augroup("LspActions", {})
vim.api.nvim_clear_autocmds({ group = augroup, })

-- use language server for folding
vim.api.nvim_create_autocmd(
  "LspAttach",
  {
    group = augroup,
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if client:supports_method("textDocument/foldingRange") then
        vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
      end

      if client:supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd(
          "BufWritePre",
          {
            group = augroup,
            buffer = args.buf,
            callback = function()
              if vim.bo.modified then
                vim.lsp.buf.format({ client_id = args.data.client_id, })
              end
            end,
          }
        )
      end
    end,
  }
)

local function set_keymap(client, buffer)

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
        on_attach = set_keymap,
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })
    end,
    dependencies = {
      "dgagn/diagflow.nvim",
      "folke/trouble.nvim",
      "j-hui/fidget.nvim",
      "mason-org/mason.nvim",
      "saghen/blink.cmp",
      "stevearc/dressing.nvim",
    },
  },

  {
    "Olical/conjure",
    event = "VeryLazy",
  },

  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },

}
