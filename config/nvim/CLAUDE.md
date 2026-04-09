# Neovim Configuration

This is Simon's personal Neovim configuration using Lua and the Lazy.nvim plugin manager.

## Project Structure

- `init.lua` - Core settings, keybindings, diagnostic config, bootstraps plugins
- `lua/plugins/init.lua` - Plugin specs, colorscheme table, Lazy.nvim setup
- `lua/plugins/*.lua` - Individual plugin configurations (opts, keys)
- `lua/lsp.lua` - LSP attach logic, keymaps, auto-format, inlay hints, folding
- `lua/autocmds.lua` - Auto commands (indentation, prose mode, treesitter, yank highlight)
- `lsp/*.lua` - Per-server LSP config files (loaded via Neovim 0.11 `vim.lsp.config`)

## Key Components

### Plugin Manager
- **Lazy.nvim** - Modern plugin manager with lazy loading
- Colorschemes managed separately with priority loading in `lua/plugins/init.lua`
- Currently using OneDark colorscheme (warmer variant)

### Core Plugins
- **LSP**: `mason-org/mason.nvim` + `neovim/nvim-lspconfig` (as dep) for language servers
- **Completion**: `saghen/blink.cmp` with LuaSnip snippets
- **Syntax**: `nvim-treesitter/nvim-treesitter` (branch=main) with context
- **UI**: `folke/snacks.nvim`, `folke/trouble.nvim`, `b0o/incline.nvim`, `j-hui/fidget.nvim`
- **Editing**: `kylechui/nvim-surround`, `andymass/vim-matchup`, `tpope/vim-commentary`
- **Commenting**: `JoosepAlviste/nvim-ts-context-commentstring` (context-aware)
- **Terminal**: `folke/snacks.nvim` terminal module (replaces nvzone/floaterm)
- **Clojure**: `Olical/conjure` (loaded on ft=clojure)
- **Lua dev**: `folke/lazydev.nvim` (loaded on ft=lua)
- **TODO comments**: `folke/todo-comments.nvim`
- **Colors**: `norcalli/nvim-colorizer.lua`
- **Structure view**: `stevearc/aerial.nvim` (LSP + Treesitter backends)
- **Testing**: `nvim-neotest/neotest` with adapters for Python, Jest, Rust
- **Rust**: `mrcjkb/rustaceanvim` (v^9, ft=rust) — manages rust-analyzer and DAP
- **Debugging**: `mfussenegger/nvim-dap` + `rcarriga/nvim-dap-ui` + `theHamsta/nvim-dap-virtual-text`

### Key Settings
- Leader key: `,` (comma)
- Local leader: `'` (apostrophe)
- 4-space indentation globally (`shiftwidth` and `tabstop`); 2-space override for lua, javascript, typescript, typescriptreact, json, yaml, clojure (via autocmd, sets both)
- LSP-based folding when server supports it, otherwise Treesitter-based folding
- Clipboard integration with system (`unnamed` + `unnamedplus`)
- Persistent undo (`undofile = true`); files stored in `~/.local/state/nvim/undo/`
- `updatetime = 300` for responsive document highlights

## Development Guidelines

### Adding Plugins
1. Add plugin spec to `lua/plugins/init.lua` in the `plugins` table (kept in alphabetical order by repo)
2. For complex plugins, create a separate config file in `lua/plugins/`
3. Use lazy loading when appropriate (`event`, `ft`, `keys`, `cmd`)
4. Include necessary dependencies

### Plugin Configuration Pattern
```lua
{
  "author/plugin-name",
  dependencies = { "required/dependency" },
  event = "VeryLazy",
  opts = require("plugins.plugin-name").plugin_opts(),
}
```

When `opts` would call `require()` on other plugins (e.g. neotest adapters), use `config` instead to defer evaluation until the plugin actually loads:
```lua
config = function()
  require("plugin").setup(require("plugins.plugin-name").plugin_opts())
end,
```

### LSP Configuration
- Uses Neovim 0.11 built-in `vim.lsp.config()` / `vim.lsp.enable()` APIs (not lspconfig `setup()`)
- `lua/lsp.lua` auto-discovers and enables all Mason-managed servers and locally-installed servers
- Local servers are found by searching up from the current buffer's directory (e.g. `node_modules/.bin/`)
- Per-server config files live in `lsp/<server_name>.lua` and are loaded automatically by Neovim 0.11
- Custom server settings: create `lsp/<server_name>.lua` returning a config table
- Diagnostic configuration in `init.lua` (errors as virtual lines, info/warn as virtual text)
- On LSP attach: keymaps set, format-on-save enabled, inlay hints enabled, document highlights enabled
- LSP folding (`vim.lsp.foldexpr()`) activated per-window when server supports `textDocument/foldingRange`
- **LSP keymaps call `Snacks.picker.*` directly** — no fallback abstraction; Snacks is always loaded (`lazy = false`)
- `rust_analyzer` is excluded from Mason auto-enable — rustaceanvim manages it instead
- Java LSP debug support is deferred; Clojure debugging goes through Conjure/nREPL

### Rust Configuration
- `mrcjkb/rustaceanvim` (v^9) replaces standalone rust-analyzer setup
- Provides LSP, DAP (via codelldb), and neotest adapter (`rustaceanvim.neotest`)
- Install `codelldb` via Mason for Rust debugging
- Do not create `lsp/rust_analyzer.lua` — configure rust-analyzer through rustaceanvim instead

### Debugging (nvim-dap)
- Currently configured for Python only; other languages can be added incrementally
- Python uses `debugpy` installed via Mason (`MasonInstall debugpy`)
- DAP UI opens/closes automatically when a session starts/ends
- Virtual text shows variable values inline while stepping
- To add a new language: install the adapter via Mason, add adapter config in `lua/plugins/dap.lua`

