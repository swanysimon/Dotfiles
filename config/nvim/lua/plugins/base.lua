local function load_colorscheme(plugin, name, active, setup)
  return {
    plugin,
    config = function()
      require(name).setup(setup)
      require(name).load()
    end,
    lazy = not active,
    priority = 1000,
  }
end


return {

  load_colorscheme("navarasu/onedark.nvim", "onedark", true, {style = "warmer"}),

  load_colorscheme("ellisonleao/gruvbox.nvim", "gruvbox", false, {}),
  load_colorscheme("folke/tokyonight.nvim", "tokyonight-storm", false, {}),

  {
    "b0o/incline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    init = function() vim.opt.laststatus = 3 end,
    opts = {},
  },

  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
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
    "nvim-tree/nvim-web-devicons",
    build = function() require("nvim-web-devicons").get_icons() end,
  },

}
