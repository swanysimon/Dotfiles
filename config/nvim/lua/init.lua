local default_indentation = 2

local function set(property, value)
  vim.api.nvim_set_option(property, value)
end

set("history", 1000)

set("hidden", true)

set("expandtab", true)
set("shiftwidth", default_indentation)
set("softtabstop", default_indentation)

set("joinspaces", false)

set("lazyredraw", true)
set("timeoutlen", 200)

set("colorcolumn", "+1")
set("cursorline", true)
set("ruler", false)
set("signcolumn", "no")
set("textwidth", 0)

set("ignorecase", true)
set("wildignorecase", true)

set("splitbelow", true)
set("splitright", true)

set("comments", "")
set("include", "")

set("mouse", "a")

set("clipboard", "unnamed")

require("autocommands")
require("colors")
require("lsp")
require("mappings")
require("statusline")
