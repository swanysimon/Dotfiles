return {

  {
    "andymass/vim-matchup",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
  },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "tpope/vim-commentary",
    },
    event = "VeryLazy",
    opts = {},
  },

  {
    "kylechui/nvim-surround",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    event = "VeryLazy",
    opts = {},
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdateSync",
    event = "VeryLazy",
    opts = {
      ensure_installed = "all",
      highlight = { enable = true },
      indent = { enable = true },
      matchup = { enable = true },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
  },

  {
    "Wansmer/treesj",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    opts = {},
  },

}
