local M = {}

function M.is_snacks_active()
  return package.loaded.snacks and Snacks.picker
end

function M.snacks_or_lsp(snack_picker, lsp_fn)
  return function()
    if M.is_snacks_active() then
      if type(snack_picker) == "string" then
        Snacks.picker[snack_picker]()
      else
        snack_picker()
      end
    else
      if type(lsp_fn) == "string" then
        vim.lsp.buf[lsp_fn]()
      else
        lsp_fn()
      end
    end
  end
end

function M.snack_keys()
  return {
    { "<leader>f",  function() Snacks.picker.smart() end, },
    { "<leader>ff", function() Snacks.picker.files() end, },
    { "<leader>fg", function() Snacks.picker.git_files() end, },
    { "<leader>fb", function() Snacks.picker.buffers() end, },
    { "<leader>fp", function() Snacks.picker.explorer() end, },
    { "<leader>ft", function() Snacks.picker.explorer({ cwd = vim.fn.expand("%:p:h") }) end, },
    { "<leader>st", function() Snacks.picker.todo_comments() end, },
    { "<leader>ss", function() Snacks.picker.grep() end, },
    { "<leader>sw", function() Snacks.picker.grep_word() end, },
    { "<leader>r",  function() Snacks.picker.recent() end, },
  }
end

function M.snack_opts()
  return {
    bigfile = { enabled = true, },
    explorer = { enabled = true, },
    indent = { enabled = true, },
    input = { enabled = true, },
    notifier = { enabled = true, },
    picker = {
      enabled = true,
      hidden = true,
      ignored = true,
      matcher = {
        cmd_bonus = true,
        frecency = true,
      },
      sources = {
        explorer = {
          hidden = true,
          replace_netrw = true,
        },
        files = {
          hidden = true,
          follow = true,
        },
        smart = {
          multi = { "buffers", "files", "git_files", },
        },
      },
      win = {
        input = {
          keys = {
            ["<esc>"] = { "close", mode = { "i", "n", } },
          },
        },
      },
    },
    statuscolumn = { enabled = true, },
  }
end

return M
