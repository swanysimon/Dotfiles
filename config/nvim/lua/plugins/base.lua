return {

  {
    "b0o/incline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    init = function() vim.opt.laststatus = 3 end,
    opts = {},
  },

  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
  },

  {
    "nvim-tree/nvim-web-devicons",
    build = function() require("nvim-web-devicons").get_icons() end,
  },

  {
    "nvzone/floaterm",
    dependencies = "nvzone/volt",
    opts = {
      size = { h = 75, w = 85, },
    },
    keys = {
      {
        "<leader>t",
        mode = { "n", "t", "v" },
        function() require("floaterm").toggle() end,
      },
    },
  },

}
