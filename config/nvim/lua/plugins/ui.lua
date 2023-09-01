local function setup(options)
  require("noice").setup({
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = false,
    },
    views = {
      cmdline_popup = { position = { row = "40%", }, },
    },
    -- don't require nerd fonts
    cmdline = {
      format = {
        cmdline = { icon = ">" },
        search_down = { icon = "🔍⌄" },
        search_up = { icon = "🔍⌃" },
        filter = { icon = "$" },
        lua = { icon = "☾" },
        help = { icon = "?" },
      },
    },
    format = {
      level = {
        icons = {
          error = "✖",
          warn = "▼",
          info = "●",
        },
      },
    },
    popupmenu = { kind_icons = false, },
    inc_rename = { cmdline = { format = { IncRename = { icon = "⟳" } }, }, },
  })
end

return {
  {
    "b0o/incline.nvim",
    event = "VeryLazy",
  },

  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function(_, _)
      vim.o.background = "dark"
      vim.cmd([[colorscheme gruvbox]])
    end,
  },

  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    event = "VeryLazy",
    config = function(_, opts) setup(opts) end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
  },

  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },
}
