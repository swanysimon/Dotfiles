local M = {}


local function is_cursor_at_definition(definitions, bufnr)
  local current_pos = vim.api.nvim_win_get_cursor(0)
  local current_uri = vim.uri_from_bufnr(bufnr)

  for _, def in ipairs(definitions) do
    local def_uri = def.uri or def.targetUri
    local def_range = def.range or def.targetRange or def.targetSelectionRange

    if def_uri == current_uri and def_range then
      local def_start = def_range.start
      local def_end = def_range["end"]

      -- Check if cursor is within definition range (0-indexed to 1-indexed conversion)
      if current_pos[1] - 1 >= def_start.line and current_pos[1] - 1 <= def_end.line then
        if current_pos[1] - 1 == def_start.line and current_pos[2] < def_start.character then
          -- Before definition on same line
        elseif current_pos[1] - 1 == def_end.line and current_pos[2] > def_end.character then
          -- After definition on same line
        else
          return true
        end
      end
    end
  end

  return false
end

local function definition_or_usages(bufnr)
  local params = vim.lsp.util.make_position_params()
  local snacks = require("plugins.snacks")

  vim.lsp.buf_request(
    bufnr,
    "textDocument/definition",
    params,
    function(err, definitions)
      if err
          or not definitions
          or vim.tbl_isempty(definitions)
          or is_cursor_at_definition(definitions, bufnr) then
        -- no definitions found or on definition: show references
        snacks.snack_picker_or_else("lsp_references", vim.lsp.buf.references)()
        return
      else
        -- at usage: go to definition
        snacks.snack_picker_or_else("lsp_definitions", vim.lsp.buf.definition)()
      end
    end)
end

local function set_lsp_keymaps(client, bufnr)
  local function map(keys, func)
    vim.keymap.set("n", keys, func, { buffer = bufnr })
  end

  local snacks = require("plugins.snacks")

  -- navigation with dynamic snacks picker checking
  map("gD", snacks.snack_picker_or_else("lsp_declarations", vim.lsp.buf.declaration))
  map("gd", snacks.snack_picker_or_else("lsp_definitions", vim.lsp.buf.definition))
  map("gi", snacks.snack_picker_or_else("lsp_implementations", vim.lsp.buf.implementation))
  map("gr", snacks.snack_picker_or_else("lsp_references", vim.lsp.buf.references))
  map("gt", snacks.snack_picker_or_else("lsp_type_definitions", vim.lsp.buf.type_definition))

  map("<leader>ds", snacks.snack_picker_or_else("diagnostics", vim.diagnostic.setloclist))
  map("<leader>dw", snacks.snack_picker_or_else("diagnostics", vim.diagnostic.setqflist))

  -- IntelliJ CMD-B style: context-aware definition/usage navigation
  map("gb", function() definition_or_usages(bufnr) end)

  -- documentation
  map("<leader>k", vim.lsp.buf.signature_help)
  map("K", vim.lsp.buf.hover)

  -- actions
  map("<leader><cr>", vim.lsp.buf.code_action)
  map("<leader>ca", vim.lsp.buf.code_action)
  map("<leader>rn", vim.lsp.buf.rename)

  -- workspace management
  map("<leader>wa", vim.lsp.buf.add_workspace_folder)
  map("<leader>wr", vim.lsp.buf.remove_workspace_folder)

  -- diagnostics
  map("<leader>e", vim.diagnostic.open_float)
  map("<leader>q", vim.diagnostic.setloclist)

  -- workspace symbol search (IntelliJ CMD-O/CMD-N style)
  -- LSP SymbolKind enum: Class=5, Interface=11, Struct=23, Enum=10
  map("<leader>sy", snacks.snack_picker_or_else(
    function()
      Snacks.picker.lsp_workspace_symbols({ kinds = { 5, 10, 11, 23 } })
    end,
    function()
      vim.ui.input({ prompt = "Search types: " }, function(query)
        if query and query ~= "" then
          vim.lsp.buf.workspace_symbol(query)
        end
      end)
    end
  ))

  -- LSP SymbolKind enum: Function=12, Method=6, Constructor=9, Variable=13, Constant=14
  map("<leader>sf", snacks.snack_picker_or_else(
    function()
      Snacks.picker.lsp_workspace_symbols({ kinds = { 12, 6, 9, 13, 14 } })
    end,
    function()
      vim.ui.input({ prompt = "Search functions: " }, function(query)
        if query and query ~= "" then
          vim.lsp.buf.workspace_symbol(query)
        end
      end)
    end
  ))
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


local function find_lsp_executable(executable_name)
  if not executable_name then
    return nil
  end

  local function get_executable(path) return vim.fn.executable(path) == 1 and path or nil end

  local node_bin_path = vim.fn.findfile(
    "node_modules/.bin/" .. executable_name,
    vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h") .. ";" .. vim.fn.expand("~")
  )
  return get_executable(node_bin_path) or get_executable(executable_name)
end


local function enable_lsp(server_name, is_mason_managed)
  local ok, lsp_config = pcall(function() return vim.lsp.config[server_name] end)
  if not ok or not lsp_config or not lsp_config.cmd then
    -- bad and/or unknown server name, or error accessing config
    return
  end

  if #vim.lsp.get_clients({ name = server_name }) > 0 then
    -- already a running instance of the server
    return
  end

  if is_mason_managed then
    -- trust Mason to know what it's doing
    vim.lsp.enable(server_name)
    return
  end

  if vim.is_callable(lsp_config.cmd) then
    -- some LSPs have functions that start the server as their command, making it pretty much
    -- impossible to know what the server's actual command is. Thankfully, most servers that I care
    -- about in this bucket have the same executable name as their server name, so we use the server
    -- name to search for its presence
    if find_lsp_executable(server_name) then
      vim.lsp.enable(server_name)
    end

    return
  end

  local executable_name = lsp_config.cmd[1]
  local local_executable = find_lsp_executable(executable_name)
  if not local_executable then
    return
  end

  if local_executable ~= executable_name then
    -- replace the executable with the path found on the system
    local local_cmd = vim.tbl_extend("force", {}, lsp_config.cmd)
    local_cmd[1] = local_executable
    vim.lsp.config(server_name, { cmd = local_cmd })
  end

  vim.lsp.enable(server_name)
end


function M.setup_local_lsps()
  local registry = require("mason-registry")
  local mason_servers = registry.get_installed_package_names()
  for _, mason_spec in ipairs(registry.get_all_package_specs()) do
    local server_name = vim.tbl_get(mason_spec, "neovim", "lspconfig")
    if server_name ~= nil and server_name ~= "systemd_ls" then
      enable_lsp(server_name, vim.tbl_contains(mason_servers, mason_spec.name))
    end
  end
end

return M
