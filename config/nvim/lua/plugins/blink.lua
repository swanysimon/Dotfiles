local M = {}

function M.blink_opts()
  return {
      completion = {
        documentation = { auto_show = true, },
        list = {
          selection = {
            auto_insert = true,
            preselect = false,
          },
        },
      },
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "snippet_forward", "select_next", "fallback", },
        ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback", },
      },
      signature = { enabled = true, },
      snippets = { preset = "luasnip", },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", },
      },
    }
end

return M
