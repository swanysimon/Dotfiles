return {

  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    version = "v2.*",
    lazy = true,
  },

  {
    "rafamadriz/friendly-snippets",
    config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
    dependencies = "L3MON4D3/LuaSnip",
    lazy = true,
  },

  {
    "saghen/blink.cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    event = "InsertEnter",
    opts = {
      completion = {
        documentation = { auto_show = true, },
        list = {
          selection = {
            auto_insert = true,
            preselect = false,
          },
        },
      },
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "snippet_forward", "select_next", "fallback", },
        ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback", },
      },
      signature = { enabled = true, },
      snippets = { preset = "luasnip", },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", },
      },
    },
    version = "*",
  },

}
