local ok, err = pcall(require, "core")

if not ok then
  error("Error loading Neovim configuration:\n\n" .. err)
end
