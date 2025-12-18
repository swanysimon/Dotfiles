local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd(
  { "FileType", },
  {
    group = augroup("ft_indentation"),
    pattern = {
      "clojure",
      "javascript",
      "json",
      "lua",
      "typescript",
      "typescriptreact",
      "yaml",
    },
    callback = function()
      vim.bo.shiftwidth = 2
      vim.bo.tabstop = 2
    end,
  }
)

vim.api.nvim_create_autocmd(
  { "FileType", },
  {
    group = augroup("ft_proselike"),
    pattern = {
      "gitcommit",
      "markdown",
    },
    callback = function()
      vim.wo.wrap = true
      vim.wo.spell = true
    end,
  }
)

vim.api.nvim_create_autocmd(
  { "FileType" },
  {
    group = augroup("ft_treesitter"),
    callback = function(args)
      if vim.tbl_contains(require("plugins.treesitter").ignored_filetypes, args.match) then
        return
      end

      local lang = vim.treesitter.language.get_lang(args.match) or args.match
      local installed = require("nvim-treesitter").get_installed("parsers")
      if vim.tbl_contains(installed, lang) then
        vim.treesitter.start(args.buf)
      end
    end,
  }
)

vim.api.nvim_create_autocmd(
  { "FocusGained", "TermClose", "TermLeave", },
  {
    group = augroup("check_updated"),
    callback = function()
      if vim.bo.buftype ~= "nofile" then
        vim.cmd("checktime")
      end
    end,
  }
)

vim.api.nvim_create_autocmd(
  { "TextYankPost", },
  {
    group = augroup("highlight_on_yank"),
    callback = function()
      vim.highlight.on_yank()
    end,
  }
)
