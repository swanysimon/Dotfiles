local function load_colorscheme(plugin, name, active)
  return {
    plugin,
    config = function() vim.cmd("colorscheme " .. name) end,
    lazy = not active,
    priority = 1000,
  }
end


return {

  load_colorscheme("navarasu/onedark.nvim", "onedark", true),

  load_colorscheme("ellisonleao/gruvbox.nvim", "gruvbox", false),
  load_colorscheme("folke/tokyonight.nvim", "tokyonight-storm", false),

  {
    "b0o/incline.nvim",
    build = function() require("nvim-web-devicons").get_icons() end,
    dependencies = { "nvim-tree/nvim-web-devicons", },
    event = "VeryLazy",
    opts = {},
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    opts = {},
  },

  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
  },

  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    event = "VeryLazy",
    opts = {},
    version = "v0.3.1",
  },

}
