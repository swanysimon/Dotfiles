return {
  -- packer managing packer
  "wbthomason/packer.nvim",

  -- basic editing improvements
  "tpope/vim-commentary",
  "tpope/vim-repeat",
  "tpope/vim-surround",

  -- colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    requires = "rktjmp/lush.nvim",
    config = function()
      vim.opt.background = "dark"
      vim.cmd("colorscheme gruvbox")
    end,
  },

  -- session manager (and start page)
  {
    "mhinz/vim-startify",
    config = function()
      require("plugin.config.startify")
    end,
  },

  -- highlight color codes with their actual color
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- better buffer deletion
  "ojroques/nvim-bufdel",

  -- quick terminal access
  {
    "numtostr/FTerm.nvim",
    config = function()
      require("plugin.config.fterm")
    end,
  },

  -- telescope
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup()
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
    },
    config = function()
      require("plugin.config.telescope")
    end,
  },

  -- language server configurations
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugin.config.lspconfig")
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    requires = "nvim-lspconfig",
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "andymass/vim-matchup",
      "lewis6991/spellsitter.nvim",
    },
    config = function()
      require("plugin.config.treesitter")
    end,
    run = ":TSUpdate",
  },

  -- consistent completion (even without language server)
  "nvim-lua/completion-nvim",
}
