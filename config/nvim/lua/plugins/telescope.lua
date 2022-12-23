local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local map = vim.keymap.set
local trouble = require("trouble.providers.telescope").open_with_trouble


require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-t>"] = trouble,
      },
      n = {
        ["<c-t>"] = trouble,
      },
    },
  },
  extensions = {
  },
}


local extensions = {
  "file_browser",
  "ui-select",
}


for _, extension in ipairs(extensions) do
  require("telescope").load_extension(extension)
end


map("n", "<leader>b", builtin.buffers)
map("n", "<leader>f", function() builtin.find_files({hidden = true}) end)
map("n", "<leader>pf", require("telescope").extensions.file_browser.file_browser)
map("n", "<leader>g", builtin.live_grep)
map("n", "<leader>pl", builtin.git_commits)
map("n", "<leader>ps", builtin.git_status)
