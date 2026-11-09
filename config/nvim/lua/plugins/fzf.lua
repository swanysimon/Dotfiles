local M = {}

-- Locate the fzf vim plugin shipped with the fzf binary (e.g. via Homebrew,
-- where it lives at <prefix>/opt/fzf/plugin/fzf.vim). Returns nil if fzf is
-- not installed or ships no plugin.
function M.fzf_dir()
  local exe = vim.fn.exepath("fzf")
  if exe == "" then
    return nil
  end
  -- resolve symlinks: .../Cellar/fzf/<version>/bin/fzf
  local root = vim.fs.dirname(vim.fs.dirname(vim.uv.fs_realpath(exe) or exe))
  if vim.uv.fs_stat(root .. "/plugin/fzf.vim") then
    return root
  end
  return nil
end

function M.fzf_spec()
  local dir = M.fzf_dir()
  if not dir then
    return nil
  end
  return { dir = dir, name = "fzf", }
end

return M
