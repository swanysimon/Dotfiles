local M = {}

function M.dap_keys()
  return {
    { "<F5>",       function() require("dap").continue() end },
    { "<F10>",      function() require("dap").step_over() end },
    { "<F11>",      function() require("dap").step_into() end },
    { "<F12>",      function() require("dap").step_out() end },
    { "<leader>bb", function() require("dap").toggle_breakpoint() end },
    { "<leader>bB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end },
    { "<leader>bu", function() require("dapui").toggle() end },
    { "<leader>br", function() require("dap").repl.toggle() end },
  }
end

function M.dap_config()
  local dap = require("dap")
  local dapui = require("dapui")

  dapui.setup()
  require("nvim-dap-virtual-text").setup()

  dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
  dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
  dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

  require("dap-python").setup(
    vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
  )
end

return M
