local function set_lsp_keymaps(client, bufnr)
  local function map(keys, func)
    vim.keymap.set("n", keys, func, { buffer = bufnr })
  end

  local lsp = vim.lsp.buf

  -- navigation
  map("gD", lsp.declaration)
  map("gd", lsp.definition)
  map("gi", lsp.implementation)
  map("gr", lsp.references)
  map("gt", lsp.type_definition)

  -- documentation
  map("<leader>k", lsp.signature_help)
  map("K", lsp.hover)

  -- actions
  map("<leader><cr>", lsp.code_action)
  map("<leader>ca", lsp.code_action)
  map("<leader>rn", lsp.rename)

  -- workspace management
  map("<leader>wa", lsp.add_workspace_folder)
  map("<leader>wr", lsp.remove_workspace_folder)

  -- diagnostics
  map("<leader>e", vim.diagnostic.open_float)
  map("<leader>q", vim.diagnostic.setloclist)
end

local lsp_autoformat_augroup = vim.api.nvim_create_augroup("lsp_autoformat", {})
local lsp_augroup = vim.api.nvim_create_augroup("lsp_attach", { clear = true, })
local highlight_augroup = vim.api.nvim_create_augroup("lsp_document_highlight", {})

local function enable_format_on_save(client, bufnr)
  if client:supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = lsp_autoformat_augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd(
      { "BufWritePre", },
      {
        group = lsp_autoformat_augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 3000, })
        end,
      })
  end
end

vim.api.nvim_create_autocmd(
  { "LspAttach", },
  {
    group = lsp_augroup,
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client then
        return
      end

      local bufnr = args.buf
      set_lsp_keymaps(client, bufnr)
      enable_format_on_save(client, bufnr)

      if client:supports_method("textDocument/foldingRange") then
        vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
      end

      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr, })
      end

      if client:supports_method("textDocument/documentHighlight") then
        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = highlight_augroup })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = bufnr,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = bufnr,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })
      end
    end,
  }
)

vim.api.nvim_create_autocmd(
  { "LspDetach", },
  {
    group = lsp_augroup,
    callback = function(args)
      local bufnr = args.buf
      local clients = vim.lsp.get_clients({ bufnr = bufnr })

      if not vim.iter(clients):find(
            function(client) return client:supports_method("textDocument/formatting") end
          ) then
        vim.api.nvim_clear_autocmds({ group = lsp_autoformat_augroup, buffer = bufnr })
      end

      if not vim.iter(clients):find(
            function(client) return client.server_capabilities.inlayHintProvider ~= nil end
          ) then
        vim.lsp.inlay_hint.enable(false, { bufnr = bufnr, })
      end

      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = highlight_augroup })
      vim.lsp.buf.clear_references()
    end,
  }
)
