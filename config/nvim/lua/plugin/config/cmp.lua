local api = vim.api
local cmp_core = require("cmp")
local cmp = require("cmp").mapping


cmp_core.setup {
  mapping = {
    ["<c-n>"] = cmp.select_next_item(),
    ["<c-p>"] = cmp.select_prev_item(),
    ["<tab>"] = cmp.select_next_item(),
    ["<s-tab>"] = cmp.select_prev_item(),
    ["<c-space>"] = cmp.complete(),
    ["<cr>"] = cmp.confirm {
      behavior = cmp_core.ConfirmBehavior.Replace,
      select = true,
    },
    ["<c-d>"] = cmp.scroll_docs(-4),
    ["<c-f>"] = cmp.scroll_docs(4),
  },
  sources = {
    {name = "nvim_lsp"},
    {name = "nvim_lua"},
    {name = "cmdline"},
    {name = "buffer"},
    {name = "path"},
  },
}
