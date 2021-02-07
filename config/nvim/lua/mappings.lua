local M = {}

function M.map(scope, mode, trigger, mapping, options)
  local opts = {noremap = true}
  local global = true
  if options then
    for key, value in ipairs(options) do
      if key == "global" then
        global = value
        break
      end

      opts[key] = value
    end
  end

  if global then
    vim.api.nvim_set_keymap(mode, trigger, mapping, opts)
  else
    vim.api.nvim_buf_set_keymap(0, mode, trigger, mapping, opts)
  end
end

function M.init()
  vim.api.nvim_set_var("mapleader", ",")
  vim.api.nvim_set_var("mapleaderlocal", "'")

  -- Toggle common settings on and off
  M.map("n", "coh", ":set hlsearch! hlsearch?<CR>")
  M.map("n", "con", ":setlocal number! relativenumber! number?<CR>")
  M.map("n", "cor", ":setlocal ruler! ruler?<CR>")
  M.map("n", "cos", ":setlocal spell! spell?<CR>")
  M.map("n", "cow", ":setlocal wrap! wrap?<CR>")

  -- Fix backwards compatibility bug
  M.map("n", "Y", "y$", { noremap = false })
  --

  -- Window navigation
  M.map("n", "<C-h>", "<C-w>h")
  M.map("n", "<C-j>", "<C-w>j")
  M.map("n", "<C-k>", "<C-w>k")
  M.map("n", "<C-l>", "<C-w>l")
  --
end

return M
