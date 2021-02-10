local function setopt(scope, option, value)
  if scope ~= "o" then
    vim[scope][option] = value
  end
  vim.o[option] = value
end

setopt("o", "hidden", true)
setopt("o", "history", 1000)
setopt("o", "include", "")
setopt("o", "lazyredraw", true)
setopt("o", "timeoutlen", 200)

setopt("o", "ignorecase", true)
setopt("o", "wildignorecase", true)

setopt("o", "joinspaces", false)
setopt("o", "laststatus", 2)
setopt("o", "splitbelow", true)
setopt("o", "splitright", true)

setopt("o", "mouse", "a")
setopt("o", "clipboard", "unnamed")

setopt("bo", "comments", "")
setopt("bo", "textwidth", 0)

local default_indentation = 2
setopt("bo", "expandtab", true)
setopt("bo", "shiftwidth", default_indentation)
setopt("bo", "softtabstop", default_indentation)

setopt("wo", "cursorline", true)
setopt("wo", "number", true)
setopt("wo", "relativenumber", true)
setopt("wo", "signcolumn", "no")

require("autocommands").init()
require("colors").init()
require("lsp")
require("mappings").init()
require("lualine").status()
