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

  -- language diagnostics
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup()
    end,
  },

  -- telescope
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

  -- better completion engine
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugin.config.cmp")
    end,
  },
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-path",
  {
    "saadparwaiz1/cmp_luasnip",
    requires = "L3MON4D3/LuaSnip",
  },

  -- language server configurations
  {
    "neovim/nvim-lspconfig",
    requires = "nvim-cmp",
    config = function()
      require("plugin.config.lspconfig")
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    after = "nvim-lspconfig",
  },
}
