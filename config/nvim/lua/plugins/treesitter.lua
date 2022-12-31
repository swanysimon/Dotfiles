require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "bash",
    "comment",
    "dockerfile",
    "fish",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "help",
    "java",
    "json",
    "lua",
    "make",
    "python",
    "rst",
    "rust",
    "toml",
    "vim",
    "yaml",
  },
  highlight = {enable = true},
  indent = {enable = true},
  matchup = {enable = true},
}

require("spellsitter").setup()
