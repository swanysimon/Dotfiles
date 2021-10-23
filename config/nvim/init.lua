-- module loading order matters; these are put in a specific order
modules = {
  "core",
  "plugin",
}

for _, module in ipairs(modules) do
  local ok, err = pcall(require, module)

  if not ok then
    error("Error loading Neovim configuration:\n\n" .. err)
  end
end
