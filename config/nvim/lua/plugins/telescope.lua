local function setup(options)
  local builtin = require("telescope.builtin")
  local map = vim.keymap.set

  require("telescope").setup(options)

  require("telescope").load_extension("file_browser")

  map("n", "<leader>b", builtin.buffers)
  map("n", "<leader>f", function() builtin.find_files({ hidden = true }) end)
  map("n", "<leader>pf", function() require("telescope").extensions.file_browser.file_browser({ path = "%:p:h" }) end)
  map("n", "<leader>g", builtin.live_grep)
  map("n", "<leader>pl", builtin.git_commits)
  map("n", "<leader>ps", builtin.git_status)
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    event = "VeryLazy",
    config = function(_, opts) setup(opts) end,
    opts = {
      defaults = {
        layout_strategy = "vertical",
      },
      extensions = {
        file_browser = {
          hidden = true,
          hijack_netrw = true,
        },
      },
    },
  },
}
