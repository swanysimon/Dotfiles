local M = {}

M.parsers = {

  -- standard configuration
  "json", "toml", "vim", "yaml",

  -- languages
  "clojure", "java", "lua", "python", "rust",

  -- shell interactions
  "bash", "fish",
  "diff",
  "git_config", "git_rebase", "gitcommit", "gitignore",
  "markdown", "markdown_inline",

  -- javascript ecosystem
  "css", "scss",
  "html",
  "javascript", "tsx", "typescript",

}

M.ignored_filetypes = {
  "checkhealth",
  "lazy",
  "mason",
  "snacks_dashboard",
  "snacks_notif",
  "snacks_win",
}

return M
