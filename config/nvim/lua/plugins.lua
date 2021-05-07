local M = {}


local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"


local function is_packer_installed()
  return fn.empty(fn.glob(install_path)) > 0
end


local function install_packer()
  if not is_packer_installed() then
    fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd("packadd packer.nvim")
  end
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
  reload_plugins_on_write()

  require("packer").startup {
    function(use)
      -- packer managing packer
      use "wbthomason/packer.nvim"

      -- visual plugins
      use "gruvbox-community/gruvbox"
      use "hoob3rt/lualine.nvim"
      use "mhinz/vim-startify"

      -- text editing plugins
      use "tpope/vim-commentary"
      use "tpope/vim-surround"

      -- language server
      use "nvim-lua/completion-nvim"
      use "neovim/nvim-lspconfig"
    end
  }
end


function M.update()
  M.init()
  require("packer").sync()
end


return M
