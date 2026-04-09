local M = {}

function M.neotest_keys()
  return {
    { "<leader>tt", function() require("neotest").run.run() end },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end },
    { "<leader>ts", function() require("neotest").summary.toggle() end },
    { "<leader>to", function() require("neotest").output_panel.toggle() end },
    { "<leader>tl", function() require("neotest").run.run_last() end },
    { "]t",         function() require("neotest").jump.next({ status = "failed" }) end },
    { "[t",         function() require("neotest").jump.prev({ status = "failed" }) end },
  }
end

function M.neotest_opts()
  return {
    adapters = {
      require("neotest-python"),
      require("neotest-jest"),
      require("rustaceanvim.neotest"),
    },
  }
end

return M
