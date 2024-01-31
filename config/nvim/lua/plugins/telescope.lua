local function setup(_, options)

  local function bind(key, func)
    vim.keymap.set("n", "<leader>" .. key, func)
  end

  local telescope = require("telescope")

  telescope.setup(options)
  telescope.load_extension("file_browser")
  telescope.load_extension("fzf")

  local builtin = require("telescope.builtin")
  local browser = telescope.extensions.file_browser

  -- find files
  bind("f", function() builtin.find_files({ hidden = true }) end)
  bind("ff", function() builtin.find_files({ hidden = true }) end)
  bind("fb", builtin.buffers)
  bind("fr", builtin.oldfiles)
  bind("fp", browser.file_browser)
  bind("ft", function() browser.file_browser({ path = "%:p:h" }) end)

  -- text search
  bind("g", builtin.live_grep)
  bind("gc", builtin.grep_string)

  -- project management
  bind("pl", builtin.git_commits)
  bind("ps", builtin.git_status)
end


return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", },
    },
    event = "VeryLazy",
    config = setup,
    opts = {
      defaults = {
        layout_strategy = "vertical",
        path_display = "shorten",
      },
    },
  },
}
