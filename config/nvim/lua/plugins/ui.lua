local function colorscheme(plugin)
  return {
    plugin.location,
    priority = 1000,
    lazy = not plugin.enabled,
    config = function()
      vim.o.background = "dark"
      vim.cmd("colorscheme " .. plugin.name)
    end,
  }
end


return {
  colorscheme({
    enabled = false,
    location = "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
  }),

  colorscheme({
    enabled = true,
    location = "folke/tokyonight.nvim",
    name = "tokyonight",
  }),

  {
    "b0o/incline.nvim",
    event = "VeryLazy",
  },

  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
  },

  {
    "nvim-tree/nvim-web-devicons",
    build = function() require("nvim-web-devicons").get_icons() end,
  },

  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },
}
