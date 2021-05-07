local M = {}


local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"




local function is_packer_installed()
  return fn.empty(fn.glob(install_path)) == 0
end


local function clone_packer()
  fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
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
  local already_installed = is_packer_installed()

  if not already_install then
    clone_packer()
    vim.cmd("packadd packer.nvim")
  end

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

  if not already_installed then
    M.update()
  end
end


function M.update()
  require("packer").sync()
end


return M
