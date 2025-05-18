if vim.g.lazy_did_setup then
  return {}
end

----
-- Install and activate package manager
-- (Almost) copy-pasted from https://github.com/folke/lazy.nvim
----

local lazyroot = vim.fn.stdpath("data") .. "/lazy"
local lazypath = lazyroot .. "/lazy.nvim"

if not vim.fn.isdirectory(lazypath) then
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo(
      {
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      },
      true,
      {}
    )
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)


----
---Define colorschemes with lazy configuration since they're rather special
----

local colorschemes = {
  gruvbox = {
    active = false,
    repo = "ellisonleao/gruvbox.nvim",
  },
  onedark = {
    active = true,
    repo = "navarasu/onedark.nvim",
    setup = { style = "warmer", },
  },
  tokyonight = {
    active = false,
    repo = "folke/tokyonight.nvim",
  },
}

local active_colorscheme = vim.iter(colorschemes):find(
  function(_, spec) return spec.active end
)
if not active_colorscheme then
  error("No active colorscheme found")
end
active_colorscheme = active_colorscheme[1]

local colorscheme_specs = vim.iter(colorschemes):map(
  function(name, spec)
    return {
      spec.repo,
      config = function()
        require(name).setup(spec.setup or {})
        require(name).load()
      end,
      lazy = not spec.active,
      priority = 1000,
    }
  end
):totable()

----
-- Install plugins
----

require("lazy").setup({
  change_detection = { notify = false, },
  checker = { notify = false, },
  install = { colorscheme = { active_colorscheme, }, },
  lockfile = lazyroot .. "/lazy-lock.json",
  spec = { colorscheme_specs, { import = "plugins", }, },
})
