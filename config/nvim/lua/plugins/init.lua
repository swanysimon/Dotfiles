local plugins = {
  -- packer managing packer
  "wbthomason/packer.nvim",

  -- visual plugins
  "gruvbox-community/gruvbox",
  {
    "hoob3rt/lualine.nvim",
    config = function()
      require("lualine").setup {
        options = {
          icons_enabled = false,
          theme = vim.g.colors_name,
        }
      }
    end,
    event = {"Colorscheme", "VimEnter"},
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function() require("gitsigns").setup() end,
    requires = {"nvim-lua/plenary.nvim"},
  },
  "mhinz/vim-startify",
  {
    "norcalli/nvim-colorizer.lua",
    config = function() require("colorizer").setup() end,
  },
  {
    "sunjon/shade.nvim",
    config = function() require("shade").setup() end,
  },

  -- text editing plugins
  "editorconfig/editorconfig-vim",
  "tpope/vim-commentary",
  "tpope/vim-repeat",
  "tpope/vim-surround",

  -- plugins for extra mobility
  "neovim/nvim-lspconfig",
  {
    "numtostr/FTerm.nvim",
    config = function() require("FTerm").setup() end,
  },
  {
    "nvim-lua/completion-nvim",
    config = function() require("completion").on_attach() end,
    event = "BufEnter",
  },
  {
    "nvim-telescope/telescope.nvim",
    requires = {"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim"},
  },
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
  "tjdevries/astronauta.nvim",
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
