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
    event = "VeryLazy",
    opts = { treesitter = { stopline = 1000, }, },
  },

  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = require("plugins.aerial").aerial_keys(),
    opts = require("plugins.aerial").aerial_opts(),
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
    "Cannon07/code-preview.nvim",
    config = function()
      require("code-preview").setup()
    end,
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
    dependencies = "nvim-tree/nvim-web-devicons",
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
    dependencies = "tpope/vim-commentary",
    event = "VeryLazy",
    opts = {},
  },

  {
    "kylechui/nvim-surround",
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
    "mason-org/mason.nvim",
    dependencies = {
      "b0o/schemastore.nvim",
      "j-hui/fidget.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function(opts)
      require("mason").setup()
      require("lsp").setup_local_lsps()
    end,
    opts = {},
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "mfussenegger/nvim-dap-python",
      "nvim-neotest/nvim-nio",
    },
    keys = require("plugins.dap").dap_keys(),
    config = function()
      require("plugins.dap").dap_config()
    end,
  },

  {
    "mrcjkb/rustaceanvim",
    ft = "rust",
    version = "^9",
  },

  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function() require("colorizer").setup() end,
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-neotest/neotest-python",
      "haydenmeade/neotest-jest",
      "mrcjkb/rustaceanvim",
    },
    keys = require("plugins.neotest").neotest_keys(),
    config = function()
      require("neotest").setup(require("plugins.neotest").neotest_opts())
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    build = function() require("nvim-web-devicons").get_icons() end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-context",
    },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install(
        require("plugins.treesitter").parsers,
        { force = false }
      )
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = { max_lines = 3, },
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
