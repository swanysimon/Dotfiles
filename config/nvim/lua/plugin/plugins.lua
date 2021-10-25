return {
  -- packer managing packer
  "wbthomason/packer.nvim",

  -- gruvbox as my colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    requires = {"rktjmp/lush.nvim"},
    config = function()
      vim.opt.background = "dark"
      vim.cmd("colorscheme gruvbox")
    end,
  },

  -- start page and session management
  "mhinz/vim-startify",

  -- highlight color codes
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- easy commenting
  "tpope/vim-commentary",

  -- work with "surroundings"
  "tpope/vim-surround",
  --
  -- better buffer deletion
  "ojroques/nvim-bufdel",

  -- floating terminal
  "numtostr/FTerm.nvim",

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    requires = {"nvim-lua/plenary.nvim"},
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
    after = {"nvim-lspconfig"},
  },

  -- visual plugins
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        fold_open = "v"
      }
    end,
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = "andymass/vim-matchup",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = "maintained",
        highlight = {
          enable = true,
          use_languagetree = true,
        },
      }
    end,
  },

  -- spellcheck plugin for treesitter
  {
    "lewis6991/spellsitter.nvim",
    config = function() require("spellsitter").setup() end,
  },

  -- consistent completion (even without language server)
  "nvim-lua/completion-nvim",
}
