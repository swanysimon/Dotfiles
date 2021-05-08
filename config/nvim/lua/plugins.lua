local M = {}


local plugins = {
  -- packer managing packer
  "wbthomason/packer.nvim",

  -- visual plugins
  "gruvbox-community/gruvbox",
  "hoob3rt/lualine.nvim",
  "mhinz/vim-startify",

  -- text editing plugins
  "tpope/vim-commentary",
  "tpope/vim-surround",

  -- plugins with extra features
  "tjdevries/astronauta.nvim",

  -- language server
  "nvim-lua/completion-nvim",
  "neovim/nvim-lspconfig",
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
  require("packer").install()
  reload_plugins_on_write()
end


function M.update()
  register_plugins()
  require("packer").sync()
end


return M
