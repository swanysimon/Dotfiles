local cmd = vim.cmd
local fn = vim.fn


local exists, packer = pcall(require, "packer")

if not exists then
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  fn.delete(install_path, "rf")
  fn.system({"git", "clone", "--depth=1", "https://github.com/wbthomason/packer.nvim", install_path})

  vim.cmd("packadd packer.nvim")
  local exists, packer = pcall(require, "packer")

  if not exists then
    error("Failed to clone packer to " .. install_path .. ":\n\n" .. packer)
  end
end
