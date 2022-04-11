require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "bash",
    "comment",
    "dockerfile",
    "fish",
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
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  matchup = {
    enable = true,
  },
}

require("spellsitter").setup()
