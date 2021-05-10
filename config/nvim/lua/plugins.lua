local M = {}


local plugins = {
  -- packer managing packer
  "wbthomason/packer.nvim",

  -- visual plugins
  "gruvbox-community/gruvbox",
  "hoob3rt/lualine.nvim",
  "mhinz/vim-startify",
  {
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim"
    }
  },

  -- text editing plugins
  "editorconfig/editorconfig-vim",
  "tpope/vim-commentary",
  "tpope/vim-repeat",
  "tpope/vim-surround",

  -- plugins for extra mobility
  "neovim/nvim-lspconfig",
  "nvim-lua/completion-nvim",
  {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
    }
  },
  "tjdevries/astronauta.nvim",
}


local function install_packer()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd("packadd packer.nvim")
  end
end


local function register_plugins()
  require("packer").startup {
    function(use)
      for _, plugin in ipairs(plugins) do
        use(plugin)

        local plugin_id = plugin
        if type(plugin_id) == "table" then
          plugin_id = plugin_id[1]
        end

        vim.cmd("packadd " .. string.sub(plugin_id, string.find(plugin_id, "/")))
      end
    end
  }
end


local function reload_plugins_on_write()
  require("utils").autocommand_group({
    name = "pluginreload",
    autocommands = {
      {events = "BufWritePost", patterns = "plugins.lua", cmd = "lua require('plugins').update()"},
    },
  })
end


function M.init()
  install_packer()
  register_plugins()

  local packer = require("packer")
  packer.clean()
  packer.install()

  reload_plugins_on_write()
end


function M.update()
  vim.cmd("luafile %")
  register_plugins()
  require("packer").sync()
end


return M
