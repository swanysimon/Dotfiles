require("nvim-treesitter.configs").setup {
  ensure_installed = "all",
  highlight = {enable = true},
  matchup = {enable = true},
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
