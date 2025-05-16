local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

local M = {}

function M.ft_indentation()
  autocmd(
    { "FileType", },
    {
      group=augroup("ft_indentation"),
      pattern={
        "clojure",
        "javascript",
        "json",
        "lua",
        "typescript",
        "typescriptreact",
        "yaml",
      },
      callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.tabstop = 2
      end,
    }
  )
end

function M.proselike_ft()
  autocmd(
    { "FileType", },
    {
      group = augroup("proselike_ft"),
      pattern = {
        "gitcommit",
        "markdown",
      },
      callback = function()
        vim.wo.wrap = true
        vim.wo.spell = true
      end,
    }
  )
end

function M.check_updated()
  autocmd(
    {
      "FocusGained",
      "TermClose",
      "TermLeave",
    },
    {
      group = augroup("check_updated"),
      command = "checktime",
    }
  )
end

function M.highlight_on_yank()
  autocmd(
    { "TextYankPost", },
    {
      group = augroup("highlight_on_yank"),
      callback = function()
        vim.highlight.on_yank()
      end,
    }
  )
end

function M.goto_last_position_on_buffer_on()
  autocmd(
    { "BufReadPost", },
    {
      group = augroup("goto_last_position_on_buffer_on"),
      callback = function(args)
        if vim.bo.filetype == "gitcommit" then
          -- always start editing at the top of a git commit message
          return
        end

        local mark = vim.api.nvim_buf_get_mark(args.buf, "\"")
        if mark[1] <= 0 then
          -- no previous position known for the file
          return
        end

        if mark[1] <= vim.api.nvim_buf_line_count(args.buf) then
          vim.cmd("normal! g`\"zz")
        else
          -- previous edit was beyond the current last line; go to the bottom
          vim.cmd("normal! Gzb")
        end
      end,
    }
  )
end

function M.lsp_attach()
  autocmd(
    { "LspAttach", },
    {
      group = augroup("lsp_attach"),
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client:supports_method("textDocument/foldingRange") then
          vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
      end,
    }
  )
end

function M.setup()
  M.ft_indentation()
  M.proselike_ft()
  M.check_updated()
  M.highlight_on_yank()
  M.goto_last_position_on_buffer_on()
  M.lsp_attach()
end

local lsp_format_on_save_augroup = augroup("lsp_format_on_save")
function M.lsp_format_on_save(client, bufnr)
  vim.api.nvim_create_autocmd(
    { "BufWritePre", },
    {
      group = "lsp_format_on_save",
      buffer = bufnr,
      callback = function()
        if client:supports_method("textDocument/formatting") and vim.bo.modified then
          vim.lsp.buf.format({ client_id = args.data.client_id, })
        end
      end,
    }
  )
end

return M
