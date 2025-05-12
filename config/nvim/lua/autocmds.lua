local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- change default indentation for some filetypes
autocmd(
  { "FileType", },
  {
    group=augroup("ft_indentation"),
    pattern={
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

-- text-based filetypes should enable wrap and spellchecking
autocmd(
  { "FileType", },
  {
    group = augroup("ft_prose"),
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

-- check if file has been updated when loading
autocmd(
  {
    "FocusGained",
    "TermClose",
    "TermLeave",
  },
  {
    group = augroup("check_updated"),
    command = "checktime",
  }
)

-- highlight on yank
autocmd(
  { "TextYankPost", },
  {
    group = augroup("highlight_yank"),
    callback = function()
      vim.highlight.on_yank()
    end,
  }
)

-- go to last visited line when opening a buffer
autocmd(
  { "BufReadPost", },
  {
    callback = function(args)
      local mark = vim.api.nvim_buf_get_mark(args.buf, "\"")
      local line_count = vim.api.nvim_buf_line_count(args.buf)
      if mark[1] > 0 then
        if mark[1] <= line_count then
          vim.cmd("normal! g`\"zz")
        else
          vim.cmd("normal! Gzb")
        end
      end
    end,
  }
)