### Testing (neotest)
- Adapters: `neotest-python` (pytest), `neotest-jest` (Jest), `rustaceanvim.neotest` (cargo test)
- Java: use jdtls code lenses — no neotest adapter configured
- Clojure: use Conjure's built-in test commands (`\tr` run namespace, `\t!` run all)
- neotest loads on keybindings; adapters are required inside `config` (not `opts`) to avoid startup errors

### Keybinding Conventions
- Use `vim.keymap.set()` (aliased as `map` in `init.lua`)
- Window navigation: `<C-hjkl>`
- Visual block movement: `J/K` or arrow keys
- Plugin-specific keys defined in respective plugin files via `keys = require("plugins.X").X_keys()`
- Do not add `desc` parameters or comments to keybindings

### Keybindings Reference

#### Navigation
- `<C-hjkl>` - Window navigation
- `J/K`, `<Up>/<Down>` (visual) - Move visual block

#### File & Project Navigation (Snacks)
- `<leader>f` - Smart picker (buffers + files)
- `<leader>ff` - Find files
- `<leader>fg` - Find git files
- `<leader>fb` - Find buffers
- `<leader>fp` - Project explorer
- `<leader>ft` - Explorer in current file's directory
- `<leader>r` - Recent files

#### Search (Snacks)
- `<leader>ss` - Grep project (like IntelliJ Ctrl+Shift+F)
- `<leader>sw` - Grep word under cursor
- `<leader>st` - Search TODO comments

#### Structure & Symbols (Aerial)
- `<leader>o` - Toggle aerial structure panel
- `<leader>so` - Fuzzy search symbols in current file (Snacks aerial picker)

#### LSP Navigation
- `gd` - Go to definition(s)
- `gr` - Go to references/usages
- `gi` - Go to implementation(s)
- `gt` - Go to type definition(s)
- `gD` - Go to declaration(s)
- `gb` - Toggle between definition and usages (IntelliJ CMD-B style)

#### LSP Symbol Search
- `<leader>sy` - Search types/classes/interfaces/structs/enums in workspace
- `<leader>sf` - Search functions/methods/constructors/variables in workspace

#### LSP Actions & Docs
- `K` - Hover documentation
- `<leader>k` - Signature help
- `<leader><cr>` / `<leader>ca` - Code action
- `<leader>rn` - Rename symbol
- `<leader>wa` / `<leader>wr` - Add/remove workspace folder

#### Diagnostics
- `<leader>e` - Open float for current line diagnostics
- `<leader>q` - Send diagnostics to loclist
- `<leader>ds` - Show diagnostics for current buffer (Snacks picker)
- `<leader>dw` - Show diagnostics for workspace (Snacks picker)

#### Trouble
- `<leader>xx` - Toggle diagnostics (all)
- `<leader>xX` - Toggle diagnostics (current buffer)
- `<leader>cs` - Toggle symbols panel
- `<leader>cl` - Toggle LSP panel (right side)
- `<leader>xL` - Toggle loclist
- `<leader>xQ` - Toggle quickfix

#### Terminal
- `<leader>t` - Toggle floating terminal (normal, terminal, visual modes)
- `<leader>ai` - Toggle Claude Code terminal (persistent named session)

#### Testing (Neotest)
- `<leader>tt` - Run nearest test
- `<leader>tf` - Run test file
- `<leader>ts` - Toggle test summary panel
- `<leader>to` - Toggle test output panel
- `<leader>tl` - Re-run last test
- `]t` / `[t` - Jump to next/previous failed test

#### Debugging (DAP)
- `<F5>` - Continue / start debug session
- `<F10>` - Step over
- `<F11>` - Step into
- `<F12>` - Step out
- `<leader>db` - Toggle breakpoint
- `<leader>dB` - Conditional breakpoint
- `<leader>du` - Toggle DAP UI
- `<leader>dr` - Toggle REPL

## Common Tasks

### Installing New Language Server
1. Install via Mason UI (`:Mason`) or command (`:MasonInstall <server>`)
2. Server is auto-discovered and enabled on next restart
3. For custom settings, create `lsp/<server_name>.lua` returning a config table
4. Exception: rust-analyzer is managed by rustaceanvim, not Mason auto-enable

### Adding Python Debug Support
1. `:MasonInstall debugpy`
2. DAP is pre-configured to use Mason's debugpy path

### Adding Per-Server LSP Config
Create `lsp/<server_name>.lua`:
```lua
return {
  settings = {
    -- server-specific settings
  },
}
```
Neovim 0.11 loads these automatically via the `lsp/` directory on `runtimepath`.

### Adding Colorscheme
1. Add entry to `colorschemes` table in `lua/plugins/init.lua`
2. Set `active = true` for new scheme, `active = false` for others

### Updating Plugins
Run `:Lazy update` in Neovim

## File Locations
- Plugin data: `~/.local/share/nvim/lazy/`
- Lock file: `~/.local/share/nvim/lazy/lazy-lock.json`
- Undo history: `~/.local/state/nvim/undo/`

## Neovim Version Notes

### 0.11 Features in Use
- `vim.lsp.config(name, opts)` - configure LSP servers without lspconfig's `setup()`
- `vim.lsp.enable(name)` - enable a configured LSP server
- `lsp/` directory on runtimepath auto-loaded for per-server config
- `client:supports_method()` colon syntax (replaces dot syntax from 0.10)
- `vim.lsp.foldexpr()` - LSP-based folding expression
- `opt.foldtext = ""` - empty foldtext renders fold line with normal syntax highlighting

### 0.12 Features in Use
- None yet; config targets >= 0.11
