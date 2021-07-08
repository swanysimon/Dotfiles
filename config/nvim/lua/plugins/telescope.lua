local M = {}
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")


function M.project_files()
  local git_project_files = pcall(builtin.git_files)
  if not git_project_files then
    builtin.find_files()
  end
end


function M.setup()
  require("telescope").setup {
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = actions.close
        },
      },
    }
  }

  local map = require("utils").set_keymap
  map("n", "<leader>f", "<cmd>lua require('plugins.telescope').project_files()<cr>")
  map("n", "<leader>g", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
  map("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>")
end


return M
