if vim.g.lazy_did_setup then
  return {}
end

----
-- Install and activate package manager
-- (Almost) copy-pasted from https://github.com/folke/lazy.nvim
----

local lazyroot = vim.fn.stdpath("data") .. "/lazy"
local lazypath = lazyroot .. "/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)


----
-- Install plugins
----

require("lazy").setup(
  "plugins",
  {
    change_detection = { notify = false, },
    checker = { notify = false, },
    install = {
      colorscheme = {
        "gruvbox",
        "tokyonight-storm",
      },
    },
    lockfile = lazyroot .. "/lazy-lock.json",
  }
)


return {}
