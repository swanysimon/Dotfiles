local function snack_keys()
  return {
    { "<leader>f",  function() Snacks.picker.files() end, },
    { "<leader>ff", function() Snacks.picker.files() end, },
    { "<leader>fg", function() Snacks.picker.git_files() end, },
    { "<leader>fb", function() Snacks.picker.buffers() end, },
    { "<leader>fp", function() Snacks.picker.explorer() end, },
    { "<leader>ft", function() Snacks.picker.explorer({ cwd = vim.fn.expand("%:p:h") }) end, },
    { "<leader>st", function() Snacks.picker.todo_comments() end, },
  }
end

local function snack_opts()
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
      sources = {
        explorer = {
          auto_close = true,
          hidden = true,
          layout = {
            preset = "default",
            preview = true,
          },
        },
        files = {
          hidden = true,
          follow = true,
        }
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
    terminal = {
      win = { position = "float", },
    },
  }
end

return {

  {
    "folke/snacks.nvim",
    dependencies = {
      "folke/todo-comments.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = snack_keys(),
    lazy = false,
    opts = snack_opts(),
  },

  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = "VeryLazy",
    opts = {},
  },

}
