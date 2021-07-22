local autocommands = {
  -- toggle number/relativenumber automatically
  {
    cmd = "lua if vim.wo.number then vim.wo.relativenumber = true end",
    events = "BufEnter,FocusGained,InsertLeave,WinEnter",
    patterns = "*",
  },
  {
    cmd = "lua vim.wo.relativenumber = false",
    events = "BufLeave,FocusLost,InsertEnter,WinLeave",
    patterns = "*",
  },

  -- comments should always be italicized
  {
    cmd = "lua require('utils').highlight_group('Comment', {style='italic'})",
    events = "Colorscheme,VimEnter",
    patterns = "*",
  },

  -- completion plugin should always load
  {
    cmd = "lua require('completion').on_attach()",
    events = "BufEnter",
    patterns = "*",
  },
}


vim.cmd("augroup dotfile_autocommands")
vim.cmd("autocmd!")

for _, cmd in ipairs(autocommands) do
  autocmd = table.concat({"autocmd", cmd.events, cmd.patterns, cmd.cmd}, " ")
  vim.cmd(autocmd)
end

vim.cmd("augroup end")
