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
    group = augroup("proselike_ft"),
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

vim.api.nvim_create_autocmd(
  { "BufReadPost", },
  {
    group = augroup("goto_last_position_on_buffer_on"),
    callback = function(args)
      local bufnr = args.buf

      local exclude = { "help", "gitcommit", }
      if vim.tbl_contains(exclude, vim.bo[bufnr].filetype) then
        -- don't mess with entrypoint for documentation or commit messages
        return
      end

      local winnr = vim.iter(vim.api.nvim_list_wins()):find(
        function(win) return vim.api.nvim_win_get_buf(win) end
      )
      if not winnr then
        -- buffer isn't in a window; don't ask questions but don't continue
        return
      end

      local mark = vim.api.nvim_buf_get_mark(bufnr, "\"")
      if mark[1] <= 0 then
        -- no previous position known for the file
        return
      end

      local numlines = vim.api.nvim_buf_line_count(bufnr)
      if mark[1] <= numlines then
        vim.api.nvim_win_set_cursor(winnr, mark)
      else
        -- previous edit was beyond the current last line; go to the bottom
        vim.api.nvim_win_set_cursor(winnr, { 0, numlines, })
      end
    end,
  }
)
