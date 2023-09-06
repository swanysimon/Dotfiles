local g = vim.g

if g.simonsays_lazy_loaded then
  return {}
end

g.simonsays_lazy_loaded = true

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

local lazyopts = {
  install = { colorscheme = { "tokyonight-storm", "gruvbox", }, },
  lockfile = lazyroot .. "/lazy-lock.json",
  -- don't rely on nerd fonts
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
}

require("lazy").setup("plugins", lazyopts)

return {}
