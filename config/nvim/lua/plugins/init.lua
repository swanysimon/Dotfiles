local colorschemes = {
  gruvbox = {
    active = false,
    repo = "ellisonleao/gruvbox.nvim",
  },
  onedark = {
    active = true,
    repo = "navarasu/onedark.nvim",
    setup = { style = "warmer", },
  },
  tokyonight = {
    active = false,
    repo = "folke/tokyonight.nvim",
  },
}


local plugins = {

  {
    "andymass/vim-matchup",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
  },

  {
    "b0o/incline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    init = function() vim.opt.laststatus = 3 end,
    opts = {},
  },

  {
    "b0o/schemastore.nvim",
    lazy = true,
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {},
  },

  {
    "folke/snacks.nvim",
    dependencies = {
      "folke/todo-comments.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = require("plugins.snacks").snack_keys(),
    lazy = false,
    opts = require("plugins.snacks").snack_opts(),
  },

  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    cmd = "Trouble",
    keys = require("plugins.trouble").trouble_keys(),
  },

  {
    "j-hui/fidget.nvim",
    opts = {},
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
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    version = "v2.*",
    lazy = true,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "b0o/schemastore.nvim",
      "folke/snacks.nvim",
      "j-hui/fidget.nvim",
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        -- configuration file formats
        "jsonls", "tombi", "yamlls",
        -- common languages
        "basedpyright", "bashls", "lua_ls",
      },
    },
  },

  {
    "mason-org/mason.nvim",
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

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdateSync",
    event = "VeryLazy",
    opts = require("plugins.treesitter").treesitter_opts(),
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    opts = { max_lines = 3, },
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
  },

  {
    "nvzone/floaterm",
    dependencies = "nvzone/volt",
    keys = require("plugins.floaterm").floaterm_keys(),
    opts = require("plugins.floaterm").floaterm_opts(),
  },

  {
    "Olical/conjure",
    ft = "clojure",
  },

  {
    "saghen/blink.cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    event = "InsertEnter",
    opts = require("plugins.blink").blink_opts(),
    version = "*",
  },

  {
    "Wansmer/treesj",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    opts = {},
  },

}


----
-- Install and activate package manager
-- (Almost) copy-pasted from https://github.com/folke/lazy.nvim
----

if vim.g.lazy_did_setup then
  return {}
end

local lazyroot = vim.fn.stdpath("data") .. "/lazy"
local lazypath = lazyroot .. "/lazy.nvim"

if not vim.fn.isdirectory(lazypath) then
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo(
      {
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out,                            "WarningMsg" },
        { "\nPress any key to exit..." },
      },
      true,
      {}
    )
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)


----
-- Colorschemes are rather special in lazy; handle them specially
----

local active_colorscheme = vim.iter(colorschemes):find(
  function(_, spec) return spec.active end
)
if not active_colorscheme then
  error("No active colorscheme found")
end
active_colorscheme = active_colorscheme[1]

local colorscheme_specs = vim.iter(colorschemes):map(
  function(name, spec)
    return {
      spec.repo,
      config = function()
        require(name).setup(spec.setup or {})
        require(name).load()
      end,
      lazy = not spec.active,
      priority = 1000,
    }
  end
):totable()

----
-- Install plugins
----

require("lazy").setup({
  change_detection = { notify = false, },
  checker = { notify = false, },
  install = { colorscheme = { active_colorscheme, }, },
  lockfile = lazyroot .. "/lazy-lock.json",
  spec = { colorscheme_specs, plugins, }
})
