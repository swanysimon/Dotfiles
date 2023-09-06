return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = true,
    config = function(_, _)
      vim.o.background = "dark"
      vim.cmd([[colorscheme gruvbox]])
    end,
  },

  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    config = function(_, _)
      vim.o.background = "dark"
      vim.cmd([[colorscheme tokyonight-storm]])
    end,
  },

}
