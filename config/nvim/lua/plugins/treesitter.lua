local function setup(options)
  require("nvim-treesitter.configs").setup(options)
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  vim.opt.foldmethod = "expr"
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "andymass/vim-matchup",
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
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
