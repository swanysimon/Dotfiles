local M = {}

function M.neotest_keys()
  return {
    { "<leader>nn", function() require("neotest").run.run() end },
    { "<leader>nf", function() require("neotest").run.run(vim.fn.expand("%")) end },
    { "<leader>ns", function() require("neotest").summary.toggle() end },
    { "<leader>no", function() require("neotest").output_panel.toggle() end },
    { "<leader>nl", function() require("neotest").run.run_last() end },
    { "]n",         function() require("neotest").jump.next({ status = "failed" }) end },
    { "[n",         function() require("neotest").jump.prev({ status = "failed" }) end },
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
