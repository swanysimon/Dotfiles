local default_indentation = 2

require("autocommands")
require("colors")
require("mappings")

local U = require("utils")

U.set("history", 1000)

U.set("hidden", true)

U.set("expandtab", true)
U.set("shiftwidth", default_indentation)
U.set("softtabstop", default_indentation)

U.set("joinspaces", false)

U.set("lazyredraw", true)
U.set("timeoutlen", 200)

U.set("colorcolumn", "+1")
U.set("cursorline", true)
U.set("laststatus", 2)
U.set("ruler", false)
U.set("signcolumn", "no")
U.set("textwidth", 0)

U.set("ignorecase", true)

U.set("wildignorecase", true)
U.set("wildmode", "list:full")

U.set("splitbelow", true)
U.set("splitright", true)

U.set("comments", "")
U.set("include", "")
