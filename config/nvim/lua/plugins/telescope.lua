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
  bind("f", builtin.find_files)
  bind("ff", builtin.find_files)
  bind("fg", builtin.git_files)
  bind("fb", builtin.buffers)
  bind("fbb", builtin.buffers)
  bind("fbr", builtin.oldfiles)
  bind("fp", browser.file_browser)
  bind("ft", function() browser.file_browser({ path = "%:p:h" }) end)

  -- text search
  bind("g", builtin.live_grep)
  bind("gc", builtin.grep_string)

  -- project management
  bind("pq", builtin.quickfix)
  bind("ps", builtin.git_status)
end


return {

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    lazy = true,
  },

  {
    "nvim-telescope/telescope.nvim",
    config = setup,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    event = "VeryLazy",
    opts = {
      defaults = {
        layout_strategy = "vertical",
        path_display = "shorten",
      },
      extensions = {
        file_browser = {
          hidden = true,
          hijack_netrw = true,
        },
      },
      pickers = {
        find_files = { hidden = true, },
        buffers = {
          ignore_current_buffer = true,
          sort_mru = true,
        },
      },
    },
  },

}
