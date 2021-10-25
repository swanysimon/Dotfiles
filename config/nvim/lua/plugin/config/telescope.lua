local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local map = require("core.utils").map


require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
  },
}


local function telescope_cmd(fn_str)
  return "<cmd>lua require('telescope.builtin')." .. fn_str .. "<cr>"
end


map("n", "<leader>b", telescope_cmd("buffers()"))
map("n", "<leader>f", telescope_cmd("find_files({hidden = true})"))
map("n", "<leader>g", telescope_cmd("live_grep()"))
map("n", "<leader>pl", telescope_cmd("git_commits()"))
map("n", "<leader>ps", telescope_cmd("git_status()"))
