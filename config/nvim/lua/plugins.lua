local M = {}

function M.init()
  require("packer").startup(function()
    use("wbthomason/packer.nvim")

    use("gruvbox-community/gruvbox")
    use({
      "hoob3rt/lualine.nvim",
      requires = {"kyazdani42/nvim-web-devicons", opt = true}
    })

    use("tpope/vim-commentary")
    use("tpope/vim-surround")

    use("nvim-lua/completion-nvim")
    use("neovim/nvim-lspconfig")
  end)
end

return M
