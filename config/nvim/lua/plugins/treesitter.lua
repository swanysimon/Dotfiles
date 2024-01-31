local function setup(options)
  require("nvim-treesitter.configs").setup(options)

  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  vim.opt.foldmethod = "expr"

  require("ibl").setup()
  require("nvim-surround").setup()
  require("treesj").setup()
  require("ts_context_commentstring").setup()
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "Wansmer/treesj",
      "andymass/vim-matchup",
      "kylechui/nvim-surround",
      "lukas-reineke/indent-blankline.nvim",
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "tpope/vim-commentary",
    },
    build = ":TSUpdateSync",
    event = "VeryLazy",
    config = function(_, opts) setup(opts) end,
    opts = {
      ensure_installed = "all",
      highlight = {
        enable = true,
      },
      matchup = {
        enable = true,
      },
    },
  },
}
