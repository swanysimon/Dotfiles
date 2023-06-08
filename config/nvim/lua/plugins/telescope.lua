local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local map = vim.keymap.set


require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
  },
  extensions = {
    file_browser = {
      hidden = true,
      hijack_netrw = true,
    },
  },
}

require("telescope").load_extension("file_browser")
require("telescope").load_extension("ui-select")

map("n", "<leader>b", builtin.buffers)
map("n", "<leader>f", function() builtin.find_files({ hidden = true }) end)
map("n", "<leader>pf", function() require("telescope").extensions.file_browser.file_browser({ path = "%:p:h" }) end)
map("n", "<leader>g", builtin.live_grep)
map("n", "<leader>pl", builtin.git_commits)
map("n", "<leader>ps", builtin.git_status)
