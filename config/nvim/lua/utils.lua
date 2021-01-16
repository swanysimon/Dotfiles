local api = vim.api

function let(property, value)
  api.nvim_set_var(property, value)
end

function set(property, value)
  api.nvim_set_option(property, value)
end

function setlocal(property, value)
  api.nvim_buf_set_option(property, value)
end

function map(mode, trigger, mapping, options)
  local opts = {noremap = true}
  if options then
    for key, value in pairs(options) do
      opts[key] = value
    end
  end
  api.nvim_set_keymap(mode, trigger, mapping, opts)
end

function augroup(name, definitions)
  api.nvim_command("augroup " .. name)
  api.nvim_command("autocmd!")
  for _, def in ipairs(definitions) do
    local command = table.concat(vim.tbl_flatten{"autocmd", def}, " ")
    api.nvim_command(command)
  end
  api.nvim_command("augroup end")
end
