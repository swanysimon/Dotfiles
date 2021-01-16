local default_indentation = 2

require("autocommands")
require("colors")
require("mappings")
require("utils")

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
set("laststatus", 2)
set("ruler", false)
set("signcolumn", "no")
set("textwidth", 0)

set("ignorecase", true)

set("wildignorecase", true)
set("wildmode", "list:full")

set("splitbelow", true)
set("splitright", true)

set("comments", "")
set("include", "")
