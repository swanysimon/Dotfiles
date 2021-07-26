local plugins = {
  -- packer managing packer
  "wbthomason/packer.nvim",

  -- gruvbox as my colorscheme
  "gruvbox-community/gruvbox",

  -- statusline/tabline
  {
    "hoob3rt/lualine.nvim",
    config = function()
      require("lualine").setup {
        options = {
          icons_enabled = false,
          theme = vim.g.colors_theme,
        },
      }
    end,
    event = {"Colorscheme", "VimEnter"},
  },

  -- start page and session management
  "mhinz/vim-startify",

  -- highlight color codes
  {
    "norcalli/nvim-colorizer.lua",
    config = function() require("colorizer").setup() end,
  },

  -- git decorations
  {
    "lewis6991/gitsigns.nvim",
    config = function() require("gitsigns").setup() end,
    requires = {"nvim-lua/plenary.nvim"},
  },

  -- editorconfig support
  "editorconfig/editorconfig-vim",

  -- easy commenting
  "tpope/vim-commentary",

  -- repeat plugin maps
  "tpope/vim-repeat",

  -- work with "surroundings"
  "tpope/vim-surround",

  -- enable lua ftplugins
  "tjdevries/astronauta.nvim",

  -- floating terminal
  {
    "numtostr/FTerm.nvim",
    config = function() require("FTerm").setup() end,
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    requires = {"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim"},
  },

  -- language server configurations
  "neovim/nvim-lspconfig",

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
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = "maintained",
        highlight = {enable = true},
      }
    end,
  },

  -- spellcheck plugin for treesitter
  {
    "lewis6991/spellsitter.nvim",
    config = function() require("spellsitter").setup() end,
  },

  -- consistent completion even without language server
  "nvim-lua/completion-nvim",
}


local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
  vim.cmd("packadd packer.nvim")
end

require("packer").startup({
  plugins,
  config = {
    display = {
      open_fn = require("packer.util").float,
    }
  }
})

require("packer").install()
