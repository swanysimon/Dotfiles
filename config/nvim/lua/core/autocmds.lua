vim.cmd([[
augroup Terminal
  autocmd!
  autocmd TermOpen term://* lua vim.wo.number = false
  autocmd TermOpen term://* lua vim.wo.relativenumber = false
  autocmd TermOpen term://* setfiletype terminal
augroup end
]])
