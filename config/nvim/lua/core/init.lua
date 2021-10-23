local modules = {
  "core.autocmds",
  "core.mappings",
  "core.options",
}

for _, module in ipairs(modules) do
  ok, err = pcall(require, module)

  if not ok then
    error("Error loading " .. module .. "\n\n" .. err)
  end
end
