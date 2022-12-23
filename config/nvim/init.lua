-- core options must be loaded before any plugins
for _, module in ipairs({"core", "plugins"}) do
  local ok, err = pcall(require, module)

  if not ok then
    error("Error loading Neovim configuration:\n\n" .. err)
  end
end
