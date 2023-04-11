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
    config = function()
      require("colorizer").setup()
    end,
  },

  -- quick terminal access
  {
    "numtostr/FTerm.nvim",
    config = function()
      vim.keymap.set("n", "cot", require("FTerm").toggle)
      vim.keymap.set("t", "<leader>cot", require("FTerm").toggle)
    end,
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      require("plugins.telescope")
    end,
  },

  -- better completion engine
  {
    "hrsh7th/nvim-cmp",
    requires = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("plugins.cmp")
    end,
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    requires = "andymass/vim-matchup",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "bash",
          "comment",
          "dockerfile",
          "fish",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "help",
          "java",
          "json",
          "lua",
          "make",
          "python",
          "rst",
          "rust",
          "toml",
          "vim",
          "yaml",
        },
        highlight = {enable = true},
        indent = {enable = true},
        matchup = {enable = true},
      }
    end,
    run = ":TSUpdate",
  },

  -- language server configurations
  {
    "neovim/nvim-lspconfig",
    requires = {
      "folke/neodev.nvim",
      "j-hui/fidget.nvim",
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
    },
    after = {
      "nvim-cmp",
      "telescope.nvim"
    },
    config = function()
      require("plugins.lspconfig")
    end,
  },
}

-- install packer if it doesn't exist
local exists, _ = pcall(require, "packer")
if not exists then
  local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  vim.fn.delete(install_path, "rf")
  vim.fn.system({"git", "clone", "--depth=1", "https://github.com/wbthomason/packer.nvim", install_path})

  vim.cmd("packadd packer.nvim")
  local exists, packer = pcall(require, "packer")

  if not exists then
    error("Failed to clone packer to " .. install_path .. ":\n\n" .. packer)
  end
end

-- install plugins
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
