local plugins = {
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
    after = "gruvbox.nvim",
    config = function()
      require("plugins.startify")
    end,
  },

  -- statusline
  {
    "b0o/incline.nvim",
    config = function()
      require("incline").setup()
    end,
  },

  -- highlight color codes with their actual color
  {
    "norcalli/nvim-colorizer.lua",
    after = "gruvbox.nvim",
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
      require("plugins.fterm")
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
      "folke/trouble.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      require("plugins.telescope")
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
      require("plugins.treesitter")
    end,
    run = ":TSUpdate",
  },

  -- better completion engine
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.cmp")
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
      require("plugins.lspconfig")
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    after = "nvim-lspconfig",
  },
}

require("plugins.bootstrap_packer")

local packer = require("packer")
packer.startup({
  plugins,
  config = {
    display = {
      open_fn = require("packer.util").float
    }
  }
})
packer.install()
