local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local map = vim.keymap.set
local trouble = require("trouble.providers.telescope")


require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-t>"] = trouble.open_with_trouble,
      },
      n = {
        ["<c-t>"] = trouble.open_with_trouble,
      },
    },
  },
  extensions = {
  },
}


map("n", "<leader>b", builtin.buffers)
map("n", "<leader>f", function() builtin.find_files({hidden = true}) end)
map("n", "<leader>g", builtin.live_grep)
map("n", "<leader>pl", builtin.git_commits)
map("n", "<leader>ps", builtin.git_status)
